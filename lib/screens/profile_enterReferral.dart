
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/dummyData.dart';
import 'package:specialite_foodapp/screens/profile_homepage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class profile_enterReferral extends StatefulWidget {
  static const routeName = '/profile_enterReferral';
  @override
  _profile_enterReferralState createState() => _profile_enterReferralState();
}

class _profile_enterReferralState extends State<profile_enterReferral> {
  String code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              AppLocalizations.of(context).enterReferral,
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
      body: Container(
        padding: EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            referralApplied?
            Text(
              'Referral Applied Successfully',
              style: TextStyle(
                color: Color(0xff121212),
                fontSize: 20.sp,
                fontFamily: 'regular',
                fontWeight: FontWeight.w700,
              ),
            )
            :Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25.h,
                ),
               Text(
                  'Enter referral code',
                  style: TextStyle(
                    color: Color(0xff121212),
                    fontSize: 20.sp,
                    fontFamily: 'regular',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  height: 60.h,
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
                  child: Center(
                    child: TextField(

                      onChanged: (text){
                        code=text;
                      },
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.symmetric(vertical: 10),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Enter referral code',
                        hintStyle: TextStyle(
                            color: const Color(0xff121212),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'regular'
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  AppLocalizations.of(context).youAndYourFriendWill ,
                  style: TextStyle(
                    color: Color(0xff555555),
                    fontSize: 14.sp,
                    fontFamily: 'regular',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            referralApplied ? Container() :InkWell(
              enableFeedback: true,
              onTap: () async {
                bool check=false;
                check = await dbMain.checkReferral(code, context);
                print(check);
                if (check){
                  await dbMain.updateFriends(code);
                  setState(() {
                    referralApplied=true;
                  });
                }
              },
              child: Container(
                height: 56.h,
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
                  color: const Color(0xffFDB601),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).apply,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'regular',
                      color: const Color(0xff121212),
                    ),
                  ),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
