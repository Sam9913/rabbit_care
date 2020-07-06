import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:toast/toast.dart';

class CallingPage extends StatefulWidget {
  @override
  _callingPageState createState() => _callingPageState();
}

// ignore: camel_case_types
class _callingPageState extends State<CallingPage> {
  bool speakerOn=true;

  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 20),(){
      Toast.show("We are currently experiencing a high"
          " volume of calls at the moment- Please hold and the next available"
          " volunteer will be with you as soon as possible.",
          context,duration:5,backgroundColor: Colors.white,textColor: Colors.black
      );
    });
  }


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
          onTap: () {
            Navigator.pop(context,"duringCall");
          },
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
              padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
              child: Image.asset(
                "images/logo.png",
                width: 150,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/2.8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(0.0),
                  child:InkWell(
                    onTap: (){
                      Navigator.pop(context,true);
                    },
                    child:CircleAvatar(
                      child:Icon(Icons.call_end,color: Colors.white,size:40),
                      backgroundColor: Colors.red,
                      radius: 40,
                    ),
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