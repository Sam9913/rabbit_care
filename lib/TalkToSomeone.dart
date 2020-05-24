import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

class TalkToSomeone extends StatefulWidget {
  @override
  _TalkToSomeoneState createState() => _TalkToSomeoneState();
}

class _TalkToSomeoneState extends State<TalkToSomeone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(alignment: Alignment.centerRight, child: Text("Talk to someone you trust")),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context), child: Icon(Icons.keyboard_arrow_left)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Bubble(
                color: Color.fromRGBO(135, 209, 214, 0.8),
                child: Text(
                  "Contact someone who you trust, your loved one, your family, or your friend. "
											"It's okay to seek help from others.",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
