import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:specialite_foodapp/classes/allClasses.dart';
import 'package:specialite_foodapp/classes/restaurantItemCard.dart';
import 'package:specialite_foodapp/dummyData.dart';
import 'package:specialite_foodapp/screens/orderScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class restaurantDetailScreen extends StatefulWidget {
  //const restaurantDetailScreen({Key? key}) : super(key: key);
  static const routeName = '/restaurantDetailScreen';
  Restaurant restaurant;
  List<bool> isSelectedItems;
  restaurantDetailScreen({this.restaurant}) {
    this.isSelectedItems =
        List.filled(this.restaurant.restaurantItems.length, false);
  }
  @override
  _restaurantDetailScreenState createState() => _restaurantDetailScreenState();
}

class _restaurantDetailScreenState extends State<restaurantDetailScreen> {
  bool isDisabledButton = true;
  @override
  Widget build(BuildContext context) {
    mainCheckout=Provider.of<Checkout>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff303030),
            size: 22.sp,
          ),
        ),
        title: Text(
          this.widget.restaurant.title,
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            child: Stack(
              children: [
                Container(
                  color: Colors.transparent,
                  height: 240.h, //height / 3.5,
                  width: width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.restaurant.images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 239.h,
                          width: width,
                          child: Stack(children: [
                            Positioned.fill(
                              child: Image.network(this.widget.restaurant.images[index],
                                fit: BoxFit.fill,),
                            ),

                          ]),
                        );
                      }),
                ),
                Container(
                  width: width,
                  //height: height,

                  decoration: BoxDecoration(
                    color: Color(0xffF0F3FD),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 225.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              this.widget.restaurant.title,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            InkWell(
                                onTap: () async{

                                  if(FirebaseAuth.instance.currentUser!=null){

                                    setState(() {
                                      widget.restaurant.favt =
                                      !widget.restaurant.favt;
                                    });

                                    if(widget.restaurant.favt){
                                      await dbMain.updateFavtList(widget.restaurant.uid);
                                    }
                                    else{
                                      await dbMain.deleteFavtList(widget.restaurant.uid);
                                    }

                                  }
                                  else{
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(content: Text("を利用するためには、ログインが必要です。")));
                                  }



                                },
                                child: (!widget.restaurant.favt)
                                    ? Icon(
                                        Icons.favorite_border_outlined,
                                      )
                                    : Icon(
                                        Icons.favorite,
                                        color: Color(0xffff5252),
                                      )),
                          ]),
                      Container(
                        width: 170.w,
                        child: Text(
                          this.widget.restaurant.description,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          SmoothStarRating(
                            allowHalfRating: true,
                            onRated: (v) {},
                            starCount: 5,
                            rating: this.widget.restaurant.rating,
                            isReadOnly: true,
                            size: 20.sp,
                            color: Color(0xffFdb601),
                            borderColor: Colors.black,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            "+" +
                                widget.restaurant.totalRating
                                    .truncate()
                                    .toString() +
                                " ratings",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 19.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 20.sp,
                            color: Color(0xfffdb601),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Flexible(
                            flex: 1,
                            child: Text(
                              this.widget.restaurant.address,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            size: 20.sp,
                            color: Color(0xfffdb601),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            this.widget.restaurant.open
                                ? "Open now"
                                : "Close now",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 28.h,
                      ),
                      Text(
                        AppLocalizations.of(context).popularItems,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      for (var i = 0;
                          i < this.widget.restaurant.restaurantItems.length;
                          i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ToggleButtons(
                            borderWidth: 1.5,
                            borderColor: Colors.transparent,
                            selectedBorderColor: Color(0xffFdb601),
                            direction: Axis.vertical,
                            borderRadius: BorderRadius.circular(8),
                            children: [
                              restaurantItemCard(
                                restaurantItem:
                                    this.widget.restaurant.restaurantItems[i],
                              ),
                            ],
                            isSelected: [this.widget.isSelectedItems[i]],
                            onPressed: (itemNo) {
                              setState(() {
                                widget.isSelectedItems[i] =
                                    !widget.isSelectedItems[i];
                                if (widget
                                    .isSelectedItems
                                    .contains(true)) {
                                  isDisabledButton = false;
                                } else {
                                  this.isDisabledButton = true;
                                }
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
      Container(
          padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 22.h),
          color: Colors.white,
          width: width,
          height: 85.h,
          child:
          Container(

            width: 342.w,
            height: 26.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                onSurface: Color(0xffFdb601),
                primary: Color(0xffFdb601),
              ),
              onPressed: (!isDisabledButton && widget.restaurant.open)?(){

                List <RestaurantItem> tempList=[];

                mainCheckout.dineIn = widget.restaurant.dineIn;
                mainCheckout.seatsLeft = 1;
                mainCheckout.totalSeats = widget.restaurant.seatsLeft;
                mainCheckout.restUid = widget.restaurant.uid;

               // mainCheckout.dateTime = DateTime.now();

                for(var i=0;i<widget.restaurant.restaurantItems.length;i++) {
                  if (widget.isSelectedItems[i] == true) {

                    tempList.add(widget.restaurant.restaurantItems[i]);

                    mainCheckout.orderSummary.add(CheckoutItems(
                        image: widget.restaurant.restaurantItems[i].image,
                        title:  widget.restaurant.restaurantItems[i].itemTitle,
                        price: widget.restaurant.restaurantItems[i].timeCost.values.elementAt(0),
                        time:  widget.restaurant.restaurantItems[i].timeCost.keys.elementAt(0),
                        quantity: 1
                    ));
                  }
                }



                mainCheckout.calculateSubTotal();

                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) =>
                          orderScreen(
                            appBarTitle: widget.restaurant.title,
                            noOfSeats: widget.restaurant.seatsLeft,
                            dineIn: widget.restaurant.dineIn,
                            selectedItems:  tempList)),);

              }:null,
              child: Center(
                child: Text(
                  AppLocalizations.of(context).cont,
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
