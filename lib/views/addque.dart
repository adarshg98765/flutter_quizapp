import 'package:flutter/material.dart';
import 'package:quizapp/services/database.dart';
import 'package:quizapp/widgets/widget.dart';

class Addque extends StatefulWidget {
  final String? quizid;
  Addque(this.quizid);

  @override
  _AddqueState createState() => _AddqueState();
}

class _AddqueState extends State<Addque> {
  final _formkey = GlobalKey<FormState>();
  String? option1, option2, option3, option4, que;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;
  uploadquedata() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      Map<String, dynamic> questionMap = {
        "question": que,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
      };
      await databaseService
          .addquestionData(questionMap, widget.quizid)
          .then((value) {
        Future.delayed(const Duration(milliseconds: 500), () {

          setState(() {
            que = "";
            option1 = "";
            option2 = "";
            option3 = "";
            option4 = "";
            _isLoading = false;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      height: 20,
                    ),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Required Field" : null;
                      },
                      decoration: InputDecoration(
                          hintText: "Question",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen),
                            borderRadius: BorderRadius.circular(25.7),
                          )),
                      onChanged: (val) {
                        que = val;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Required Field" : null;
                      },
                      decoration: InputDecoration(
                          hintText: "Correct option",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen),
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onChanged: (val) {
                        option1 = val;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Required Field" : null;
                      },
                      decoration: InputDecoration(
                          hintText: "Option 2",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen),
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onChanged: (val) {
                        option2 = val;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Required Field" : null;
                      },
                      decoration: InputDecoration(
                          hintText: "Option 3",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen),
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onChanged: (val) {
                        option3 = val;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Required Field" : null;
                      },
                      decoration: InputDecoration(
                          hintText: "Option 4",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen),
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onChanged: (val) {
                        option4 = val;
                      },
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width / 2 - 40,
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              height: 50,
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width - 48,
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              uploadquedata();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              height: 50,
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width - 48,
                              child: Text(
                                "Add Question",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
    );
  }

  void onPressed() {}
}
