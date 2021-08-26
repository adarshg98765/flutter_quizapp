import 'package:flutter/material.dart';
import 'package:quizapp/services/database.dart';
import 'package:quizapp/views/addque.dart';
import 'package:quizapp/widgets/widget.dart';
import 'package:random_string/random_string.dart';

class Createquiz extends StatefulWidget {
  const Createquiz({Key? key}) : super(key: key);

  @override
  _CreatequizState createState() => _CreatequizState();
}

class _CreatequizState extends State<Createquiz> {
  final _formkey = GlobalKey<FormState>();
  String? quiztitle, quizdesc, quizid;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;
  createquiz() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizid = randomAlphaNumeric(16);
      Map<String, dynamic> quizMap = {
        "quizid": quizid,
        "quiztitle": quiztitle,
        "quizdescription": quizdesc
      };
      await databaseService.addQuizData(quizMap, quizid).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Addque(quizid)));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formkey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Required Field" : null;
                      },
                      decoration: InputDecoration(hintText: "Quiz Title"),
                      onChanged: (val) {
                        quiztitle = val;
                      },
                    ),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Required Field" : null;
                      },
                      decoration: InputDecoration(hintText: "Quiz Description"),
                      onChanged: (val) {
                        quizdesc = val;
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                        onTap: () {
                          createquiz();
                        },
                        child: buttonblue(context, "Create Quiz")),
                  ],
                ),
              ),
            ),
    );
  }
}
