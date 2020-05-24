import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'dart:math' as math;

class HelpAFriend extends StatefulWidget {
  @override
  _HelpAFriendState createState() => _HelpAFriendState();
}

class _HelpAFriendState extends State<HelpAFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(alignment: Alignment.centerRight, child: Text("Help a friend")),
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
                "Noticed someone close to you showing suicide warning "
                "signs? Here are some ways to help them as a friend.",
                textAlign: TextAlign.center,
              ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                        child: Text(
                      "Encourage them to get in touch with trained counsellors or "
                      "psychologists",
                      style: TextStyle(color: Color.fromRGBO(0, 50, 0, 1.0), fontSize: 20),
                    )),
										Transform.rotate(
												angle: 270 * math.pi/180,
												child: Icon(Icons.phone, size: 70,)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "You can recommend RabbitCare to your friend to receive immediate emotional "
                  "support form qualified counsellors and psychologists. You may also encourage "
                  "them to seek for the available psychology centers in Malaysia across different "
                  "states in the app.",
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
										Padding(
										  padding: const EdgeInsets.only(right: 8.0),
										  child: Icon(Icons.chat_bubble, size: 70,),
										),
                    Flexible(
                        child: Text(
                      "Ask directly and openly about suicidal thoughts",
                      style: TextStyle(color: Color.fromRGBO(0, 50, 0, 1.0), fontSize: 20),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Discussing openly about thoughts of suicide will not induce suicide ideation."
                  " Instead, asking about suicide thoughts openly allow someone who actually has "
                  "the thought to talk openly and release tensions in themselves. This is similar"
                  " to when you feel angry or happy about something, sharing it usually makes you"
                  " feel better.",
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                        child: Text(
                      "Listen with compassion and avoid judging and dismissing their"
                      " feelings",
                      style: TextStyle(color: Color.fromRGBO(0, 50, 0, 1.0), fontSize: 20),
                    )),
										Icon(Icons.hearing, size: 70,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "If your friend/family acknowledge their suicidal thoughts, allow them to "
                  "share with you more about their feelings. Try to provide them listening ears "
                  "by empathizing with their feelings and thoughts.",
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                  	Icon(Icons.security, size: 70,),
                    Flexible(
                        child: Text(
                      "Ensure that they are in a safe environment if possible",
                      style: TextStyle(color: Color.fromRGBO(0, 50, 0, 1.0), fontSize: 20),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "If they have specific plans about how they want to attempt suicide, try to "
                  "keep their environment is safe from possible objects that may cause harm. You "
                  "may also encourage them to contact crisis helpline support if they are in "
                  "immediate danger.",
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
