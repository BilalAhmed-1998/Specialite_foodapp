import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:specialite_foodapp/main.dart';
import 'package:specialite_foodapp/screens/checkout_chooseExisting.dart';
import 'package:specialite_foodapp/screens/checkout_paymentSelection.dart';
import 'package:specialite_foodapp/screens/profile_homepage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../classes/allClasses.dart';
import '../dummyData.dart';
import '../services/wrapper.dart';
import 'loadingScreen.dart';
import 'package:specialite_foodapp/screens/homeScreen.dart';

class checkoutScreen extends StatefulWidget {
  // const checkoutScreen({Key? key}) : super(key: key);
  static const routeName = '/checkoutScreen';

  @override
  _checkoutScreenState createState() => _checkoutScreenState();
}

class _checkoutScreenState extends State<checkoutScreen> {
  TextEditingController promoController = TextEditingController();
  showAlertDialog(BuildContext context, String promoText, dynamic _discount) {
    // set up the button
    Widget okButton =
    TextButton(
      child: Text("Continue"),
      onPressed: () async {
        Navigator.pop(context);
        if (((mainCheckout.subtotal +
                    (tax * mainCheckout.subtotal / 100) +
                    (serviceFee * mainCheckout.subtotal / 100)) -
                _discount) >
            50) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => checkout_paymentSelection(
                amount: ((mainCheckout.subtotal +
                            (tax * mainCheckout.subtotal / 100) +
                            (serviceFee * mainCheckout.subtotal / 100)) -
                        _discount)
                    .truncate(),
              ),
            ),
          );
        } else if (((mainCheckout.subtotal +
                    (tax * mainCheckout.subtotal / 100) +
                    (serviceFee * mainCheckout.subtotal / 100)) -
                _discount) <=
            0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('order placed successfully'),
              duration: Duration(seconds: 2),
            ),
          );

          await dbMain.updateOrders(
            Order(
              orderId: DateTime.now().toString() +
                  FirebaseAuth.instance.currentUser.uid,
              resturauntId: mainCheckout.restUid,
              customerId: FirebaseAuth.instance.currentUser.uid,
              dateTime: Timestamp.now(),
              dineIn: mainCheckout.dineIn,
              subtotal: 0,
              seats: mainCheckout.dineIn ? mainCheckout.seatsLeft : 0,
              status: 'onGoing',
              orderSummary: mainCheckout.orderSummary,
            ),
          );
          if (refCheckoutInfo[0]){
            await dbMain.decrementBonus(refCheckoutInfo[1], context);
          }

          Navigator.popUntil(context, (route) => false);
          Navigator.pushNamed(context, homeScreen.routeName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Minimium order amount is ¥ 50")));
        }
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Promo"),
      content: Container(
        child: Text(promoText +
            '\nYou will be charged: ${((mainCheckout.subtotal + (tax * mainCheckout.subtotal / 100) + (serviceFee * mainCheckout.subtotal / 100)) - _discount).truncate()<=0? 0 : ((mainCheckout.subtotal + (tax * mainCheckout.subtotal / 100) + (serviceFee * mainCheckout.subtotal / 100)) - _discount).truncate()}'),
      ),
      actions: [
        cancelButton,
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    mainCheckout = Provider.of<Checkout>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xffF0F3FD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            //Provider.of<Checkout>(context, listen: false).orderSummary.clear();
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff303030),
            size: 22.sp,
          ),
        ),
        title: Text(
          AppLocalizations.of(context).checkout,
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 16.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ImageIcon(
                              AssetImage("assets/images/paper.png"),
                              color: Color(0xFFfdb601),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              AppLocalizations.of(context).orderSummary,
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontFamily: "regular",
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "  " +
                              DateFormat('yyyy年 MMMM dEE', 'ja')
                                  .format(mainCheckout.dateTime.toDate()) +
                              "（木）" +
                              DateFormat.Hm()
                                  .format(mainCheckout.dateTime.toDate()),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        for (var selectedItemNo = 0;
                            selectedItemNo < mainCheckout.orderSummary.length;
                            selectedItemNo++)
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // color: Colors.amber,
                                  width: 140.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 8.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        width: 24.w,
                                        height: 24.w,
                                        child: Image.network(
                                          mainCheckout
                                              .orderSummary[selectedItemNo]
                                              .image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Text(
                                        mainCheckout
                                            .orderSummary[selectedItemNo].title
                                            .split(' ')
                                            .first,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: InkWell(
                                        onTap: () {
                                          if (mainCheckout
                                                  .orderSummary[selectedItemNo]
                                                  .quantity >
                                              1) {
                                            mainCheckout.decrementItemQuantity(
                                                selectedItemNo);
                                          }
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: 20.w,
                                            height: 20.h,
                                            color: Color(0xffd6d6d6),
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.black,
                                              size: 15.sp,
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Consumer<Checkout>(
                                        builder: (context, orderSummary,
                                                child) =>
                                            Text(
                                              "${(orderSummary.orderSummary.isNotEmpty) ? orderSummary.orderSummary[selectedItemNo].quantity : "1"}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: InkWell(
                                        onTap: () {
                                          mainCheckout.incrementItemQuantity(
                                              selectedItemNo);
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: 20.w,
                                            height: 20.h,
                                            color: Color(0xfffdb601),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.black,
                                              size: 15.sp,
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                  ],
                                ),
                                Container(
                                  //color: Colors.amber,
                                  alignment: Alignment.centerRight,
                                  width: 70,
                                  child: Consumer<Checkout>(
                                    builder: (context, orderSummary, child) =>
                                        Text(
                                      "¥ " +
                                          (mainCheckout
                                                      .orderSummary[
                                                          selectedItemNo]
                                                      .price *
                                                  orderSummary
                                                      .orderSummary[
                                                          selectedItemNo]
                                                      .quantity)
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey.shade700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ]),
                        Divider(
                          height: 30.h,
                          thickness: 1,
                        ),

                        ///subtotal///
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context).subtotal,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Consumer<Checkout>(
                              builder: (context, orderSummary, child) => Text(
                                "¥ " + orderSummary.subtotal.toString(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xff555555),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 35.h,
                          thickness: 1,
                        ),

                        ///service fee///
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context).serviceFee,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text(
                              "${serviceFee.toInt()} %",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Color(0xff555555),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),

                        ///Tax fee///
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context).tax,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text(
                              "${tax.toInt()} %",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Color(0xff555555),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  ///total cost///
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xfffdb601),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                    width: 342.w,
                    height: 37.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context).total,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Consumer<Checkout>(
                          builder: (context, orderSummary, child) => Text(
                            "¥ " +
                                (orderSummary.subtotal +
                                        (tax * orderSummary.subtotal / 100) +
                                        (serviceFee *
                                            orderSummary.subtotal /
                                            100))
                                    .truncate()
                                    .toString(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///Dine In Seats///
            (mainCheckout.dineIn)
                ? Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff0A0A0A).withOpacity(0.05),
                          spreadRadius: 0,
                          blurRadius: 12.sp,
                          offset: Offset(0, 4),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.fromLTRB(13.w, 10.h, 0, 10.h),
                    width: 342.w,
                    // height: 43.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ImageIcon(
                              AssetImage("assets/images/seat.png"),
                              color: Color(0xFFfdb601),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Center(
                              child: Text(
                                AppLocalizations.of(context).seats,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: InkWell(
                                onTap: () {
                                  mainCheckout.decrementSeats();
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 20.w,
                                    height: 20.h,
                                    color: Color(0xffd6d6d6),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                      size: 15.sp,
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Consumer<Checkout>(
                                builder: (context, orderSummary, child) => Text(
                                      orderSummary.seatsLeft.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                            SizedBox(
                              width: 12.w,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: InkWell(
                                onTap: () {
                                  mainCheckout.incrementSeats();
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 20.w,
                                    height: 20.h,
                                    color: Color(0xfffdb601),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 15.sp,
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(height: 10.h),

            ///promo code field///
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context).enterPromo,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              height: 56.h,
              margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 0.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: TextField(
                controller: promoController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hoverColor: Colors.white,
                    focusColor: Colors.white,
                    fillColor: Colors.transparent,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Color(0xffFDB601), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    hintText: AppLocalizations.of(context).enterGetBenifits,
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff121212).withOpacity(0.5),
                    )),
              ),
            ),
            // SizedBox(height: 132.h,),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 22.h),
          color: Colors.white,
          width: width,
          height: 85.h,
          child: Container(
            width: 342.w,
            height: 26.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                onSurface: Color(0xffFdb601),
                primary: Color(0xffFdb601),
              ),
              onPressed: () async {
                if (FirebaseAuth.instance.currentUser != null) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return loadingScreen();
                      });
                  refCheckoutInfo = await dbMain.checkReferralBonus(context);
                  if (promoController.text.length > 1) {
                    dynamic promo =
                        await dbMain.checkPromo(promoController.text);
                    Navigator.pop(context);
                    if (promo > 0) {
                      showAlertDialog(
                          context,
                          'discount applied${refCheckoutInfo[0] ? '(referral+promo)' : ''}: ${promo + (refCheckoutInfo[0] ? 500 : 0)}',
                          promo + (refCheckoutInfo[0] ? 500 : 0));
                    } else if (promo == -1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Promo Expired")));
                    } else if (promo == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Invalid Promo code")));
                    }
                  } else {
                    Navigator.pop(context);
                    showAlertDialog(
                        context,
                        refCheckoutInfo[0] ? 'referral discount: ¥500 ' : '',
                        (refCheckoutInfo[0] ? 500 : 0));
                  }
                }

                ///if not log in then///
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("を利用するためには、ログインが必要です。")));
                  Navigator.pushNamedAndRemoveUntil(
                      context, Wrapper.routeName, (route) => false);
                  Provider.of<Checkout>(context, listen: false)
                      .orderSummary
                      .clear();
                }
              },
              child: Center(
                child: Text(
                  AppLocalizations.of(context).submit,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
