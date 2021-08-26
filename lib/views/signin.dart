
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/helper/functions.dart';
import 'package:quizapp/services/auth.dart';
import 'package:quizapp/views/home.dart';
import 'package:quizapp/views/signup.dart';
import 'package:quizapp/widgets/widget.dart';

class Signin extends StatefulWidget {
  const Signin({ Key? key }) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formkey = GlobalKey<FormState>();
  late String email,password;
  AuthService authService = new AuthService();

  bool _isLoading = false;

  signIn() async {
    if(_formkey.currentState!.validate()){

      setState(() {
        _isLoading = true;
      });
      await authService.signinwithemailandpass(email, password).then((val){
        if(val!=null){
          setState(() {
            _isLoading = false;
          });
          Helperfunc.saveuserstate(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
    }
  }
  @override
  void initState() {
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: appBar(context)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
      ),
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Form(
        key: _formkey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                validator: (val){return val!.isEmpty ? "Enter email" : null;},
                decoration: InputDecoration(
                  hintText: "Email"
                ),onChanged: (val){
                  email = val;
                },
              ),
              SizedBox(height:  6,),
              TextFormField(
                obscureText: true,
                validator: (val) {
                  return val!.isEmpty ? "Enter Password" : null;
                },
                decoration: InputDecoration(hintText: "Password"),
                onChanged: (val) {
                  password = val;
                },
              ),
              SizedBox(height: 14,),
              GestureDetector(
                onTap: (){
                  signIn();
                },
                child: buttonblue(context, "Sign In")
              ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont have an account?",style: TextStyle(fontSize: 15),),
                  
                  GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signup()));
                        },
                    child: Text("Sign Up",
                            style: TextStyle(
                                fontSize: 15,
                                decoration: TextDecoration.underline),)),
                ],
              ),
              SizedBox(
                height: 80,
              ),
            ],
          )
        ),
      )
    );
  }
}