import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:specialite_foodapp/classes/allClasses.dart';
import 'package:specialite_foodapp/dummyData.dart';
import 'package:specialite_foodapp/screens/checkoutScreen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'loadingScreen.dart';

class orderScreen extends StatefulWidget {
  static const routeName = '/orderScreen';

  String restId;
  String appBarTitle;
  int noOfSeats;
  bool dineIn;
  List<Map<String, dynamic>> basicPriceMap;
  List<RestaurantItem> selectedItems;
  List<List<bool>> radiobools;

  orderScreen(
      {this.appBarTitle,
      this.selectedItems,
      this.noOfSeats,
      this.dineIn,
      this.restId}) {
    ///initializing maps (radio buttons)//

    int row = selectedItems.length;
    radiobools = List.generate(
        row, (i) => List.filled(selectedItems[i].lengthTimeCost, false),
        growable: false);

    basicPriceMap = [];

    for (var i = 0; i < row; i++) {
      ///by default last radio button is selected///
      radiobools[i][0] = true;

      basicPriceMap.add(selectedItems[i].timeCost);
    }
  }

  @override
  _orderScreenState createState() => _orderScreenState();
}

class _orderScreenState extends State<orderScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    mainCheckout = Provider.of<Checkout>(context, listen: false);

    return Scaffold(
      backgroundColor: Color(0xffF0F3FD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Provider.of<Checkout>(context, listen: false).orderSummary.clear();
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff303030),
            size: 22.sp,
          ),
        ),
        title: Text(
          widget.appBarTitle,
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 22.w),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: ToggleButtons(
                    borderRadius: BorderRadius.circular(8),
                    selectedColor: Colors.black,
                    fillColor: Color(0xffFdb601),
                    disabledColor: Colors.black,
                    borderColor: Colors.transparent,
                    isSelected: isSelected,
                    onPressed: (index) {
                      if (widget.dineIn) {
                        setState(() {
                          if (index == 1) {
                            isSelected[1] = true;
                            isSelected[0] = false;
                          } else {
                            isSelected[0] = true;
                            isSelected[1] = false;
                          }
                        });
                      }
                    },
                    children: [
                      ClipRRect(
                        child: SizedBox(
                          width: 171.w,
                          height: 40.h,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).dine,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 171.w,
                        height: 40.h,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).take,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 20.h,
              ),
              (widget.dineIn == true && isSelected[0] == true)
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
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 13.w),
                      width: 342.w,
                      //  height: 43.h,
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
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            widget.noOfSeats.toString(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 15.h,
              ),

              ///Calendar///
              _buildCalendar(),
              SizedBox(
                height: 20.h,
              ),

              ///Select Time Maps///
              for (var selectedItemNo = 0;
                  selectedItemNo < widget.selectedItems.length;
                  selectedItemNo++)
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                  margin: EdgeInsets.only(bottom: 20.h),
                  width: 342.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff0A0A0A).withOpacity(0.05),
                        spreadRadius: 0,
                        blurRadius: 12.sp,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context).selectTime,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            height: 20.h,
                            width: 66.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.5),
                              color: Color(0xfffdb601).withOpacity(.2),
                            ),
                            child: Center(
                              child: Text(
                                "1 Required",
                                style: TextStyle(
                                  color: Color(0xffff5252),
                                  fontSize: 8.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            width: 34.w,
                            height: 34.w,
                            child: Image.network(
                              widget.selectedItems[selectedItemNo].image,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            widget.selectedItems[selectedItemNo].itemTitle,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var radioNo = 0;
                              radioNo <
                                  widget.selectedItems[selectedItemNo]
                                      .lengthTimeCost;
                              radioNo++)
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                            toggleable: false,
                                            activeColor: Color(0xfffdb601),
                                            value: widget
                                                    .radiobools[selectedItemNo]
                                                [radioNo],
                                            groupValue: true,
                                            onChanged: (index) {
                                              setState(() {
                                                ///making all radio buttons unchecked
                                                for (var j = 0;
                                                    j <
                                                        widget.selectedItems
                                                            .length;
                                                    j++) {
                                                  for (var i = 0;
                                                      i <
                                                          widget
                                                              .selectedItems[j]
                                                              .lengthTimeCost;
                                                      i++) {
                                                    if (i != radioNo) {
                                                      widget.radiobools[j][i] =
                                                          false;
                                                    }
                                                  }
                                                }

                                                ///making selected one radio checked ///
                                                for (var j = 0;
                                                    j <
                                                        widget.selectedItems
                                                            .length;
                                                    j++) {
                                                  widget.radiobools[j]
                                                      [radioNo] = true;
                                                }
                                              });

                                              /// updating maincheckout for the timeslots///
                                              for (var j = 0;
                                                  j <
                                                      widget
                                                          .selectedItems.length;
                                                  j++) {
                                                mainCheckout.changeTimeSlot(
                                                    j,
                                                    widget.selectedItems[j]
                                                        .timeCost.keys
                                                        .elementAt(radioNo),
                                                    widget.selectedItems[j]
                                                        .timeCost.values
                                                        .elementAt(radioNo));
                                                mainCheckout
                                                    .calculateSubTotal();
                                              }
                                            }),
                                        Text(
                                          widget.selectedItems[selectedItemNo]
                                                  .timeCost.keys
                                                  .elementAt(radioNo) +
                                              ":00",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ]),
                                  (!widget.radiobools[selectedItemNo][radioNo])
                                      ? Text(
                                          "¥ " +
                                              formatter
                                                  .format(widget
                                                      .selectedItems[
                                                          selectedItemNo]
                                                      .timeCost
                                                      .values
                                                      .elementAt(radioNo))
                                                  .toString(),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey.shade700,
                                          ),
                                        )
                                      :

                                      ///add /// remove items buttons///
                                      Row(
                                          children: [
                                            Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (mainCheckout
                                                              .orderSummary[
                                                                  selectedItemNo]
                                                              .quantity >
                                                          1) {
                                                        mainCheckout
                                                            .decrementItemQuantity(
                                                                selectedItemNo);
                                                      }
                                                    },
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 20.w,
                                                        height: 20.h,
                                                        color:
                                                            Color(0xffd6d6d6),
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
                                                    builder: (context,
                                                            orderSummary,
                                                            child) =>
                                                        Text(
                                                          "${(orderSummary.orderSummary.isNotEmpty) ? orderSummary.orderSummary[selectedItemNo].quantity : "1"}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                SizedBox(
                                                  width: 12.w,
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: InkWell(
                                                    onTap: () {
                                                      mainCheckout
                                                          .incrementItemQuantity(
                                                              selectedItemNo);
                                                    },
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 20.w,
                                                        height: 20.h,
                                                        color:
                                                            Color(0xfffdb601),
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
                                            Text(
                                              "¥ " +
                                                  formatter
                                                      .format(widget
                                                          .selectedItems[
                                                              selectedItemNo]
                                                          .timeCost
                                                          .values
                                                          .elementAt(radioNo))
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                          ],
                                        )
                                ]),
                        ],
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 22.h),
        color: Colors.white,
        height: 79.h,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<Checkout>(
              builder: (context, orderSummary, child) => Text(
                "¥ ${formatter.format(orderSummary.subtotal)}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (isSelected[0]) {
                  mainCheckout.dineIn = true;
                } else if (isSelected[1]) {
                  mainCheckout.dineIn = false;
                }

                mainCheckout.dateTime = Timestamp.fromDate(_selectedDay);

                Navigator.pushNamed(context, checkoutScreen.routeName);
              },
              child: Container(
                height: 56.h,
                width: 178.w,
                decoration: BoxDecoration(
                  color: Color(0xfffdb601),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).cart,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildCalendar() {
    return Container(
      width: 342.w,
      height: 200.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff0A0A0A).withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 12.sp,
            offset: Offset(0, 4),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TableCalendar(
        locale: 'ja',
        focusedDay: _focusedDay,
        firstDay: DateTime.now(),
        lastDay: DateTime.utc(2025, 1, 1),
        shouldFillViewport: true,
        sixWeekMonthsEnforced: true,
        calendarFormat: CalendarFormat.week,
        daysOfWeekVisible: true,
        daysOfWeekHeight: 22,
        headerStyle: HeaderStyle(
            titleTextStyle: TextStyle(
              color: Colors.white,
            ),
            rightChevronVisible: false,
            formatButtonShowsNext: false,
            formatButtonVisible: false,
            // titleTextFormatter: DateTime.now().day,
            leftChevronIcon: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: Color(0xfffdb601),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text(
                        AppLocalizations.of(context).calendar,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    DateFormat('y年M月d日(E)', 'ja').format(_selectedDay),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xff555555),
                    ),
                  )
                ])),
        calendarStyle: CalendarStyle(
          selectedTextStyle: TextStyle(color: Colors.black),
          todayDecoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Color(0xfffdb601),
            shape: BoxShape.circle,

            //borderRadius: BorderRadius.circular(8),
          ),
        ),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) async {
          if (selectedDay.toString().substring(0, 10) !=
              _selectedDay.toString().substring(0, 10)) {
            print(DateFormat('y年M月d日(E)', 'ja').format(_selectedDay));

            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return loadingScreen();
                });

            ///truncating w.r.t doc ids yyyy-mm-dd///

            // String today = DateFormat('yyyy-m-dd').format(_selectedDay);
            String docId = selectedDay.toString().substring(0, 10);

            ///async function calling for changing timings of map///

            for (var i = 0; i < widget.selectedItems.length; i++) {
              dynamic timings = await dbMain.getSpecificDatePrices(
                  widget.restId, widget.selectedItems[i].dishId, docId);

              if (timings != false) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well

                  widget.selectedItems[i].timeCost = timings;

                  ///reseting radio buttons for new timings///

                  for (var radio = 0;
                      radio < widget.selectedItems[i].lengthTimeCost;
                      radio++) {
                    widget.radiobools[i][radio] = false;
                  }

                  ///making first radio button checked
                  widget.radiobools[i][0] = true;

                  ///updating notifier class for change in cost///
                  mainCheckout.changeTimeSlot(
                      i,
                      widget.selectedItems[i].timeCost.keys.elementAt(0),
                      widget.selectedItems[i].timeCost.values.elementAt(0));
                  mainCheckout.calculateSubTotal();
                });
              } else {
                print("false");
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well

                  widget.selectedItems[i].timeCost = widget.basicPriceMap[0];

                  ///reseting radio buttons for new timings///

                  for (var radio = 0;
                      radio < widget.selectedItems[i].lengthTimeCost;
                      radio++) {
                    widget.radiobools[i][radio] = false;
                  }

                  ///making first radio button checked
                  widget.radiobools[i][0] = true;

                  ///updating notifier class for change in cost///
                  mainCheckout.changeTimeSlot(
                      i,
                      widget.selectedItems[i].timeCost.keys.elementAt(0),
                      widget.selectedItems[i].timeCost.values.elementAt(0));
                  mainCheckout.calculateSubTotal();
                });
              }
            } //loop end//
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
