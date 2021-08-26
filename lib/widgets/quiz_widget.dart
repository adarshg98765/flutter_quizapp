import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  final String? option,detail,correctanswer,selected;
  Options({@required this.correctanswer,@required this.option,@required this.detail,@required this.selected});

  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            height: 28,
            width: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.selected == widget.detail
                        ? widget.detail == widget.correctanswer
                            ? Colors.green.withOpacity(0.7)
                            : Colors.red.withOpacity(0.7)
                        : Colors.grey,
                    width: 1.5),
                color: widget.selected == widget.detail
                    ? widget.detail== widget.correctanswer
                        ? Colors.green.withOpacity(0.7)
                        : Colors.red.withOpacity(0.7)
                    : Colors.white,
                borderRadius: BorderRadius.circular(24)),
            child: Text(
              widget.option as String,
              style: TextStyle(
                color: widget.selected == widget.detail
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            widget.detail as String,
            style: TextStyle(fontSize: 17, color: Colors.black54,fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }
}