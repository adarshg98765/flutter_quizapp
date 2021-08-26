import 'package:flutter/material.dart';
import 'package:quizapp/helper/functions.dart';
import 'package:quizapp/services/auth.dart';
import 'package:quizapp/views/home.dart';
import 'package:quizapp/views/signin.dart';
import 'package:quizapp/widgets/widget.dart';

class Signup extends StatefulWidget {
  const Signup({ Key? key }) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final _formkey = GlobalKey<FormState>();
  late String email,password,name;
  AuthService authService = new AuthService();
  bool _isLoading = false;
  signUp()async{
    if(_formkey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      await authService .signupwithemailandpass(email, password).then((val){
        if(val!=null){
          setState(() {
            _isLoading = false;
          });
          Helperfunc.saveuserstate(true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
          title: Container(alignment: Alignment.center, child: appBar(context)),
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
                  SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    validator: (val) {
                      return val!.isEmpty ? "Enter name" : null;
                    },
                    decoration: InputDecoration(hintText: "Name"),
                    onChanged: (val) {
                      name = val;
                    },
                  ),
                  TextFormField(
                    validator: (val) {
                      return val!.isEmpty ? "Enter email" : null;
                    },
                    decoration: InputDecoration(hintText: "Email"),
                    onChanged: (val) {
                      email = val;
                    },
                  ),
                  SizedBox(
                    height: 6,
                  ),
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
                  SizedBox(
                    height: 14,
                  ),
                  GestureDetector(
                    onTap: (){
                      signUp();
                    },
                    child: buttonblue(context, "Sign Up")
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signin()));
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(fontSize: 15,decoration: TextDecoration.underline),
                          
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              )),
        )
    );
  }
}