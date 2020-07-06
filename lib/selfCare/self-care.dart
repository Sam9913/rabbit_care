import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bubble/bubble.dart';
import 'package:rabbitcare/drawer/CallHistory.dart';
import 'package:rabbitcare/drawer/Profile.dart';
import 'package:rabbitcare/drawer/VolunteerLogIn.dart';
import 'package:rabbitcare/safetyInfo/SafetyInfo.dart';
import 'package:rabbitcare/selfCare/FeelingDiary.dart';
import 'package:rabbitcare/selfCare/TalkToSomeone.dart';
import '../HomePage.dart';
import '../drawer/privacy.dart';
import '../drawer/termsCondition.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: camel_case_types
class selfCare extends StatefulWidget {
  @override
  _selfCareState createState() => _selfCareState();
}

// ignore: camel_case_types
class _selfCareState extends State<selfCare> {
  ScrollController _hideBottomBar;
  bool _isVisible;
  int _index = 0;
  String ratingScore = "I hate it";

  @override
  void initState() {
    super.initState();
    _hideBottomBar = new ScrollController();
    _isVisible = true;
    _hideBottomBar.addListener(
      () {
        if (_hideBottomBar.position.userScrollDirection == ScrollDirection.reverse) {
          if (_isVisible)
            setState(() {
              _isVisible = false;
            });
        }
        if (_hideBottomBar.position.userScrollDirection == ScrollDirection.forward) {
          if (!_isVisible)
            setState(() {
              _isVisible = true;
            });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromRGBO(172, 229, 215, 1.0)),
      home: SafeArea(
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                Builder(
                  builder: (context) => Container(
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: <Color>[
                              Color.fromRGBO(172, 229, 215, 1.0),
                              Color.fromRGBO(207, 235, 225, 1.0),
                            ])),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                                onTap: () => Scaffold.of(context).openEndDrawer(),
                                child: Icon(Icons.keyboard_arrow_left, color: Colors.black)),
                          ),
                          Expanded(
                              flex: 8,
                              child:
                              Align(alignment: Alignment.centerRight, child: Text('Settings'))),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: 8, right: 8), child: Icon(Icons
                                .settings)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.person),
                      ),
                      Text('Profile'),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AskRole()));
                  },
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.supervisor_account),
                      ),
                      Text('Volunteer'),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                  },
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.message),
                      ),
                      Text('Share Feedback'),
                    ],
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Container(
                              height: 275,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: <Color>[
                                              Color.fromRGBO(48, 187, 152, 1.0),
                                              Color.fromRGBO(146, 210, 187, 0.8),
                                            ]),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5), topRight: Radius
                                            .circular(5))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                              "We love to hear from you. ",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18, color: Colors.white, fontFamily: 'Century Gothic')),
                                          Image.asset("images/white_rabbit.png", width: 80,),
                                        ],
                                      ),
                                    ),
                                    width: double.infinity,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("How do you feel so about our app so far?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18, fontFamily: 'Century Gothic')),
                                  ),

                                  StatefulBuilder(
                                    builder: (context, setState){
                                      return Column(
                                        children: <Widget>[
                                          RatingBar(
                                            initialRating: 1,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              setState(() {
                                                if(rating <= 3.0){
                                                  ratingScore = "I hate it";
                                                }
                                                else if(rating == 4.0){
                                                  ratingScore = "Great!";
                                                }
                                                else{
                                                  ratingScore = "I love it!";
                                                }
                                              });
                                            },
                                          ),

                                          Text(ratingScore),
                                        ],
                                      );
                                    },
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        gradient: LinearGradient(
                                          colors: [Color.fromRGBO(135, 209, 214, 0.8), Colors.white],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomLeft,
                                        ),
                                      ),
                                      child: FlatButton(
                                        onPressed: (){
                                          if(ratingScore == "I hate it") {
                                            Navigator.pop(context);
                                            showDialog(context: context,
                                                builder: (BuildContext context) {
                                                  return Dialog(
                                                      elevation: 0,
                                                      backgroundColor: Colors.transparent,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(12)),
                                                      child: Container(
                                                          height: 350,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            shape: BoxShape.rectangle,
                                                            borderRadius:
                                                            BorderRadius.circular(5.0),
                                                          ),
                                                          child: Column(children: <Widget>[
                                                            Container(
                                                              height: 100,
                                                              decoration: BoxDecoration(
                                                                  gradient: LinearGradient(
                                                                      begin: Alignment.topLeft,
                                                                      end: Alignment.topRight,
                                                                      colors: <Color>[
                                                                        Color.fromRGBO(
                                                                            38, 170, 225, 1.0),
                                                                        Color.fromRGBO(
                                                                            146, 210, 187, 0.8),
                                                                      ]),
                                                                  shape: BoxShape.rectangle,
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius.circular(5),
                                                                      topRight:
                                                                      Radius.circular(5))),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .fromLTRB(16.0,16.0,8.0,0.0),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Text("We're "
                                                                        "sorry to  hear "
                                                                        "that...",style: TextStyle(
                                                                        fontSize: 18,
                                                                        color: Colors.white,
                                                                        fontFamily:
                                                                        'Century Gothic', fontWeight:
                                                                    FontWeight.bold),),
                                                                    Flexible(
                                                                      child: Text("What can we"
                                                                          " do in future to "
                                                                          "improve our app? How"
                                                                          " can we help "
                                                                          "better?", style: TextStyle(
                                                                          fontSize: 16,
                                                                          color: Colors.white,
                                                                          fontFamily:
                                                                          'Century '
                                                                              'Gothic'),
                                                                        maxLines: 2,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              width: double.infinity,
                                                            ),

                                                            Padding(
                                                              padding: EdgeInsets.all(8.0),
                                                              child: TextField(
                                                                maxLength: 350,
                                                                maxLines: 8,
                                                                decoration: InputDecoration
                                                                    .collapsed(hintText: "Tell us"
                                                                    " here (Limited "
                                                                    "350 words)"),
                                                              ),
                                                            ),

                                                            Align(
                                                              alignment: Alignment.bottomRight,
                                                              child: FlatButton(
                                                                child: Text("THAT'S ALL", textAlign:
                                                                TextAlign.right, style: TextStyle(fontWeight:
                                                                FontWeight.bold, color: Colors.teal.withOpacity(0.8)),),
                                                                onPressed: (){
                                                                  Navigator.pop(context);
                                                                },
                                                              ),
                                                            )

                                                          ])));
                                                });
                                          }
                                          else{
                                            Navigator.pop(context);
                                            showDialog(context: context,
                                                builder: (BuildContext context) {
                                                  return Dialog(
                                                      elevation: 0,
                                                      backgroundColor: Colors.transparent,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(12)),
                                                      child: Container(
                                                          height: 200,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            shape: BoxShape.rectangle,
                                                            borderRadius:
                                                            BorderRadius.circular(5.0),
                                                          ),
                                                          child: Column(children: <Widget>[
                                                            Container(
                                                              height: 100,
                                                              decoration: BoxDecoration(
                                                                  gradient: LinearGradient(
                                                                      begin: Alignment.topLeft,
                                                                      end: Alignment.topRight,
                                                                      colors: <Color>[
                                                                        Color.fromRGBO(48, 187, 152, 1.0),
                                                                        Color.fromRGBO(
                                                                            146, 210, 187, 0.8),
                                                                      ]),
                                                                  shape: BoxShape.rectangle,
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius.circular(5),
                                                                      topRight:
                                                                      Radius.circular(5))),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .fromLTRB(16.0,16.0,8.0,0.0),
                                                                child: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Flexible(
                                                                      child: Text(
                                                                          "We are glad that you "
                                                                              "enjoyed the app! ",
                                                                          textAlign: TextAlign.left,
                                                                          style: TextStyle(
                                                                              fontSize: 18, color: Colors.white, fontFamily: 'Century Gothic')),
                                                                    ),
                                                                    Image.asset("images/white_rabbit.png", width: 80,),
                                                                  ],
                                                                ),
                                                              ),
                                                              width: double.infinity,
                                                            ),

                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text("Share your comment to others "
                                                                  "too!",
                                                                  textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      fontSize: 18, fontFamily: 'Century Gothic')),
                                                            ),

                                                            Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10.0),
                                                                gradient: LinearGradient(
                                                                  colors: [Color.fromRGBO(135, 209, 214, 0.8), Colors.white],
                                                                  begin: Alignment.topLeft,
                                                                  end: Alignment.bottomLeft,
                                                                ),
                                                              ),
                                                              child: FlatButton(
                                                                onPressed: (){
                                                                  Navigator.pop(context);
                                                                },
                                                                child: Text("Share now"),
                                                              ),
                                                            ),

                                                          ])));
                                                });
                                          }
                                        },
                                        child: Text("Confirm"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.history),
                      ),
                      Text('Call History'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CallHistory()));
                  },
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.lock),
                      ),
                      Text('Privacy Policy'),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        PrivacyPolicy()));
                  },
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.description),
                      ),
                      Text('Terms & Conditions'),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        TermsCondition()));
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text("Self-Care",
                style: TextStyle(
                    fontFamily: 'Century Gothic',
                    fontSize: 20,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold)),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: <Color>[
                    Color.fromRGBO(172, 229, 215, 1.0),
                    Color.fromRGBO(207, 235, 225, 1.0),
                  ])),
            ),
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu, color: Colors.grey[600], size: 40),
              ),
            ),
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("images/rabbit.png"),
                          )),
                      Flexible(
                        child: Bubble(
                          margin: BubbleEdges.only(top: 10),
                          nip: BubbleNip.leftBottom,
                          color: Color.fromRGBO(135, 209, 214, 0.8),
                          child: Text(
                            "Here are some useful ways to cope with overwhelming feelings"
                            "such as stress, depression and anxiety.",
                            maxLines: 4,
                            style:
                                TextStyle(fontSize: 16, color: Color.fromRGBO(109, 110, 113, 1.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => FeelingDiary()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset('images/myFeelingDiary.png',
                              width: size.width / 1.1,
                              height: size.height / 5.0,
                              fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 15.0),
                          child: Text("My Feelings Diary",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Century Gothic')),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => TalkToSomeone()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset('images/talkToSomeone.png',
                              width: size.width / 1.1,
                              height: size.height / 5.0,
                              fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 15.0),
                          child: Text("Talk to Someone You Trust",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Century Gothic')),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Offstage(
            offstage: !_isVisible,
            child: Container(
              width: 80,
              height: 75,
              child: FloatingActionButton(
                backgroundColor: Color.fromRGBO(125, 206, 211, 1.0),
                onPressed: () {
                  setState(() {
                    navigatePage(1);
                  });
                },
                child: Icon(Icons.home, size: 50, color: Color.fromRGBO(114, 161, 166, 1.0)),
              ),
            ),
          ),
          bottomNavigationBar: Offstage(
            offstage: !_isVisible,
            child: BottomAppBar(
                shape: CircularNotchedRectangle(),
                notchMargin: 3,
                clipBehavior: Clip.antiAlias,
                child: BottomNavigationBar(
                    onTap: navigatePage,
                    currentIndex: _index,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.map, color: Colors.white70, size: 32),
                          title: Text("Rabbit Self-Care", style: TextStyle(color: Colors.white))),
                      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("")),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.message, color: Colors.black, size: 32),
                          title: Text("Safety Info",
                              style: TextStyle(color: Colors.black, fontSize: 16))),
                    ],
                    backgroundColor: Color.fromRGBO(108, 200, 191, 1.0))),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }

  navigatePage(int tabIndex) {
    switch (tabIndex) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => selfCare()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        break;

      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SafetyInfo()));
        break;
    }
    setState(() {
      _index = tabIndex;
    });
  }
}
