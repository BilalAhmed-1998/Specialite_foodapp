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
      //TEST'sk_test_51JWNN2Gtvb5UXlRBapsj5WYfgYXSaPPFTA8N3E9rdbKWKepHTk2kcdHjKCHsk5BSBl8HbDgBowVHzVYeC9cbDjsX00RbijQGWh';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() async {
    Stripe.publishableKey ='pk_live_51JWNN2Gtvb5UXlRB1IqSh6hlKiTYvU4xaGzEzY73GZsMqX899hJOfqrgYcciaQ25nlaqruTlcH4fA8t7o9D9GObJ00OK3fQL6Q';
        //TEST 'pk_test_51JWNN2Gtvb5UXlRBu0HdNPLc4wr9Ezp76XGzqWEtOSHdxry6tBGYaR7amXqlmbw0CsStrNLKXBXr87DWs02vBLBm00qnimaBVa';
    await Stripe.instance.applySettings();
  }

  static StripeTransactionResponse payViaExistingCard(
      {String amount, String currency, card}) {
    return StripeTransactionResponse(message: "transaction", success: true);
  }

  static Future<StripeTransactionResponse> payWithNewCard(
      {String amount, String currency, CardDetails card}) async {
    try {
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      // final billingDetails = BillingDetails(
      //   name: 'shaheer',
      //   email: 'email@stripe.com',
      //   phone: '+48888000888',
      //   address: Address(
      //     city: 'Houston',
      //     country: 'JP',
      //     line1: '1459  Circle Drive',
      //     line2: '',
      //     state: 'Tokyo',
      //     postalCode: '77063',
      //   ),
      // );
      //await Stripe.instance.dangerouslyUpdateCardDetails(card);
      print(card);
      var paymentMethod = await StripeService()._createPaymentMethod(
          number: card.number,
          expMonth: card.expirationMonth,
          expYear: card.expirationYear,
          cvc: card.cvc
      );

      print(paymentMethod["id"]);
      print('processing payment...');

      var response = await Stripe.instance.confirmPayment(
          paymentIntent['client_secret'],
          PaymentMethodParams.cardFromMethodId(
               paymentMethodData: paymentMethod["id"])
      );
      print(response.status);
      print(response);

      if (response.status == PaymentIntentsStatus.Succeeded) {
        return StripeTransactionResponse(
            message: "transaction successful", success: true);
      } else {
        return StripeTransactionResponse(
            message: "transaction failed", success: false);
      }
    } catch (err) {
      return StripeTransactionResponse(
          message: "transaction failed: ${err.toString()}", success: false);
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
}
