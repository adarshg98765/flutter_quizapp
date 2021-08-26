import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/models/question_model.dart';
import 'package:quizapp/services/database.dart';
import 'package:quizapp/views/result.dart';
import 'package:quizapp/widgets/quiz_widget.dart';
import 'package:quizapp/widgets/widget.dart';

class Quiz extends StatefulWidget {
  final String? quizid;
  Quiz(this.quizid);

  @override
  _QuizState createState() => _QuizState();
}

int total=0,correct=0,incorrect=0,notattempted=0;


class _QuizState extends State<Quiz> {

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot? quesnapshot;

  void getsnapshotdata()async{
      await databaseService.getQuedata(widget.quizid).then((value) {
      quesnapshot = value;
      correct = 0;
      incorrect = 0;
      total = quesnapshot?.docs.length ?? 0;
      notattempted = total;
      setState(() {});
    });
  }
  Questiondetails getquemodelfromDatasnapshot(DocumentSnapshot quesnapshot){
    Questiondetails questiondetails = new Questiondetails();
    questiondetails.que = quesnapshot.get("question");
    List<String> options = [
      quesnapshot.get("option1"),
      quesnapshot.get("option2"),
      quesnapshot.get("option3"),
      quesnapshot.get("option4"),
    ];
    options.shuffle();
    questiondetails.op1 = options[0];
    questiondetails.op2 = options[1];
    questiondetails.op3 = options[2];
    questiondetails.op4 = options[3];
    questiondetails.correct = quesnapshot.get("option1");
    questiondetails.answered = false;

    return questiondetails;

  }
  @override
  void initState() {

    super.initState();
        getsnapshotdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black87,
        ),
        title: Container(
            padding: EdgeInsets.only(left: 90), child: appBar(context)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
      ),
      body: Container(
        child: Column(
          children: [
            quesnapshot?.docs == null ? Container() :
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index){
              return Quiztile(
              questiondetails: getquemodelfromDatasnapshot(quesnapshot!.docs[index]),
              index: index,
              );
            }, itemCount: quesnapshot?.docs.length ?? 0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Results(
                        correct: correct, incorrect: incorrect, total: total)));
          }),
    );
  }
}

class Quiztile extends StatefulWidget {
  final Questiondetails questiondetails;
  final int index;
  Quiztile({required this.questiondetails,required this.index});

  @override
  _QuiztileState createState() => _QuiztileState();
}

class _QuiztileState extends State<Quiztile> {
  String optionselected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Q${widget.index+1}. ${widget.questiondetails.que}", style: TextStyle(fontSize: 19),)),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: (){
              if(!widget.questiondetails.answered){
                if(widget.questiondetails.op1 == widget.questiondetails.correct){
                  optionselected = widget.questiondetails.op1;
                  widget.questiondetails.answered = true;
                  correct = correct + 1;
                  notattempted = notattempted - 1;
                  setState(() {
                    
                  });
                }
                else{
                  optionselected = widget.questiondetails.op1;
                  widget.questiondetails.answered = true;
                  incorrect = incorrect + 1;
                  notattempted = notattempted - 1;
                  setState(() {
                    
                  });
                }
              }
            },
            child: Options(
                correctanswer: widget.questiondetails.correct,
                option: "A",
                detail: widget.questiondetails.op1,
                selected: optionselected),
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questiondetails.answered) {
                if (widget.questiondetails.op2 ==
                    widget.questiondetails.correct) {
                  optionselected = widget.questiondetails.op2;
                  widget.questiondetails.answered = true;
                  correct = correct + 1;
                  notattempted = notattempted - 1;
                  setState(() {});
                } else {
                  optionselected = widget.questiondetails.op2;
                  widget.questiondetails.answered = true;
                  incorrect = incorrect + 1;
                  notattempted = notattempted - 1;
                  setState(() {});
                }
              }
            },
            child: Options(
                correctanswer: widget.questiondetails.correct,
                option: "B",
                detail: widget.questiondetails.op2,
                selected: optionselected),
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questiondetails.answered) {
                if (widget.questiondetails.op3 ==
                    widget.questiondetails.correct) {
                  optionselected = widget.questiondetails.op3;
                  widget.questiondetails.answered = true;
                  correct = correct + 1;
                  notattempted = notattempted - 1;
                  setState(() {});
                } else {
                  optionselected = widget.questiondetails.op3;
                  widget.questiondetails.answered = true;
                  incorrect = incorrect + 1;
                  notattempted = notattempted - 1;
                  setState(() {});
                }
              }
            },
            child: Options(
                correctanswer: widget.questiondetails.correct,
                option: "C",
                detail: widget.questiondetails.op3,
                selected: optionselected),
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questiondetails.answered) {
                if (widget.questiondetails.op4 ==
                    widget.questiondetails.correct) {
                  optionselected = widget.questiondetails.op4;
                  widget.questiondetails.answered = true;
                  correct = correct + 1;
                  notattempted = notattempted - 1;
                  setState(() {});
                } else {
                  optionselected = widget.questiondetails.op4;
                  widget.questiondetails.answered = true;
                  incorrect = incorrect + 1;
                  notattempted = notattempted - 1;
                  setState(() {});
                }
              }
            },
            child: Options(
                correctanswer: widget.questiondetails.correct,
                option: "D",
                detail: widget.questiondetails.op4,
                selected: optionselected),
          ),
        ],
      ),
    );
  }
}
