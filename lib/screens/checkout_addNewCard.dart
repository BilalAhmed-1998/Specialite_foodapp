import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:specialite_foodapp/services/paymentService.dart';
import 'package:specialite_foodapp/screens/homeScreen.dart';


class checkout_addNewCard extends StatefulWidget {
  static const routeName = '/checkout_addNewCard';
  double amount;
  checkout_addNewCard({this.amount});
  @override
  State<StatefulWidget> createState() {
    return _checkout_addNewCard();
  }
}

class _checkout_addNewCard extends State<checkout_addNewCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  OutlineInputBorder border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool check = false;

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffF0F3FD),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                height: 24.h,
                width: 24.w,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20.sp,
                ),
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              'Add New Card',
              style: TextStyle(
                color: const Color(0xff121212),
                fontSize: 18.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,

              ),
            ),

          ],
        ),
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: Colors.blue.shade900,
                backgroundImage: null,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                customCardTypeIcons: <CustomCardTypeIcon>[
                  CustomCardTypeIcon(
                    cardType: CardType.mastercard,
                    cardImage: Image.asset(
                      'assets/images/mastercard.png',
                      height: 48,
                      width: 48,
                    ),
                  ),
                ],
                cardType: CardType.mastercard,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        formKey: formKey,

                        obscureCvv: true,
                        obscureNumber: false,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: Colors.blue,
                        textColor: Colors.black,
                        cardNumberDecoration: InputDecoration(
                          labelText: 'Card Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          hintStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xfffdb601)),
                          ),
                          enabledBorder: border,
                        ),
                        cvvValidationMessage: "Enter valid cvv",
                        expiryDateDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xfffdb601)),
                          ),
                          enabledBorder: border,
                          labelText: 'Expiry Date',
                          hintText: 'MM/YY',
                        ),
                        cvvCodeDecoration: InputDecoration(

                          hintStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xfffdb601)),
                          ),
                          enabledBorder: border,
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xfffdb601)),
                          ),
                          enabledBorder: border,
                          labelText: 'Name of Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      CheckboxListTile(
                        title: Text('By saving your card you grant us your consent to store your payment method for future orders.',
                            style:TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12.sp,
                              color: Color(0xff555555),
                              fontFamily: 'poppins'
                            )),
                          activeColor: Color(0xfffdb601),
                          checkColor: Colors.black,
                          controlAffinity: ListTileControlAffinity.leading,

                          value: check,
                          onChanged: (bool value) {
                            setState(() {
                              check = value;
                            });
                          }

                          ),
                    ],
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  //width:width,
                  height: 56.h,
                  margin: EdgeInsets.all(12.w),
                  child: Center(
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'poppins',
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: !check
                        ? Color(0xfffdb601).withOpacity(0.3)
                        : Color(0xfffdb601),
                  ),
                ),
                onTap: !check
                    ? null
                    : () async {
                        if (formKey.currentState.validate()) {
                          print('valid!');

                          final date=expiryDate.split('/');
                          CardDetails _card=CardDetails(
                            number: cardNumber,
                            expirationMonth: int.parse(date[0]),
                              expirationYear: int.parse(date[1]),
                              cvc: cvvCode,

                          );
                          // _card.copyWith(number: cardNumber);
                          // _card.copyWith(expirationMonth: int.parse(date[0]));
                          // _card.copyWith(expirationYear: int.parse(date[1]));
                          // _card.copyWith(cvc: cvvCode);
                          print(_card);
                         dynamic response= await StripeService.payWithNewCard(
                             amount: (widget.amount.round()).toString(),
                             currency: 'JPY',
                             card: _card
                         );
                         print(response.message);


                          Navigator.pop(context);
                          Navigator.popUntil(context, (route) => false);
                          Navigator.pushNamed(context, homeScreen.routeName);
                        } else {
                          print('invalid!');
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
