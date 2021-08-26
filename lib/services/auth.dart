// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizapp/helper/functions.dart';
import 'package:quizapp/models/user.dart';

class AuthService{
  FirebaseAuth _auth = FirebaseAuth.instance;

  User1? _userfromfirebaseuser(User? user){
    return user != null ? User1(userid: user.uid):null;
  }
  Future signinwithemailandpass(String email , String password)async {
    try{
      UserCredential authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = authResult.user;
      return _userfromfirebaseuser(firebaseUser);
    }catch(e){
      print(e);
    }
  }

  Future signupwithemailandpass(String email, String password)async {
    try{
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = authResult.user;
      return _userfromfirebaseuser(firebaseUser);
    }
    catch(e){
      print(e);
    }
  }

  Future signout()async{
    try {
      // Helperfunc.saveuserstate(false);
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }

}