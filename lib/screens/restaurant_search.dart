import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/classes/favourites_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../classes/allClasses.dart';
import '../dummyData.dart';
import 'favourite_detail.dart';

class restaurant_search extends StatefulWidget {
  static const routeName = '/restaurant_search';
  @override
  _restaurant_searchState createState() => _restaurant_searchState();
}

class _restaurant_searchState extends State<restaurant_search> {
  List<Restaurant> mainShowList=[];
  List<String> searches=[];

  void matchString(String query) {
    List<Restaurant> matchQuery = [];
    if (query!="") {

      for (var res in allRestaurants) {
        if (res.title.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(res);
        }
      }
    }
    setState(() {
      mainShowList = matchQuery;
    });
  }
  DateTime _selectedDay=DateTime.now();
  DateTime _focusedDay=DateTime.now();
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Scaffold(

      backgroundColor: Color(0xffF0F3FD),
      appBar: AppBar(
        elevation: 0.5,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color:const Color(0xff303030),
              size: 22.sp,
            ),
          ),
          title: CupertinoSearchTextField(
            autofocus: true,
            onChanged: (val) {
              matchString(val);
            },
            placeholderStyle:const TextStyle(
              color: Color(0xff555555),
            ),
            backgroundColor: const Color(0xffF0F3FD),
            borderRadius: BorderRadius.circular(8),
            placeholder: AppLocalizations.of(context).searchForShopRestaurants,
          )),
      body: Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                mainShowList.length!=0?'${mainShowList.length} restaurants found':'',//AppLocalizations.of(context).popSearch,

                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'poppins',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),

              ),
            ),
            SizedBox(height: 20.h,),
            mainShowList.isEmpty?
            Container(
              height: 26.h,
              width:width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for(var i in searches)
                    Container(
                      margin: EdgeInsets.only(right:10),
                      //width: 70.w,
                      decoration: BoxDecoration(
                        color:  Color(0xfffdb601),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                            '   $i   '
                        ),
                      ),
                    ),
                ],

              ),
            ):
            Flexible(
              child: ListView.builder(
                  itemCount: mainShowList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => favourite_detail(
                                restaurant: mainShowList[index],
                              ),
                            ));
                      },
                      child: favourites_card(fav: mainShowList[index]),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
