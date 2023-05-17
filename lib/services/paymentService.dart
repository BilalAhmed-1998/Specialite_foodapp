import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';


class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String secret ='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';
      //TEST 'sk_test_51JWNN2Gtvb5UXlRBapsj5WYfgYXSaPPFTA8N3E9rdbKWKepHTk2kcdHjKCHsk5BSBl8HbDgBowVHzVYeC9cbDjsX00RbijQGWh';
      //LIVE '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';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() async {
    Stripe.publishableKey ='pk_live_51JWNN2Gtvb5UXlRB1IqSh6hlKiTYvU4xaGzEzY73GZsMqX899hJOfqrgYcciaQ25nlaqruTlcH4fA8t7o9D9GObJ00OK3fQL6Q';
        //TEST 'pk_test_51JWNN2Gtvb5UXlRBu0HdNPLc4wr9Ezp76XGzqWEtOSHdxry6tBGYaR7amXqlmbw0CsStrNLKXBXr87DWs02vBLBm00qnimaBVa';
        //LIVE 'pk_live_51JWNN2Gtvb5UXlRB1IqSh6hlKiTYvU4xaGzEzY73GZsMqX899hJOfqrgYcciaQ25nlaqruTlcH4fA8t7o9D9GObJ00OK3fQL6Q'
    await Stripe.instance.applySettings();
  }

  static Future<StripeTransactionResponse> payWithNewCard(
      {String amount, String currency, CardDetails card}) async {
    try {
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      print(card);
      var paymentMethod = await StripeService()._createPaymentMethod(
          number: card.number,
          expMonth: card.expirationMonth,
          expYear: card.expirationYear,
          cvc: card.cvc
      );

      print(paymentMethod["id"]);
      print('processing payment...');

      var response = await StripeService().confirmPayment(
          pi_id: paymentIntent["id"],
          paymentMethod: paymentMethod["id"]
      );
      print(response["status"]);
      if (response["status"] == "succeeded") {
        return StripeTransactionResponse(
            message: "Transaction Successful", success: true);
      } else {
        return StripeTransactionResponse(
            message: "Transaction Failed", success: false);
      }
    } catch (err) {
      return StripeTransactionResponse(
          message: "Transaction Failed: ${err.toString()}", success: false);
    }
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      final response = await http.post(
          Uri.parse('${StripeService.apiBase}/payment_intents'),
          body: body,
          headers: StripeService.headers,
          encoding: Encoding.getByName("utf-8"));
      return jsonDecode(response.body);
    } catch (err) {
      print('error in stripe create payment intent:${err.toString()}');
    }
    return null;
  }

  Future<Map<String, dynamic>> _createCustomer() async {
    final String url = 'https://api.stripe.com/v1/customers';
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: {'description': 'new customer'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to register as a customer.';
    }
  }

  Future<Map<String, dynamic>> _createPaymentMethod(
      {String number, int expMonth, int expYear, String cvc}) async {
    const String url = 'https://api.stripe.com/v1/payment_methods';
    print("in createpayment");
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: {
        'type': 'card',
        'card[number]': '$number',
        'card[exp_month]': '$expMonth',
        'card[exp_year]': '$expYear',
        'card[cvc]': '$cvc',
      },
    );
    print("in after createpayment");
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to create PaymentMethod.';
    }
  }
  Future<Map<String, dynamic>> confirmPayment({pi_id, paymentMethod}) async {
    String url = 'https://api.stripe.com/v1/payment_intents/${pi_id}/confirm';
    print('Confirming Payment');
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: {
        'payment_method': paymentMethod
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to Confirm Payment.';
    }
  }

}
