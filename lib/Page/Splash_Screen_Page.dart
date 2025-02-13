import 'package:case_book/Page/Main_Page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Services/AllData.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) => MainPage(),));
    },);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Lottie.asset(
            "${AllData.animationPath}splash_screen.json"
          ),
        ),
      ),
    );
  }
}
