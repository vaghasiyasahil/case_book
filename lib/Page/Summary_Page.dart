import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Services/AllData.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {

  var selectedStartDateDaily=DateTime.now();
  var selectedEndDateDaily=DateTime.now();

  var selectedStartDateWeekly=DateTime.now();
  var selectedEndDateWeekly=DateTime.now();

  var selectedStartDateMonthly=DateTime.now();
  var selectedEndDateMonthly=DateTime.now();

  var selectedStartDateYearly=DateTime.now();
  var selectedEndDateYearly=DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedStartDateWeekly=selectedStartDateWeekly.subtract(Duration(days: 7));
    selectedStartDateMonthly=selectedStartDateMonthly.subtract(Duration(days: 30));
    selectedStartDateYearly=selectedStartDateYearly.subtract(Duration(days: 365));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AllData.bgBlueColor,
          title: TabBar(
              isScrollable: true,
              indicatorColor: AllData.bgBlueFgColor,
              labelColor: AllData.bgBlueFgColor,
              tabs: [
                Tab(
                  text: "All",
                ),
                Tab(
                  text: "Daily",
                ),
                Tab(
                  text: "Weekly",
                ),
                Tab(
                  text: "Monthly",
                ),
                Tab(
                  text: "Yearly",
                )
              ]
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Container(
                  color: AllData.bgBlueColor,
                  margin: EdgeInsets.all(5),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    "All",
                    style: TextStyle(
                        color: AllData.bgBlueFgColor,
                        fontSize: 20
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: AllData.bgWhiteColor,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: AllData.bgBlueColor,
                              )
                            ]
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text("Call Back"),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: AllData.bgBlueColor
                                        )
                                      )
                                    ),
                                    child: Text(
                                      "Total Income\n10000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: AllData.bgBlueColor
                                          )
                                      )
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Total Expense\n5000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Balance\n50000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: Text(
                            "Total Income\n10000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: Text(
                            "Total Expense\n5000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: Text(
                            "Balance\n5000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  color: AllData.bgBlueColor,
                  margin: EdgeInsets.all(5),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () {
                        selectedStartDateDaily = selectedStartDateDaily.subtract(Duration(days: 1));
                        selectedEndDateDaily = selectedEndDateDaily.subtract(Duration(days: 1));
                        setState(() {});
                      }, icon: Icon(CupertinoIcons.left_chevron,color: AllData.bgBlueFgColor,)),
                      Text(
                          "${selectedStartDateDaily.day}-${selectedStartDateDaily.month}-${selectedStartDateDaily.year} TO ${selectedEndDateDaily.day}-${selectedEndDateDaily.month}-${selectedEndDateDaily.year}",
                        style: TextStyle(
                            color: AllData.bgBlueFgColor,
                            fontSize: 18
                        ),
                      ),
                      IconButton(onPressed: () {
                        selectedStartDateDaily = selectedStartDateDaily.add(Duration(days: 1));
                        selectedEndDateDaily = selectedEndDateDaily.add(Duration(days: 1));
                        setState(() {});
                      }, icon: Icon(CupertinoIcons.right_chevron,color: AllData.bgBlueFgColor,)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: AllData.bgWhiteColor,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: AllData.bgBlueColor,
                              )
                            ]
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text("Call Back"),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: AllData.bgBlueColor
                                            )
                                        )
                                    ),
                                    child: Text(
                                      "Total Income\n10000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: AllData.bgBlueColor
                                            )
                                        )
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Total Expense\n5000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Balance\n50000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: Text(
                            "Total Income\n10000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: Text(
                            "Total Expense\n5000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: Text(
                            "Balance\n5000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  color: AllData.bgBlueColor,
                  margin: EdgeInsets.all(5),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () {
                        selectedEndDateWeekly=selectedStartDateWeekly;
                        selectedStartDateWeekly = selectedStartDateWeekly.subtract(Duration(days: 7));
                        setState(() {

                        });
                      }, icon: Icon(CupertinoIcons.left_chevron,color: AllData.bgBlueFgColor,)),
                      Text(
                        "${selectedStartDateWeekly.day}-${selectedStartDateWeekly.month}-${selectedStartDateWeekly.year} TO ${selectedEndDateWeekly.day}-${selectedEndDateWeekly.month}-${selectedEndDateWeekly.year}",
                        style: TextStyle(
                            color: AllData.bgBlueFgColor,
                            fontSize: 18
                        ),
                      ),
                      IconButton(onPressed: () {
                        selectedStartDateWeekly=selectedEndDateWeekly;
                        selectedEndDateWeekly = selectedEndDateWeekly.add(Duration(days: 7));
                        setState(() {

                        });
                      }, icon: Icon(CupertinoIcons.right_chevron,color: AllData.bgBlueFgColor,)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: AllData.bgWhiteColor,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: AllData.bgBlueColor,
                              )
                            ]
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text("Call Back"),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: AllData.bgBlueColor
                                            )
                                        )
                                    ),
                                    child: Text(
                                      "Total Income\n10000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: AllData.bgBlueColor
                                            )
                                        )
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Total Expense\n5000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Balance\n50000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: Text(
                            "Total Income\n10000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: Text(
                            "Total Expense\n5000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: Text(
                            "Balance\n5000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  color: AllData.bgBlueColor,
                  margin: EdgeInsets.all(5),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () {
                        selectedStartDateMonthly= selectedStartDateMonthly.subtract(Duration(days: 30));
                        selectedEndDateMonthly = selectedEndDateMonthly.subtract(Duration(days: 30));
                        setState(() {

                        });
                      }, icon: Icon(CupertinoIcons.left_chevron,color: AllData.bgBlueFgColor,)),
                      Text(
                        "${selectedStartDateMonthly.day}-${selectedStartDateMonthly.month}-${selectedStartDateMonthly.year} TO ${selectedEndDateMonthly.day}-${selectedEndDateMonthly.month}-${selectedEndDateMonthly.year}",
                        style: TextStyle(
                            color: AllData.bgBlueFgColor,
                            fontSize: 18
                        ),
                      ),
                      IconButton(onPressed: () {
                        selectedStartDateMonthly = selectedStartDateMonthly.add(Duration(days: 30));
                        selectedEndDateMonthly = selectedEndDateMonthly.add(Duration(days: 30));
                        setState(() {

                        });
                      }, icon: Icon(CupertinoIcons.right_chevron,color: AllData.bgBlueFgColor,)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: AllData.bgWhiteColor,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: AllData.bgBlueColor,
                              )
                            ]
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text("Call Back"),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: AllData.bgBlueColor
                                            )
                                        )
                                    ),
                                    child: Text(
                                      "Total Income\n10000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: AllData.bgBlueColor
                                            )
                                        )
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Total Expense\n5000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Balance\n50000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: Text(
                            "Total Income\n10000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: Text(
                            "Total Expense\n5000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: Text(
                            "Balance\n5000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  color: AllData.bgBlueColor,
                  margin: EdgeInsets.all(5),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () {
                        selectedStartDateYearly= selectedStartDateYearly.subtract(Duration(days: 365));
                        selectedEndDateYearly= selectedEndDateYearly.subtract(Duration(days: 365));
                        setState(() {});
                      }, icon: Icon(CupertinoIcons.left_chevron,color: AllData.bgBlueFgColor,)),
                      Text(
                        "${selectedStartDateYearly.day}-${selectedStartDateYearly.month}-${selectedStartDateYearly.year} TO ${selectedEndDateYearly.day}-${selectedEndDateYearly.month}-${selectedEndDateYearly.year}",
                        style: TextStyle(
                            color: AllData.bgBlueFgColor,
                            fontSize: 18
                        ),
                      ),
                      IconButton(onPressed: () {
                        selectedStartDateYearly = selectedStartDateYearly.add(Duration(days: 365));
                        selectedEndDateYearly = selectedEndDateYearly.add(Duration(days: 365));
                        setState(() {});
                      }, icon: Icon(CupertinoIcons.right_chevron,color: AllData.bgBlueFgColor,)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: AllData.bgWhiteColor,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: AllData.bgBlueColor,
                              )
                            ]
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text("Call Back"),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: AllData.bgBlueColor
                                            )
                                        )
                                    ),
                                    child: Text(
                                      "Total Income\n10000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: AllData.bgBlueColor
                                            )
                                        )
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Total Expense\n5000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Balance\n50000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: Text(
                            "Total Income\n10000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: Text(
                            "Total Expense\n5000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: Text(
                            "Balance\n5000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
