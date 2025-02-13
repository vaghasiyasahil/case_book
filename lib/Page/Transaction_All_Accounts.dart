import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Model/Transaction_History.dart';
import '../Services/AllData.dart';
import '../Services/dbHelper.dart';
import 'Main_Page.dart';

class TransactionAllAccounts extends StatefulWidget {
  const TransactionAllAccounts({super.key});

  @override
  State<TransactionAllAccounts> createState() => _TransactionAllAccountsState();
}

class _TransactionAllAccountsState extends State<TransactionAllAccounts> {

  var selectedStartDateDaily=DateTime.now();
  var selectedEndDateDaily=DateTime.now();

  var selectedStartDateWeekly=DateTime.now();
  var selectedEndDateWeekly=DateTime.now();

  var selectedStartDateMonthly=DateTime.now();
  var selectedEndDateMonthly=DateTime.now();

  var selectedStartDateYearly=DateTime.now();
  var selectedEndDateYearly=DateTime.now();

  List<TransactionHistory> dataList=[];

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
    return PopScope(
        onPopInvokedWithResult: (didPop, result) {
          selectPage=0;
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
        },
        canPop: false,
        child: DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AllData.bgBlueColor,
          title: TabBar(
              onTap: (value) {
                setState(() {});
              },
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
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text("Date",style: TextStyle(color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text("Accounts",style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Amount",style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: dbHelper.selectTransactionAllUser(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(color: AllData.bgBlueColor,));
                      }else if(snapshot.data.isEmpty){
                        return Center(child: Text("No Transaction",style: TextStyle(fontSize: 20,color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),);
                      }else{
                        dataList=snapshot.data.map<TransactionHistory>((e) => TransactionHistory.fromJson(e),).toList();
                        print(snapshot.data);
                        print(dataList);
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
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${dataList[index].notes}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                        Text("${dataList[index].date}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                        Text("${dataList[index].time}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        "${dataList[index].userAcName}",
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
                                      child: Text("${dataList[index].income==0.0?dataList[index].expense:dataList[index].income}",style: TextStyle(
                                          color: dataList[index].income==0.0?Colors.red:Colors.green,
                                          fontWeight: FontWeight.bold
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
                          future: dbHelper.getTotalIncomeAllAllUser(),
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
                          future: dbHelper.getTotalExpenseAllAllUser(),
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
                          future: dbHelper.getDiffrentIncomeAndExpenseAllAllUser(),
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
                          selectedStartDateDaily = selectedStartDateDaily.subtract(Duration(days: 1));
                          selectedEndDateDaily = selectedEndDateDaily.subtract(Duration(days: 1));
                        });
                      }, icon: Icon(CupertinoIcons.left_chevron,color: AllData.bgBlueFgColor,)),
                      Text(
                        "${selectedStartDateDaily.day}-${selectedStartDateDaily.month}-${selectedStartDateDaily.year} TO ${selectedEndDateDaily.day}-${selectedEndDateDaily.month}-${selectedEndDateDaily.year}",
                        style: TextStyle(
                            color: AllData.bgBlueFgColor,
                            fontSize: 18
                        ),
                      ),
                      IconButton(onPressed: () {
                        setState(() {
                          selectedStartDateDaily = selectedStartDateDaily.add(Duration(days: 1));
                          selectedEndDateDaily = selectedEndDateDaily.add(Duration(days: 1));
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
                        flex: 3,
                        child: Text("Date",style: TextStyle(color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text("Accounts",style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Amount",style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: dbHelper.selectTransactionTodayUser(date: selectedStartDateDaily.toString().split(" ")[0]),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(color: AllData.bgBlueColor,));
                      }else if(snapshot.data.isEmpty){
                        return Center(child: Text("No Transaction",style: TextStyle(fontSize: 20,color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),);
                      }else{
                        dataList=snapshot.data.map<TransactionHistory>((e) => TransactionHistory.fromJson(e),).toList();
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
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${dataList[index].notes}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                        Text("${dataList[index].date}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                        Text("${dataList[index].time}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        "${dataList[index].userAcName}",
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
                                      child: Text("${dataList[index].income==0.0?dataList[index].expense:dataList[index].income}",style: TextStyle(
                                          color: dataList[index].income==0.0?Colors.red:Colors.green,
                                          fontWeight: FontWeight.bold
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
                          future: dbHelper.getTotalIncomeDailyAllUser(
                              date: selectedStartDateDaily.toString().split(
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
                          future: dbHelper.getTotalIncomeDailyAllUser(
                              date: selectedStartDateDaily.toString().split(" ")[0]),
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
                          future: dbHelper.getTotalIncomeDailyAllUser(
                              date: selectedStartDateDaily.toString().split(
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
                        flex: 3,
                        child: Text("Date",style: TextStyle(color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text("Accounts",style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Amount",style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: dbHelper.selectTransactionRangeUser(startDate: selectedStartDateWeekly.toString().split(" ")[0],endDate: selectedEndDateWeekly.toString().split(" ")[0]),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(color: AllData.bgBlueColor,));
                      }else if(snapshot.data.isEmpty){
                        return Center(child: Text("No Transaction",style: TextStyle(fontSize: 20,color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),);
                      }else{
                        dataList=snapshot.data.map<TransactionHistory>((e) => TransactionHistory.fromJson(e),).toList();
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
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${dataList[index].notes}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                        Text("${dataList[index].date}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                        Text("${dataList[index].time}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        "${dataList[index].userAcName}",
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
                                      child: Text("${dataList[index].income==0.0?dataList[index].expense:dataList[index].income}",style: TextStyle(
                                          color: dataList[index].income==0.0?Colors.red:Colors.green,
                                          fontWeight: FontWeight.bold
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
                          future: dbHelper.getTotalIncomeRangeAllUser(
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
                          future: dbHelper.getTotalExpenseRangeAllUser(
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
                          future: dbHelper.getDiffrentIncomeAndExpenseRangeAllUser(
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
                        setState(() {
                          selectedStartDateMonthly= selectedStartDateMonthly.subtract(Duration(days: 30));
                          selectedEndDateMonthly = selectedEndDateMonthly.subtract(Duration(days: 30));
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
                        flex: 3,
                        child: Text("Date",style: TextStyle(color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text("Accounts",style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Amount",style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: dbHelper.selectTransactionRangeUser(startDate: selectedStartDateMonthly.toString().split(" ")[0],endDate: selectedEndDateMonthly.toString().split(" ")[0]),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(color: AllData.bgBlueColor,));
                      }else if(snapshot.data.isEmpty){
                        return Center(child: Text("No Transaction",style: TextStyle(fontSize: 20,color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),);
                      }else{
                        dataList=snapshot.data.map<TransactionHistory>((e) => TransactionHistory.fromJson(e),).toList();
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
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${dataList[index].notes}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                        Text("${dataList[index].date}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                        Text("${dataList[index].time}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        "${dataList[index].userAcName}",
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
                                      child: Text("${dataList[index].income==0.0?dataList[index].expense:dataList[index].income}",style: TextStyle(
                                          color: dataList[index].income==0.0?Colors.red:Colors.green,
                                          fontWeight: FontWeight.bold
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
                          future: dbHelper.getTotalIncomeRangeAllUser(
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
                          future: dbHelper.getTotalExpenseRangeAllUser(
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
                          future: dbHelper.getDiffrentIncomeAndExpenseRangeAllUser(
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
                        flex: 3,
                        child: Text("Date",style: TextStyle(color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text("Accounts",style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text("Amount",style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: dbHelper.selectTransactionRangeUser(startDate: selectedStartDateYearly.toString().split(" ")[0],endDate: selectedEndDateYearly.toString().split(" ")[0]),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(color: AllData.bgBlueColor,));
                      }else if(snapshot.data.isEmpty){
                        return Center(child: Text("No Transaction",style: TextStyle(fontSize: 20,color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),);
                      }else{
                        dataList=snapshot.data.map<TransactionHistory>((e) => TransactionHistory.fromJson(e),).toList();
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
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${dataList[index].notes}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                        Text("${dataList[index].date}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                        Text("${dataList[index].time}",style: TextStyle(color: AllData.bgWhiteFgColor),),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        "${dataList[index].userAcName}",
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
                                      child: Text("${dataList[index].income==0.0?dataList[index].expense:dataList[index].income}",style: TextStyle(
                                          color: dataList[index].income==0.0?Colors.red:Colors.green,
                                          fontWeight: FontWeight.bold
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
                          future: dbHelper.getTotalIncomeRangeAllUser(
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
                          future: dbHelper.getTotalExpenseRangeAllUser(
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
                          future: dbHelper.getDiffrentIncomeAndExpenseRangeAllUser(
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
}
