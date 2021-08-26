import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/helper/functions.dart';
import 'package:quizapp/views/home.dart';
import 'package:quizapp/views/signin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLoggedin = false;
  checkuserstatus() async{
    Helperfunc.getuserstate().then((value){
      setState(() {
        isLoggedin=value!;
      });
    });

  }
  @override
  void initState() {
    checkuserstatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: isLoggedin  ? Home(): Signin(),
    );
  }
}