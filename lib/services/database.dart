import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{


  Future<void> addQuizData(Map<String,dynamic> quizdata, String? quizid)async {
    await FirebaseFirestore.instance.collection("Quiz").doc(quizid).set(quizdata).catchError((e){
      print(e.toString());
    });
  }

  Future<void> addquestionData(Map<String, dynamic> questiondata,String?quizid)async{
    await FirebaseFirestore.instance.collection("Quiz").doc(quizid).collection("QandA").add(questiondata).catchError((e){
      print(e.toString());
    });
  }


  getQuizdata() async {
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }
  getQuedata(String? quizid) async {
    return await FirebaseFirestore.instance.collection("Quiz").doc(quizid).collection("QandA").get();
  }
}