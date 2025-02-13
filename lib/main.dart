import 'package:case_book/Page/Main_Page.dart';
import 'package:case_book/Services/dbHelper.dart';
import 'package:case_book/Services/preferences.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.createTable();
  await preferences.iniMemory();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    )
  );
}