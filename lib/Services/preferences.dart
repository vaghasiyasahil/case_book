import 'package:shared_preferences/shared_preferences.dart';

class preferences{
  static late SharedPreferences prefs;

  static Future<void> iniMemory() async {
    prefs = await SharedPreferences.getInstance();
  }

  static setNameAndAddress({required String nameAndAddress}){
    prefs.setString("${getAccount()}nameAndAddress", nameAndAddress);
  }
  static String getNameAndAddress(){
    return prefs.getString("${getAccount()}nameAndAddress")??"";
  }

  static setAccount({required String account}){
    prefs.setString("account", account);
  }
  static String getAccount(){
    return prefs.getString("account")??"Cash Book";
  }

}