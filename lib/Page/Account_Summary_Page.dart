import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/Transaction_History.dart';
import '../Services/AllData.dart';
import '../Services/dbHelper.dart';
import 'Main_Page.dart';

class AccountSummaryPage extends StatefulWidget {
  const AccountSummaryPage({super.key});

  @override
  State<AccountSummaryPage> createState() => _AccountSummaryPageState();
}

class _AccountSummaryPageState extends State<AccountSummaryPage> {
  List<TransactionHistory> dataList=[];

  var selectedStartDateWeekly=DateTime.now();
  var selectedEndDateWeekly=DateTime.now();

  var selectedStartDateMonthly=DateTime.now();
  var selectedEndDateMonthly=DateTime.now();

  var selectedStartDateYearly=DateTime.now();
  var selectedEndDateYearly=DateTime.now();

  double totalIncomeAll=0;
  double totalExpenseAll=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedStartDateWeekly=selectedStartDateWeekly.subtract(Duration(days: 7));
    selectedStartDateMonthly=selectedStartDateMonthly.subtract(Duration(days: 30));
    selectedStartDateYearly=selectedStartDateYearly.subtract(Duration(days: 365));
    selectAllData();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvokedWithResult: (didPop, result) {
          selectPage=0;
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
        },
        canPop: false,
        child: DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AllData.bgBlueColor,
          title: TabBar(
              indicatorColor: AllData.bgBlueFgColor,
              labelColor: AllData.bgBlueFgColor,
              tabs: [
                Tab(
                  text: "All",
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
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text("Date",style: TextStyle(color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Received",style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Paid",style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Savings",style: TextStyle(
                              color: AllData.bgBlueColor,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: selectAllData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(color: AllData.bgBlueColor,));
                      }else if(dataList.length==0){
                        return Center(child: Text("No Transaction",style: TextStyle(fontSize: 20,color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),);
                      }else{
                        return ListView.builder(
                          itemCount: dataList.length,
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
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text("${dataList[index].date}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        "${dataList[index].income}",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        "${dataList[index].expense}",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text("${dataList[index].income==0.0?"-${dataList[index].expense}":dataList[index].income}",style: TextStyle(
                                        color: dataList[index].income==0.0?Colors.red:Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        child: FutureBuilder(
                          future: dbHelper.getTotalIncomeAll(),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            return Container(
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black
                                  )
                              ),
                              child: Text(
                                "Total Cash In\n${snapshot.data}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: dbHelper.getTotalExpenseAll(),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            return Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black
                                  )
                              ),
                              child: Text(
                                "Total Cash Out\n${snapshot.data}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: dbHelper.getDiffrentIncomeAndExpenseAll(),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            return Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black
                                  )
                              ),
                              child: Text(
                                "Balance\n${snapshot.data}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },
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
                        setState(() {
                          selectedEndDateWeekly=selectedStartDateWeekly;
                          selectedStartDateWeekly = selectedStartDateWeekly.subtract(Duration(days: 7));
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
                        setState(() {
                          selectedStartDateWeekly=selectedEndDateWeekly;
                          selectedEndDateWeekly = selectedEndDateWeekly.add(Duration(days: 7));
                        });
                      }, icon: Icon(CupertinoIcons.right_chevron,color: AllData.bgBlueFgColor,)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text("Date",style: TextStyle(color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Received",style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Paid",style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Savings",style: TextStyle(
                              color: AllData.bgBlueColor,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: selectRangeData(startDate: selectedStartDateWeekly.toString().split(" ")[0],endDate: selectedEndDateWeekly.toString().split(" ")[0]),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(color: AllData.bgBlueColor,));
                      }else if(dataList.length==0){
                        return Center(child: Text("No Transaction",style: TextStyle(fontSize: 20,color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),);
                      }else{
                        return ListView.builder(
                          itemCount: dataList.length,
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
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text("${dataList[index].date}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        "${dataList[index].income}",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        "${dataList[index].expense}",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text("${dataList[index].income==0.0?"-${dataList[index].expense}":dataList[index].income}",style: TextStyle(
                                        color: dataList[index].income==0.0?Colors.red:Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        child: FutureBuilder(
                          future: dbHelper.getTotalIncomeRange(
                              startDate: selectedStartDateWeekly.toString()
                                  .split(" ")[0], endDate: selectedEndDateWeekly
                              .toString().split(" ")[0]),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            return Container(
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black
                                  )
                              ),
                              child: Text(
                                "Total Cash In\n${snapshot.data}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: dbHelper.getTotalExpenseRange(
                              startDate: selectedStartDateWeekly.toString()
                                  .split(" ")[0], endDate: selectedEndDateWeekly
                              .toString().split(" ")[0]),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            return Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black
                                  )
                              ),
                              child: Text(
                                "Total Cash Out\n${snapshot.data}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: dbHelper.getDiffrentIncomeAndExpenseRange(
                              startDate: selectedStartDateWeekly.toString()
                                  .split(" ")[0], endDate: selectedEndDateWeekly
                              .toString().split(" ")[0]),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            return Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black
                                  )
                              ),
                              child: Text(
                                "Balance\n${snapshot.data}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },
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
                        setState(() {
                          selectedStartDateMonthly = selectedStartDateMonthly.add(Duration(days: 30));
                          selectedEndDateMonthly = selectedEndDateMonthly.add(Duration(days: 30));
                        });
                      }, icon: Icon(CupertinoIcons.right_chevron,color: AllData.bgBlueFgColor,)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text("Date",style: TextStyle(color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Received",style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Paid",style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Savings",style: TextStyle(
                              color: AllData.bgBlueColor,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: selectRangeData(startDate: selectedStartDateMonthly.toString().split(" ")[0],endDate: selectedEndDateMonthly.toString().split(" ")[0]),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(color: AllData.bgBlueColor,));
                      }else if(dataList.length==0){
                        return Center(child: Text("No Transaction",style: TextStyle(fontSize: 20,color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),);
                      }else{
                        return ListView.builder(
                          itemCount: dataList.length,
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
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text("${dataList[index].date}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        "${dataList[index].income}",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        "${dataList[index].expense}",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text("${dataList[index].income==0.0?"-${dataList[index].expense}":dataList[index].income}",style: TextStyle(
                                        color: dataList[index].income==0.0?Colors.red:Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        child: FutureBuilder(
                          future: dbHelper.getTotalIncomeRange(
                              startDate: selectedStartDateMonthly.toString()
                                  .split(" ")[0],
                              endDate: selectedEndDateMonthly.toString().split(
                                  " ")[0]),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            return Container(
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black
                                  )
                              ),
                              child: Text(
                                "Total Cash In\n${snapshot.data}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: dbHelper.getTotalExpenseRange(
                              startDate: selectedStartDateMonthly.toString()
                                  .split(" ")[0],
                              endDate: selectedEndDateMonthly.toString().split(
                                  " ")[0]),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            return Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black
                                  )
                              ),
                              child: Text(
                                "Total Cash Out\n${snapshot.data}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: dbHelper.getDiffrentIncomeAndExpenseRange(
                              startDate: selectedStartDateMonthly.toString()
                                  .split(" ")[0],
                              endDate: selectedEndDateMonthly.toString().split(
                                  " ")[0]),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            return Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black
                                  )
                              ),
                              child: Text(
                                "Balance\n${snapshot.data}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },
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
                        setState(() {
                          selectedStartDateYearly= selectedStartDateYearly.subtract(Duration(days: 365));
                          selectedEndDateYearly= selectedEndDateYearly.subtract(Duration(days: 365));
                        });
                      }, icon: Icon(CupertinoIcons.left_chevron,color: AllData.bgBlueFgColor,)),
                      Text(
                        "${selectedStartDateYearly.day}-${selectedStartDateYearly.month}-${selectedStartDateYearly.year} TO ${selectedEndDateYearly.day}-${selectedEndDateYearly.month}-${selectedEndDateYearly.year}",
                        style: TextStyle(
                            color: AllData.bgBlueFgColor,
                            fontSize: 18
                        ),
                      ),
                      IconButton(onPressed: () {
                        setState(() {
                          selectedStartDateYearly = selectedStartDateYearly.add(Duration(days: 365));
                          selectedEndDateYearly = selectedEndDateYearly.add(Duration(days: 365));
                        });
                      }, icon: Icon(CupertinoIcons.right_chevron,color: AllData.bgBlueFgColor,)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text("Date",style: TextStyle(color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Received",style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Paid",style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Savings",style: TextStyle(
                              color: AllData.bgBlueColor,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: selectRangeData(startDate: selectedStartDateYearly.toString().split(" ")[0],endDate: selectedEndDateYearly.toString().split(" ")[0]),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(color: AllData.bgBlueColor,));
                      }else if(dataList.length==0){
                        return Center(child: Text("No Transaction",style: TextStyle(fontSize: 20,color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),);
                      }else{
                        return ListView.builder(
                          itemCount: dataList.length,
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
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text("${dataList[index].date}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        "${dataList[index].income}",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        "${dataList[index].expense}",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text("${dataList[index].income==0.0?"-${dataList[index].expense}":dataList[index].income}",style: TextStyle(
                                        color: dataList[index].income==0.0?Colors.red:Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        child: FutureBuilder(
                          future: dbHelper.getTotalIncomeRange(
                              startDate: selectedStartDateYearly.toString()
                                  .split(" ")[0],
                              endDate: selectedEndDateYearly.toString().split(
                                  " ")[0]),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            return Container(
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black
                                  )
                              ),
                              child: Text(
                                "Total Cash In\n${snapshot.data}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: dbHelper.getTotalExpenseRange(
                              startDate: selectedStartDateYearly.toString()
                                  .split(" ")[0],
                              endDate: selectedEndDateYearly.toString().split(
                                  " ")[0]),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            return Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black
                                  )
                              ),
                              child: Text(
                                "Total Cash Out\n${snapshot.data}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: dbHelper.getDiffrentIncomeAndExpenseRange(
                              startDate: selectedStartDateYearly.toString()
                                  .split(" ")[0],
                              endDate: selectedEndDateYearly.toString().split(
                                  " ")[0]),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            return Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black
                                  )
                              ),
                              child: Text(
                                "Balance\n${snapshot.data}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },
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
    )
    );
  }
  Future<List<TransactionHistory>> selectAllData() async {
    List tempData=await dbHelper.selectTransactionAll();
    dataList=tempData.map<TransactionHistory>((e) => TransactionHistory.fromJson(e),).toList();
    return dataList;
  }
  Future<List<TransactionHistory>> selectRangeData({required String startDate,required String endDate}) async {
    List tempData=await dbHelper.selectTransactionRange(startDate: startDate,endDate: endDate);
    dataList=tempData.map<TransactionHistory>((e) => TransactionHistory.fromJson(e),).toList();
    return dataList;
  }
}
