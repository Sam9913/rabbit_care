import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class CallingPage extends StatefulWidget {
  @override
  _callingPageState createState() => _callingPageState();
}

// ignore: camel_case_types
class _callingPageState extends State<CallingPage> {
  bool speakerOn=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connecting...",
            style: TextStyle(
                fontFamily: 'Century Gothic',
                fontSize: 20,
                color: Colors.black)),
        leading: GestureDetector(
          onTap: () {},
          child: Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 40),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Text(
                  "We are currently experiencing a high"
                  " volume of calls at the moment- Please hold and the next available"
                  " volunteer will be with you as soon as possible.",
                  maxLines: 4,
                  style: TextStyle(
                      fontFamily: 'Century Gothic',
                      fontSize: 16.5,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: Image.asset(
                "images/logo.png",
                width: 300,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(0.0),
                child:CircleAvatar(
                  child:Icon(Icons.call_end,color: Colors.white,size:40),
                  backgroundColor: Colors.red,
                  radius: 40,
                ),
                ),
SizedBox(
  width:  MediaQuery.of(context).size.width/2.5,
),
                Padding(
                  padding: EdgeInsets.all(0.0),
                  child:InkWell(
                    onTap: (){
                      setState(() {
                        speakerOn=!speakerOn;
                      });
                    },
                  child:CircleAvatar(
                    radius: 41,
                  backgroundColor: Colors.black,
                  child:CircleAvatar(
                    child:speakerOn?Icon(Icons.volume_up,color: Colors.black,size:40):Icon(Icons.volume_off,color: Colors.black,size:40),
                    backgroundColor: Colors.white,
                    radius: 40,
                  ),
                  ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
