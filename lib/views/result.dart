import 'package:flutter/material.dart';
import 'package:quizapp/views/home.dart';
import 'package:quizapp/widgets/widget.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;
  Results(
      {required this.correct, required this.incorrect, required this.total});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            padding: EdgeInsets.only(left: 90), child: appBar(context)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 8,
              ),
              Text("${widget.correct} answers correct ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.greenAccent),),
              SizedBox(height: 8,),
              Text("${widget.incorrect} answers incorrect",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent),
              ),
              SizedBox(height: 80,),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                },
                child: buttonblue(context, "Back to Quizes")),
            ],
          ),
        ),
      ),
    );
  }
}
