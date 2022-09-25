import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/classes/orderHistoryCard.dart';
import 'package:specialite_foodapp/dummyData.dart';
import 'package:specialite_foodapp/screens/checkoutScreen2.dart';
import 'package:specialite_foodapp/screens/profile_homepage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class profile_order extends StatefulWidget {
  static const routeName = '/profile_order';
  @override
  _profile_orderState createState() => _profile_orderState();
}

class _profile_orderState extends State<profile_order> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,

        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title:
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.popAndPushNamed(context, profile_homepage.routeName);
              },
              child: SizedBox(
                height: 24.h,
                width: 24.w,
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              AppLocalizations.of(context).orders,
              style: TextStyle(
                color: const Color(0xff121212),
                fontSize: 18.sp,
                fontFamily: 'regular',
                fontWeight: FontWeight.w500,

              ),
            ),

          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 0.h),
          child: Column(
        //    mainAxisAlignment: ,
            children: [
              ///On Going Order///
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                height: 51.h,
                width: 342.w,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xfffdb601)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff8a959e).withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 40,
                      offset: const Offset(0,8),

                    )],
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,

                ),
                child: Row(
                  children: [
                    Icon(Icons.timer_outlined,
                    size: 24.sp,
                    color: Color(0xfffdb601),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),

                    Text(
                      AppLocalizations.of(context).ongoingOrders,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'regular',
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff121212),
                      ),

                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),

              ///All ongoing orders will be shown below///
              for(var i=0;i<ongoingOrders.length;i++)
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => checkoutScreen2(
                        order: ongoingOrders[i],
                      )
                    ),
                  );

                },
                  child: orderHistoryCard(order: ongoingOrders[i],)),



              ///ORDER HISTORY///
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                height: 51.h,
                width: 342.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff8a959e).withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 40,
                      offset: const Offset(0,8),

                    )],
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,

                ),
                child: Row(
                  children: [
                    ImageIcon(
                      AssetImage("assets/images/pro14.png"),
                      color: Color(0xFFFDB601),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      AppLocalizations.of(context).orderHistory,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'regular',
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff121212),
                      ),

                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),

              ///All recent orders will be shown below///
              for(var i=0;i<orderHistory.length;i++)
              orderHistoryCard(order: orderHistory[i]),

            ],
          ),
        ),
      ),
    );
  }
}
