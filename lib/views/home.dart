import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizapp/helper/functions.dart';
import 'package:quizapp/services/auth.dart';
import 'package:quizapp/services/database.dart';
import 'package:quizapp/views/createquiz.dart';
import 'package:quizapp/views/quiz.dart';
import 'package:quizapp/views/signin.dart';
import 'package:quizapp/widgets/widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

const colors = [
  Colors.lightGreen,
  Colors.lightBlue,
  Colors.amberAccent,
  Color(0xAEEB3400),
  Colors.pinkAccent,
  Color(0xa11b1200),
  Color(0x03fcdf00),
];
Random random = Random();

class _HomeState extends State<Home> {
  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();
  Stream? quizstream;
  Widget quizList() {
    return Container(
      child: StreamBuilder(
        stream: quizstream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.white,
                  ),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return Quizcard(
                      quizid: snapshot.data.docs[index].data()["quizid"],
                      desc: snapshot
                          .data.docs[index].data()["quizdescription"],
                      title: snapshot.data.docs[index].data()["quiztitle"],
                    );
                  },
                );
        },
      ),
    );
  }

  @override
  @override
  void initState() {
    databaseService.getQuizdata().then((val) {
      setState(() {
        quizstream = val;
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(padding: EdgeInsets.only(left: 90), child: appBar(context)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        actions: <Widget>[
          IconButton(
            color: Colors.black87,
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Sign Out',
            onPressed: () {
              // Helperfunc.saveuserstate(false);
              signout();
            },
          ),
        ],
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.lightGreen,
        label: Text("Create Quiz"),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Createquiz()));
        },
      ),
    );
  }

  void signout() async{
    await authService.signout();
    Helperfunc.saveuserstate(false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signin()));
  }
}

class Quizcard extends StatelessWidget {
  final String? title, desc,quizid;
  Quizcard({@required this.desc, @required this.title,@required this.quizid});


  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Quiz(quizid)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: colors[random.nextInt(6)],
            borderRadius: BorderRadiusDirectional.circular(10)),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(40),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(title!,
                      style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(color: Colors.black, fontSize: 24))),
                  Text(desc!,
                      style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(color: Colors.black54, fontSize: 15))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
