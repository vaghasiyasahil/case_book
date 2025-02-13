import 'package:case_book/Model/Accounts.dart';
import 'package:case_book/Page/Main_Page.dart';
import 'package:case_book/Services/AllData.dart';
import 'package:case_book/Services/dbHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  String fromAC="Select Account";
  String toAC="Select Account";
  List accountList=[];
  TextEditingController balance=TextEditingController();
  TextEditingController notes=TextEditingController();
  String date=DateTime.now().toString().split(" ")[0];
  String time="${DateTime.now().hour}:${DateTime.now().minute} ${DateTime.now().hour>=12?'PM':'AM'}";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAccountList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        selectPage=0;
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
      },
      canPop: false,
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(child: Text("Amount:",style: TextStyle(fontSize: 20),)),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: balance,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: AllData.bgBlueColor,
                      decoration: InputDecoration(
                        hintText: "0",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AllData.bgBlueColor
                            )
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AllData.bgBlueColor,
                              style: BorderStyle.none
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(child: Text("From:",style: TextStyle(fontSize: 20),)),
                  ),
                  Expanded(
                    flex: 3,
                    child: DropdownButtonHideUnderline(
                      child: GFDropdown(
                        borderRadius: BorderRadius.circular(10),
                        border: const BorderSide(
                            color: Colors.black12, width: 1),
                        dropdownButtonColor: Colors.grey[300],
                        value: fromAC,
                        onChanged: (newValue) {
                          setState(() {
                            fromAC = newValue.toString();
                          });
                        },
                        items: accountList
                            .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                            .toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(child: Text("To:",style: TextStyle(fontSize: 20),)),
                  ),
                  Expanded(
                    flex: 3,
                    child: DropdownButtonHideUnderline(
                      child: GFDropdown(
                        borderRadius: BorderRadius.circular(10),
                        border: const BorderSide(
                            color: Colors.black12, width: 1),
                        dropdownButtonColor: Colors.grey[300],
                        value: toAC,
                        onChanged: (newValue) {
                          setState(() {
                            toAC = newValue.toString();
                          });
                        },
                        items: accountList
                            .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                            .toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: () async {
                          var tempDate = await showDatePicker(firstDate: DateTime(1990), lastDate: DateTime(DateTime.now().year+1), context: context);
                          if(tempDate!=null){
                            date=tempDate.toString().split(" ")[0];
                            setState(() {});
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          padding: EdgeInsets.only(top: 5,bottom: 5),
                          margin: EdgeInsets.only(right: 5),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Center(child: Text(date,style: TextStyle(fontSize: 20),)),
                              ),
                              Expanded(
                                child: Icon(Icons.calendar_month,color: AllData.bgBlueColor,),
                              )
                            ],
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () async {
                          TimeOfDay? tempTime=await showTimePicker(context: context, initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute));
                          if(tempTime!=null){
                            time="${tempTime.hour}:${tempTime.minute} ${tempTime.hour>=12?'PM':'AM'}";
                            setState(() {});
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          padding: EdgeInsets.only(top: 5,bottom: 5),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Center(child: Text(time,style: TextStyle(fontSize: 20),)),
                              ),
                              Expanded(
                                  child: Icon(CupertinoIcons.time,color: AllData.bgBlueColor,)
                              )
                            ],
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: TextField(
                controller: notes,
                style: TextStyle(
                  fontSize: 20,
                ),
                cursorColor: AllData.bgBlueColor,
                decoration: InputDecoration(
                  hintText: "Notes",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AllData.bgBlueColor
                      )
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AllData.bgBlueColor,
                        style: BorderStyle.none
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                try{
                  if(balance.text!="" && double.parse(balance.text)!=0 && fromAC!="Select Account" && toAC!="Select Account" && notes.text!=""){
                    dbHelper.insertTransaction(
                        income: double.parse(balance.text),
                        expense: 0.0,
                        notes: notes.text,
                        transactionType: "Income",
                        date: date,
                        time: time,
                        userAcName: toAC
                    );
                    dbHelper.insertTransaction(
                        income: 0.0,
                        expense: double.parse(balance.text),
                        notes: notes.text,
                        transactionType: "Expense",
                        date: date,
                        time: time,
                        userAcName: fromAC
                    );
                    AllData.showToast("Money Transfer Successfully.");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
                  }else{
                    AllData.showToast("Please File All The Details.");
                  }
                }catch(e){
                  AllData.showToast("Please Enter Valid Value.");
                }
              },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AllData.bgBlueColor,
                    borderRadius: BorderRadius.all(Radius.circular(3))
                ),
                child: Text(
                  "TRANSFER",
                  style: TextStyle(
                      color: AllData.bgBlueFgColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    )
    );
  }

  Future<void> getAccountList() async {
    List data=await dbHelper.selectAccount();
    List<Accounts> tempData=data.map((e) => Accounts.fromJson(e),).toList();
    accountList.add("Select Account");
    accountList.add("Cash Book");
    for(int i=0;i<tempData.length;i++){
      accountList.add(tempData[i].name);
    }
    print(accountList);
    setState(() {});
  }
}
