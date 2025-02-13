import 'package:case_book/Model/Accounts.dart';
import 'package:case_book/Page/Accounts_Page.dart';
import 'package:case_book/Services/dbHelper.dart';
import 'package:case_book/Services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/components/radio_list_tile/gf_radio_list_tile.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_radio_type.dart';
import '../Services/AllData.dart';

class MainPage extends StatefulWidget {

  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}
int selectPage=0;
String caseType="All";
bool ascending=false;
bool decending=true;

class _MainPageState extends State<MainPage> {
  String? groupValue="+";

  bool addMoney=true;
  bool debitMoney=false;

  TextEditingController nameAndAddress=TextEditingController(text: preferences.getNameAndAddress());

  TextEditingController nameNewAc=TextEditingController();
  TextEditingController balanceNewAc=TextEditingController();
  String date=DateTime.now().toString().split(" ")[0];

  List<Widget> dialogWidget=[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(length: AllData.drawerCnt, child: Scaffold(
        drawer: Drawer(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.zero
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DrawerHeader(
                  child: Image.asset(
                      "${AllData.imagePath}account.png"
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height-200), // Adjust height as needed
                  child: ListView.builder(
                    itemCount: AllData.drawerCnt,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectPage = index;
                            Navigator.pop(context);
                          });
                        },
                        child: ListTile(
                          leading: AllData.drawerIcon[index],
                          title: Text(
                            AllData.drawerName[index],
                            style: TextStyle(color: AllData.bgBlueColor),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ]
            ),
          ),
        ),

        appBar: selectPage==0?
                  AppBar(
          backgroundColor: AllData.bgBlueColor,
          iconTheme: IconThemeData(color: AllData.bgBlueFgColor),
          title: InkWell(
            onTap: () {
              selectAC();
            },
            child: Row(
              children: [
                Text(
                  "${preferences.getAccount()}",
                  style: TextStyle(
                      color: AllData.bgBlueFgColor
                  ),
                ),
                Icon(Icons.arrow_drop_down,color: AllData.bgBlueFgColor,)
              ],
            ),
          ),
          actions: [
            // IconButton(onPressed: () {
            //   exportDataDialog();
            // }, icon: Icon(Icons.download,color: AllData.bgBlueFgColor,)),
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  // PopupMenuItem(
                  //   onTap: () {
                  //     showNotesDialog();
                  //   },
                  //   child: Text("Notes"),
                  // ),
                  // PopupMenuItem(
                  //   onTap: () {
                  //     showDatePickerDialog();
                  //   },
                  //   child: Text("Date"),
                  // ),
                  // PopupMenuItem(
                  //   onTap: () {
                  //
                  //   },
                  //   child: Text("Select Date Range"),
                  // ),
                  PopupMenuItem(
                    onTap: () {
                      setState(() {
                        ascending=true;
                        decending=false;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
                      });
                    },
                    child: Row(
                      children: [
                        Text("Date Ascending"),
                        Checkbox(
                          checkColor: AllData.bgBlueFgColor,
                          activeColor: AllData.bgBlueColor,
                          value: ascending,
                          onChanged: (value) {
                            setState(() {
                              ascending=true;
                              decending=false;
                              Navigator.pop(context);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      setState(() {
                        ascending=false;
                        decending=true;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
                      });
                    },
                    child: Row(
                      children: [
                        Text("Date Decending"),
                        Checkbox(
                          checkColor: AllData.bgBlueFgColor,
                          activeColor: AllData.bgBlueColor,
                          value: decending,
                          onChanged: (value) {
                            setState(() {
                              ascending=false;
                              decending=true;
                              Navigator.pop(context);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      setState(() {
                        caseType="CashIn";
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
                      });
                    },
                    child: Text("Case In"),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      setState(() {
                        caseType="CashOut";
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
                      });
                    },
                    child: Text("Case Out"),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      setState(() {
                        caseType="All";
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
                      });
                    },
                    child: Text("Case In And Out"),
                  ),
                  // PopupMenuItem(
                  //   onTap: () {
                  //     exportDataDialog();
                  //   },
                  //   child: Text("Print"),
                  // ),
                  PopupMenuItem(
                    onTap: () {
                      showDialog(barrierDismissible: false,context: context, builder: (context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AlertDialog(
                              titlePadding: EdgeInsets.all(10),
                              contentPadding: EdgeInsets.all(10),
                              actionsPadding: EdgeInsets.all(10),
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero
                              ),
                              title: Text(
                                "Your Name and Address",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              content: TextField(
                                onChanged: (value) {
                                  print("value=$value");
                                },
                                cursorColor: AllData.bgBlueColor,
                                controller: nameAndAddress,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: AllData.bgBlueColor)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: AllData.bgBlueColor)
                                    )
                                ),
                              ),
                              actions: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 40,
                                        alignment: Alignment.center,
                                        color: AllData.bgBlueColor,
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color: AllData.bgBlueFgColor,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        preferences.setNameAndAddress(nameAndAddress: nameAndAddress.text);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width: double.infinity,
                                        height: 40,
                                        alignment: Alignment.center,
                                        color: AllData.bgBlueColor,
                                        child: Text(
                                          "Save",
                                          style: TextStyle(
                                            color: AllData.bgBlueFgColor,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        );
                      },);
                    },
                    child: Text("Your Name and Address"),
                  ),
                ];
              },
            ),
          ],
        ):selectPage==1?
                  // AppBar(
                  //   backgroundColor: AllData.bgBlueColor,
                  //   iconTheme: IconThemeData(color: AllData.bgBlueFgColor),
                  //   title: Text(
                  //     "Summary",
                  //     style: TextStyle(
                  //         color: AllData.bgBlueFgColor
                  //     ),
                  //   ),
                  //   actions: [
                  //     // IconButton(onPressed: () {
                  //     //   exportDataDialog();
                  //     // }, icon: Icon(Icons.calendar_month,color: AllData.bgBlueFgColor,)),
                  //   ],
                  // ):selectPage==2?
                  AppBar(
                    backgroundColor: AllData.bgBlueColor,
                    iconTheme: IconThemeData(color: AllData.bgBlueFgColor),
                    title: InkWell(
                      onTap: () {
                        selectAC();
                      },
                      child: Row(
                        children: [
                          Text(
                            "${preferences.getAccount()}",
                            style: TextStyle(
                                color: AllData.bgBlueFgColor
                            ),
                          ),
                          Icon(Icons.arrow_drop_down,color: AllData.bgBlueFgColor,)
                        ],
                      ),
                    ),
                    actions: [
                      // IconButton(onPressed: () {
                      //
                      // }, icon: Icon(Icons.calendar_month,color: AllData.bgBlueFgColor,)),
                      // IconButton(onPressed: () {
                      //   exportDataDialog();
                      // }, icon: Icon(Icons.download,color: AllData.bgBlueFgColor,)),
                    ],
                  ):selectPage==2?
                  AppBar(
                    backgroundColor: AllData.bgBlueColor,
                    iconTheme: IconThemeData(color: AllData.bgBlueFgColor),
                    title: Text(
                      "Transaction All Accounts",
                      style: TextStyle(
                          color: AllData.bgBlueFgColor
                      ),
                    ),
                    actions: [
                      // IconButton(onPressed: () {
                      //   exportDataDialog();
                      // }, icon: Icon(Icons.download,color: AllData.bgBlueFgColor,)),
                      // PopupMenuButton(
                      //   itemBuilder: (context) {
                      //     return [
                      //       PopupMenuItem(
                      //         onTap: () {
                      //           showNotesDialog();
                      //         },
                      //         child: Text("Date"),
                      //       ),
                      //       PopupMenuItem(
                      //         onTap: () {
                      //           showDatePickerDialog();
                      //         },
                      //         child: Text("Select Date Range"),
                      //       ),
                      //       PopupMenuItem(
                      //         onTap: () {
                      //
                      //         },
                      //         child: Text("Accounts"),
                      //       ),
                      //     ];
                      //   },
                      // ),
                    ],
                  ):selectPage==3?
                  AppBar(
                    backgroundColor: AllData.bgBlueColor,
                    iconTheme: IconThemeData(color: AllData.bgBlueFgColor),
                    title: Text(
                      "Accounts",
                      style: TextStyle(
                          color: AllData.bgBlueFgColor
                      ),
                    ),
                    actions: [
                      InkWell(
                        onTap: () {
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
                                        title: Text("Add Account"),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              TextField(
                                                controller: nameNewAc,
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
                                              TextField(
                                                controller: balanceNewAc,
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
                                                  if(nameNewAc.text!=""){
                                                    List tempAccount=await dbHelper.selectAccount();
                                                    List<Accounts> acList=tempAccount.map((e) => Accounts.fromJson(e),).toList();
                                                    for(int i=0;i<acList.length;i++){
                                                      if(nameNewAc.text==acList[i].name){
                                                        AllData.showToast("Account Already Exists.");
                                                        return;
                                                      }
                                                    }
                                                    dbHelper.insertAccount(
                                                        name: nameNewAc.text,
                                                        date: date,
                                                        income: addMoney?balanceNewAc.text==""?0:double.parse(balanceNewAc.text):0,
                                                        expense: addMoney?0:balanceNewAc.text==""?0:double.parse(balanceNewAc.text),
                                                        transactionType: addMoney?"Cash In":"Cash Out"
                                                    );
                                                    dbHelper.insertTransaction(
                                                        income: addMoney?balanceNewAc.text==""?0:double.parse(balanceNewAc.text):0,
                                                        expense: addMoney?0:balanceNewAc.text==""?0:double.parse(balanceNewAc.text),
                                                        notes: "Opening Balance",
                                                        transactionType: addMoney?"Cash In":"Cash Out",
                                                        date: date,
                                                        time: "${DateTime.now().hour}:${DateTime.now().minute} ${DateTime.now().hour>=12?'PM':'AM'}",
                                                        userAcName: nameNewAc.text
                                                    );
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
                                      contentPadding: EdgeInsets.all(5),
                                      ),
                                  ),
                                ),
                              ],
                            );
                          },);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            "ADD ACCOUNT",
                            style: TextStyle(
                                color: AllData.bgBlueFgColor
                            ),
                          ),
                        ),
                      ),
                    ],
                  ):
                  AppBar(
                    backgroundColor: AllData.bgBlueColor,
                    iconTheme: IconThemeData(color: AllData.bgBlueFgColor),
                    title: Text(
                      "Transfer",
                      style: TextStyle(
                          color: AllData.bgBlueFgColor
                      ),
                    ),
                  ),

        body: AllData.drawerPage[selectPage!]

      ),
      )
    );
  }

  void selectAC() {
    showDialog(context: context, builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AlertDialog(
            titlePadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.all(10),
            actionsPadding: EdgeInsets.all(10),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.zero
            ),
            title: Row(
              children: [
                Icon(
                  Icons.account_balance_wallet_outlined,
                  color: AllData.bgBlueColor,
                  size: 28,
                ),
                Text(
                    "Accounts",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            content: Column(
              children: [
                FutureBuilder(
                  future: getAccount(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(),);
                    }else if(snapshot.data.length==0){
                      return Center(
                        child: Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: Text("Cash Book")
                        ),
                      );
                    }else{
                      return Center(
                        child: Column(
                          children: dialogWidget
                        ),
                      );
                      // return Expanded(
                      //   child: ListView.builder(itemCount: snapshot.data.length,itemBuilder: (context, index) {
                      //     return Container(
                      //         margin: EdgeInsets.all(10),
                      //         alignment: Alignment.centerLeft,
                      //         child: Text(snapshot.data[index])
                      //     );
                      //   },),
                      // );
                    }
                  },
                )
              ],
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
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
                              title: Text("Add Account"),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: nameNewAc,
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
                                    TextField(
                                      controller: balanceNewAc,
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
                                        if(nameNewAc.text!=""){
                                          List tempAccount=await dbHelper.selectAccount();
                                          List<Accounts> acList=tempAccount.map((e) => Accounts.fromJson(e),).toList();
                                          for(int i=0;i<acList.length;i++){
                                            if(nameNewAc.text==acList[i].name){
                                              AllData.showToast("Account Already Exists.");
                                              return;
                                            }
                                          }
                                          dbHelper.insertAccount(
                                              name: nameNewAc.text,
                                              date: date,
                                              income: addMoney?balanceNewAc.text==""?0:double.parse(balanceNewAc.text):0,
                                              expense: addMoney?0:balanceNewAc.text==""?0:double.parse(balanceNewAc.text),
                                              transactionType: addMoney?"Cash In":"Cash Out"
                                          );
                                          dbHelper.insertTransaction(
                                              income: addMoney?balanceNewAc.text==""?0:double.parse(balanceNewAc.text):0,
                                              expense: addMoney?0:balanceNewAc.text==""?0:double.parse(balanceNewAc.text),
                                              notes: "Opening Balance",
                                              transactionType: addMoney?"Cash In":"Cash Out",
                                              date: date,
                                              time: "${DateTime.now().hour}:${DateTime.now().minute} ${DateTime.now().hour>=12?'PM':'AM'}",
                                              userAcName: nameNewAc.text
                                          );
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
                              contentPadding: EdgeInsets.all(5),
                            ),
                          ),
                        ),
                      ],
                    );
                  },);
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  alignment: Alignment.center,
                  color: AllData.bgBlueColor,
                  child: Text(
                      "Add Account",
                    style: TextStyle(
                      color: AllData.bgBlueFgColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      );
    },);
  }

  void exportDataDialog(){
    showDialog(barrierDismissible: false,context: context, builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AlertDialog(
            titlePadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.all(10),
            actionsPadding: EdgeInsets.all(10),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.zero
            ),
            title: Row(
              children: [
                Icon(
                  Icons.download,
                  color: AllData.bgBlueColor,
                  size: 28,
                ),
                Text(
                  "Export",
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            content: Column(
              children: [
                Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text("PDF File Download")
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text("Excel File Download")
                ),
              ],
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  alignment: Alignment.center,
                  color: AllData.bgBlueColor,
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: AllData.bgBlueFgColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      );
    },);
  }

  void showNotesDialog(){
    showDialog(barrierDismissible: false,context: context, builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AlertDialog(
            titlePadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.all(10),
            actionsPadding: EdgeInsets.all(10),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.zero
            ),
            title: Row(
              children: [
                Icon(
                  Icons.notes,
                  color: AllData.bgBlueColor,
                  size: 28,
                ),
                Text(
                  "Notes",
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            content: TextField(
              onChanged: (value) {
                print("value=$value");
              },
              cursorColor: AllData.bgBlueColor,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AllData.bgBlueColor)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AllData.bgBlueColor)
                )
              ),
            ),
            actions: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      alignment: Alignment.center,
                      color: AllData.bgBlueColor,
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: AllData.bgBlueFgColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: double.infinity,
                      height: 40,
                      alignment: Alignment.center,
                      color: AllData.bgBlueColor,
                      child: Text(
                        "Search",
                        style: TextStyle(
                          color: AllData.bgBlueFgColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      );
    },);
  }

  Future<void> showDatePickerDialog() async {
    showDatePicker(
      barrierDismissible: false,
      initialDate: DateTime.now(),
      keyboardType: TextInputType.number,
      context: context,
      firstDate: DateTime(1975),
      lastDate: DateTime(DateTime.now().year+1),
    ).then((value) {
      String date=value.toString();
      print("Date=${date.split(" ")[0]}");
    },);
  }

  getAccount() async {
    dialogWidget.clear();
    List tempAccount=await dbHelper.selectAccount();
    List<Accounts> data=tempAccount.map((e) => Accounts.fromJson(e),).toList();
    dialogWidget.add(
      InkWell(
        onTap: () {
          preferences.setAccount(account: "Cash Book");
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
        },
        child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text("Cash Book")
        ),
      ),
    );
    for(int i=0;i<data.length;i++){
      dialogWidget.add(
        InkWell(
          onTap: () {
            preferences.setAccount(account: data[i].name!);
            Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
          },
          child: Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: Text(data[i].name!)
          ),
        ),
      );
    }
    return dialogWidget;
  }

}
