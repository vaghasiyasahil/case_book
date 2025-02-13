import 'package:case_book/Page/Account_Summary_Page.dart';
import 'package:case_book/Page/Accounts_Page.dart';
import 'package:case_book/Page/Home_Page.dart';
import 'package:case_book/Page/Summary_Page.dart';
import 'package:case_book/Page/Transaction_All_Accounts.dart';
import 'package:case_book/Page/Transfer_Page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AllData{

  // Color
  static Color bgBlueColor=Color.fromARGB(255, 41, 26, 64);
  static Color bgBlueFgColor=Colors.white;

  static Color bgWhiteColor=Colors.white;
  static Color bgWhiteFgColor=Color.fromARGB(255, 41, 26, 64);


  //assets path
  static String animationPath="assets/animation/";
  static String imagePath="assets/image/";

  //App Data
  // static int drawerCnt=12;  //"Report-All Accounts",
  static int drawerCnt=5;  //"Report-All Accounts",
  static List<String> drawerName=[
    "Home",
    // "Summary",
    "Account Summary",
    "Transaction-All Accounts",
    "Accounts",
    "Transfer",
  ];
  static List<Icon> drawerIcon=[
    Icon(Icons.home, color: AllData.bgBlueColor),
    // Icon(Icons.summarize, color: AllData.bgBlueColor),
    Icon(Icons.note_sharp, color: AllData.bgBlueColor),
    Icon(Icons.menu_open, color: AllData.bgBlueColor),
    Icon(Icons.supervisor_account_sharp, color: AllData.bgBlueColor),
    Icon(Icons.developer_mode, color: AllData.bgBlueColor),
  ];
  static List<Widget> drawerPage=[
    HomePage(),
    // SummaryPage(),
    AccountSummaryPage(),
    TransactionAllAccounts(),
    AccountsPage(),
    TransferPage(),
  ];


  static void showToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: bgBlueColor,
        textColor: bgBlueFgColor,
        fontSize: 18.0
    );
  }

}