import 'package:case_book/Model/Accounts.dart';
import 'package:case_book/Services/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/size/gf_size.dart';

import '../Services/AllData.dart';
import 'Main_Page.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {

  TextEditingController uName=TextEditingController();
  TextEditingController uBalance=TextEditingController();
  bool addMoney=true;
  bool debitMoney=false;
  String date=DateTime.now().toString().split(" ")[0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectData();
  }

  static List<Accounts> dataList=[];
  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvokedWithResult: (didPop, result) {
          selectPage=0;
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
        },
        canPop: false,
        child: Scaffold(
      body: FutureBuilder(
        future: selectData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: AllData.bgBlueColor,));
          }else if(!snapshot.hasData || snapshot.data!.isEmpty){
            return Center(child: Text("No Accounts",style: TextStyle(fontSize: 20,color: AllData.bgBlueColor,fontWeight: FontWeight.bold),),);
          }else{
            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return
                  Container(
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
                      alignment: Alignment.center,
                      child: ListTile(
                        title: Text(dataList[index].name??"",style: TextStyle(color: AllData.bgWhiteFgColor),),
                        trailing: PopupMenuButton(itemBuilder: (context) {
                          return [
                            PopupMenuItem(onTap: () {
                              uName.text=dataList[index].name!;
                              showDialog(barrierDismissible: false,context: context, builder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SingleChildScrollView(
                                      child: StatefulBuilder(
                                        builder: (BuildContext context, void Function(void Function()) setState1) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero
                                          ),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                TextField(
                                                  controller: uName,
                                                  cursorColor: AllData.bgBlueColor,
                                                  decoration: InputDecoration(
                                                      label: Text("Name"),
                                                      labelStyle: TextStyle(
                                                          color: AllData.bgBlueColor
                                                      ),
                                                      border: OutlineInputBorder(),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: AllData.bgBlueColor)
                                                      )
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    margin: EdgeInsets.only(top: 10),
                                                    decoration: BoxDecoration(
                                                        color: AllData.bgBlueColor,
                                                        border: Border.all(),
                                                        borderRadius: BorderRadius.all(Radius.circular(7))
                                                    ),
                                                    padding: EdgeInsets.all(10),
                                                    child: Text("CANCEL",style: TextStyle(color: AllData.bgBlueFgColor,fontSize: 20),),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    if(uName.text!=""){
                                                      dbHelper.updateAccountName(id: int.parse(dataList[index].id.toString()), uName: uName.text);
                                                      Navigator.pop(context);
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
                                                    }else{
                                                      AllData.showToast("Please File The Details.");
                                                    }
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    margin: EdgeInsets.only(top: 10),
                                                    decoration: BoxDecoration(
                                                        color: AllData.bgBlueColor,
                                                        border: Border.all(),
                                                        borderRadius: BorderRadius.all(Radius.circular(7))
                                                    ),
                                                    padding: EdgeInsets.all(10),
                                                    child: Text("SAVE",style: TextStyle(color: AllData.bgBlueFgColor,fontSize: 20),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          titlePadding: EdgeInsets.all(5),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },);
                            },child: Text("Edit")),
                            PopupMenuItem(onTap: () {
                              showDialog(context: context, builder: (context) => AlertDialog(
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero
                                ),
                                title: Text("Delete"),
                                content: Text("If you delete this account then all transactions in this account will also get deleted."),
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                          color: AllData.bgBlueColor,
                                          border: Border.all(),
                                          borderRadius: BorderRadius.all(Radius.circular(7))
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: Text("CANCEL",style: TextStyle(color: AllData.bgBlueFgColor,fontSize: 20),),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      dbHelper.deleteAccount(acName: dataList[index].name!);
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                          color: AllData.bgBlueColor,
                                          border: Border.all(),
                                          borderRadius: BorderRadius.all(Radius.circular(7))
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: Text("DELETE",style: TextStyle(color: AllData.bgBlueFgColor,fontSize: 20),),
                                    ),
                                  ),
                                ],
                              ),);
                            },child: Text("Delete")),
                            PopupMenuItem(onTap: () {
                              uBalance.text=dataList[index].income==0.0?dataList[index].expense.toString():dataList[index].income.toString();
                              date=dataList[index].date!;
                              showDialog(barrierDismissible: false,context: context, builder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SingleChildScrollView(
                                      child: StatefulBuilder(
                                        builder: (BuildContext context, void Function(void Function()) setState1) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero
                                          ),
                                          title: Text("Opening Balance"),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                TextField(
                                                  controller: uBalance,
                                                  keyboardType: TextInputType.number,
                                                  cursorColor: AllData.bgBlueColor,
                                                  decoration: InputDecoration(
                                                      label: Text("Opening Balance[Optional]"),
                                                      labelStyle: TextStyle(
                                                          color: AllData.bgBlueColor
                                                      ),
                                                      border: OutlineInputBorder(),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: AllData.bgBlueColor)
                                                      )
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    GFCheckbox(
                                                      size: GFSize.SMALL,
                                                      activeBgColor: AllData.bgBlueColor,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          addMoney = true;
                                                          debitMoney=false;
                                                          setState1(() {});
                                                        });
                                                      },
                                                      value: addMoney,
                                                    ),
                                                    Text("+",style: TextStyle(fontSize:20),),
                                                    GFCheckbox(
                                                      size: GFSize.SMALL,
                                                      activeBgColor: AllData.bgBlueColor,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          addMoney = false;
                                                          debitMoney=true;
                                                          setState1(() {});
                                                        });
                                                      },
                                                      value: debitMoney,
                                                    ),
                                                    Text("-",style: TextStyle(fontSize:25),),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    DateTime? datetime=await showDatePicker(context: context, firstDate: DateTime(1990), lastDate: DateTime(DateTime.now().year+1));
                                                    if(datetime!=null){
                                                      date=datetime.toString().split(" ")[0];
                                                    }
                                                    setState1(() {});
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(),
                                                        borderRadius: BorderRadius.all(Radius.circular(7))
                                                    ),
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                            margin: EdgeInsets.only(left: 15,right: 15),
                                                            child: Text(date,style: TextStyle(fontSize: 20),)
                                                        ),
                                                        Icon(Icons.calendar_month,size: 30,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    margin: EdgeInsets.only(top: 10),
                                                    decoration: BoxDecoration(
                                                        color: AllData.bgBlueColor,
                                                        border: Border.all(),
                                                        borderRadius: BorderRadius.all(Radius.circular(7))
                                                    ),
                                                    padding: EdgeInsets.all(10),
                                                    child: Text("CANCEL",style: TextStyle(color: AllData.bgBlueFgColor,fontSize: 20),),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    dbHelper.updateAccountOpeningBalance(
                                                        id: dataList[index].id!,
                                                        uBalance: double.parse(uBalance.text),
                                                        isAddMoney: addMoney,
                                                        date: date,
                                                        userAcName: dataList[index].name!
                                                    );
                                                    Navigator.pop(context);
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    margin: EdgeInsets.only(top: 10),
                                                    decoration: BoxDecoration(
                                                        color: AllData.bgBlueColor,
                                                        border: Border.all(),
                                                        borderRadius: BorderRadius.all(Radius.circular(7))
                                                    ),
                                                    padding: EdgeInsets.all(10),
                                                    child: Text("SAVE",style: TextStyle(color: AllData.bgBlueFgColor,fontSize: 20),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },);
                            },child: Text("Opening Balance"))
                          ];
                        },),
                      )
                  );
              },
            );
          }
        },
      ),
    )
    );
  }
  static Future<List<Accounts>> selectData() async {
    List tempData=await dbHelper.selectAccount();
    dataList=tempData!.map<Accounts>((e) => Accounts.fromJson(e)).toList();
    print(dataList);
    return dataList;
  }
}
