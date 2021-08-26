
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helperfunc{
  static String userlogkey ="USERLOGGEDINKEY";
  static saveuserstate(bool isLoggedin)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(userlogkey, isLoggedin);
  }

  static Future<bool?> getuserstate() async{
    Firebase.initializeApp();
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(userlogkey);
  }
}