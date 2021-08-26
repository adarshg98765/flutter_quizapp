import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: const <TextSpan>[
        TextSpan(
            text: 'Quiz',
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.green)),
        TextSpan(
            text: 'App',
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.blue)),
      ],
    ),
  );
}

Widget buttonblue(BuildContext context, String label) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(30),
    ),
    height: 50,
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width - 48,
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}
