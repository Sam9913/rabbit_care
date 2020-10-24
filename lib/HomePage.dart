import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rabbitcare/CallingPage.dart';
import 'package:rabbitcare/model/User.dart';
import 'package:rabbitcare/volunteer/SignUp.dart';
import 'package:rabbitcare/volunteer/VolunteerLogIn.dart';
import 'package:rabbitcare/drawer/privacy.dart';
import 'package:rabbitcare/safetyInfo/SafetyInfo.dart';
import 'package:rabbitcare/selfCare/self-care.dart';
import 'package:rabbitcare/drawer/termsCondition.dart';
import 'package:rabbitcare/volunteer/CheckStatus.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;

import 'drawer/CallHistory.dart';

class HomePage extends StatefulWidget {
  static String role;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String ratingScore = "I hate it";
  double _rating = 0.0;
  final keyIsFirstLoaded = 'is_first_loaded';
  ScrollController _hideBottomBar;
  bool changeRole;
  bool _isVisible;
  bool showText = false;
  bool showLanguage = false;
  bool isChecked = true;
  bool showBox = false;
  bool duringCall = false;
  List<String> role = ["Volunteer", "General User"];
  Map<String, bool> feedback = {
    "The volunteer cancelled the call after picking up.": false,
    "Volunteer was unsympathetic.": false,
    "Couldn't connect to a volunteer for a long time.": false,
    "Others": false
  };
  Map<String, bool> language = {
    "English (Default)": true,
    "Bahasa Malaysia": false,
    "华文": false
  };
  int _index = 0;
  String token;
  final TextEditingController inviationCode = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    inviationCode.dispose();
  }

  @override
  void initState() {
    super.initState();
    _hideBottomBar = new ScrollController();
    _isVisible = true;
    _hideBottomBar.addListener(
          () {
        if (_hideBottomBar.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_isVisible)
            setState(() {
              _isVisible = false;
            });
        }
        if (_hideBottomBar.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!_isVisible)
            setState(() {
              _isVisible = true;
            });
        }
      },
    );
    getData();
  }

  getData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      HomePage.role = sharedPreferences.getString("chooseType");
      changeRole = HomePage.role == "v";
      token = sharedPreferences.getString("token");
    });
  }

  changeOnRole(String role) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("chooseType", role);

    setState(() {
      HomePage.role = role;
    });
  }

  checkInvitationCode(String code) async{
    var response = await http.get("https://rabbitcare.000webhostapp"
        ".com/api/invitationcode/code=" + code);

    var temp = jsonDecode(response.body);
    if(response.statusCode == 200 && temp.length > 0){
      InvitationCode tempCode = InvitationCode.fromJson(temp[0]);
      print(tempCode.toString());
      if(tempCode.used_by == null || tempCode.used_by.isEmpty) {
        Navigator.pop(context);

        setState(() {
          inviationCode.clear();
        });

        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SignUp(remarks: code,)));
      }
      else{
        Fluttertoast.showToast(
            msg: "Invitation code already used by other volunteer.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
    else{
      Fluttertoast.showToast(
          msg: "Invitation code is invalid. Please ask inviter for help.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }

  Widget volunteerHomePage(){
    var size = MediaQuery.of(context).size;

    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0,100.0,8.0,8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text("Hi, welcome volunteer.\n",
                  style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder:
                          (context) => Login()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Material(
                        child: SizedBox(
                          width: size.width / 3,
                          height: size.height / 6,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Icon(Icons.account_box, size: 50,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Log In", style: TextStyle(fontSize: 20),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        color: Color.fromRGBO(172, 229, 215, 1.0),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 40,
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
                                        child: Text(
                                            "Invitation code",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 18, color: Colors.white, fontFamily: 'Century Gothic')),
                                      ),
                                      width: double.infinity,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(16.0,8.0,16.0,8.0),
                                      child: TextField(
                                        controller: inviationCode,
                                        decoration: InputDecoration(
                                          border:
                                          new UnderlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
                                          hintText: "ex. ABC-123",
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                        padding: const EdgeInsets.all(0.0),
                                        onPressed: (){
                                          checkInvitationCode(inviationCode.text);
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: <Color>[
                                              Colors.tealAccent[100],
                                              Colors.grey[100],
                                            ],
                                            ),
                                          ),
                                          child: Container(
                                            constraints: BoxConstraints(minWidth: 100.0, minHeight:
                                            36.0),
                                            child: Center(
                                              child: Text("Verify",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 18, fontFamily: 'Century Gothic',
                                                      color: Colors.grey[600],
                                                      fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Material(
                        child: SizedBox(
                          width: size.width / 3,
                          height: size.height / 6,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Icon(Icons.person, size: 50,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Sign Up", style: TextStyle(fontSize: 20),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        color: Color.fromRGBO(172, 229, 215, 1.0),
                      ),
                    ),
                  ),
                ],
              ),

              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckStatus()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Material(
                      child: SizedBox(
                        width: size.width/1.3,
                        height: size.height / 6,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Icon(Icons.verified_user, size: 50,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text("Check Registered Status", style: TextStyle
                                  (fontSize: 20),),
                              ),
                            ],
                          ),
                        ),
                      ),
                      color: Color.fromRGBO(172, 229, 215, 1.0),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget generalUser(){
    return SingleChildScrollView(
      controller: _hideBottomBar,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                      fontFamily: 'Century Gothic',
                      color: Colors.black54),
                  children: [
                    TextSpan(
                        text:
                        'Are you feeling overwhelmed, \n or having suicidal thoughts ？',
                        style: TextStyle(fontSize: 23)),
                    TextSpan(
                        text:
                        '\n You hope someone care and \n you wish to chat about something',
                        style: TextStyle(fontSize: 17)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
              child: Text("How about talk to us now？",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Century Gothic',
                      fontWeight: FontWeight.bold)),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CallingPage()))
                    .then((value) {
                  if (value == true) {
                    setState(() async {
                      duringCall = false;
                      showRatingDialog(context);
                    });
                  }
                  if (value == "duringCall") {
                    setState(() async{
                      duringCall = true;
                    });
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                child: Image.asset(
                  "images/home.png",
                  width: 300,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(35.0, 15.0, 35.0, 0.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: RaisedButton(
                  color: Color.fromRGBO(0, 142, 142, 1.0),
                  onPressed: () {
                    setState(() {
                      showText = !showText;
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: <Widget>[
                      Icon(
                          showText
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 35,
                          color: Colors.white),
                      Text("  Who am I calling ？",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontFamily: 'Century Gothic'),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ),
            showText
                ? Padding(
              padding:
              const EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 0.0),
              child: SizedBox(
                height: 130,
                child: Text(
                    "You will be connected to volunteers from Berienders, Life Line Association "
                        "and trained counsellors and psycho-logists... across Malaysia, based on whoever"
                        "available on the line.",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.justify),
              ),
            )
                : SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(35.0, 20.0, 35.0, 0.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: RaisedButton(
                  color: Color.fromRGBO(0, 142, 142, 1.0),
                  onPressed: () {
                    setState(() {
                      showLanguage = !showLanguage;
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: <Widget>[
                      Icon(
                          showLanguage
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 35,
                          color: Colors.white),
                      Text("  Changing preferences",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Century Gothic'),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ),
            showLanguage
                ? Padding(
              padding:
              const EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 20.0),
              child: SizedBox(
                height: 200,
                child: ListView(
                  children: language.keys.map((String key) {
                    return new CheckboxListTile(
                      title: new Text(key,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Century Gothic',
                          )),
                      value: language[key],
                      activeColor: Color.fromRGBO(0, 142, 142, 1.0),
                      onChanged: (bool value) async {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        setState(() {
                          language[key] = value;
                          prefs.setBool(key, value);
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            )
                : SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(token != null){
      SystemNavigator.pop();
    }

    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromRGBO(172, 229, 215, 1.0)),
      home: SafeArea(
        child: Scaffold(
          drawer:  duringCall
              ? null
              : Drawer(
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
                Offstage(
                  offstage: HomePage.role == "v",
                  child: ListTile(
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
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context) => CallHistory()));
                    },
                  ),
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.question_answer),
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
          appBar: duringCall
              ?  AppBar(
            flexibleSpace:Container(
              decoration: BoxDecoration(color: Colors.teal),
            ),
            title:
            InkWell(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CallingPage())),
              child:Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                      )),
                  Text(
                    'Connecting... Tap to return call',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ) : AppBar(
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
            actions: <Widget>[
              SizedBox(
                width: 250,
                child: SwitchListTile(
                  activeTrackColor: Colors.teal,
                  activeColor: Colors.tealAccent,
                  title: Text(
                    changeRole ? role[0] : role[1],
                    style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.right,
                  ),
                  value: changeRole,
                  onChanged: (value) {
                    String role = "gu";
                    if(value){
                      role = "v";
                    }
                    changeOnRole(role);
                    setState(() {
                      changeRole = value;
                    });
                  },
                ),
              ),
            ],
          ),
          body: HomePage.role != "v" ? generalUser() : volunteerHomePage(),
          floatingActionButton: Offstage(
            offstage: !_isVisible || HomePage.role != "gu",
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
                child: Icon(Icons.home, size: 50, color: Colors.white70),
              ),
            ),
          ),
          bottomNavigationBar: Offstage(
            offstage: !_isVisible || HomePage.role != "gu",
            child: BottomAppBar(
                shape: CircularNotchedRectangle(),
                notchMargin: 3,
                clipBehavior: Clip.antiAlias,
                child: BottomNavigationBar(
                    onTap: navigatePage,
                    currentIndex: _index,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.map, color: Colors.black, size: 32),
                          title: Text("Rabbit Self-Care",
                              style: TextStyle(color: Colors.black))),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), title: Text("")),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.message,
                              color: Colors.black, size: 32),
                          title: Text("Safety Info",
                              style: TextStyle(color: Colors.black))),
                    ],
                    backgroundColor: Color.fromRGBO(108, 200, 191, 1.0))),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }

  navigatePage(int tabIndex) {
    switch (tabIndex) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => selfCare()));
        break;
      case 1:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        break;

      case 2:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SafetyInfo()));
        break;
    }
    setState(() {
      _index = tabIndex;
    });
  }

  showDialogIfFirstLoaded(BuildContext context) async {
    String volunteer = "v";
    String generalUser = "gu";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (isFirstLoaded == null) {
      // return object of type Dialog
      showDialog(
          context: context,
          barrierDismissible: false,
          //set to false if you want to force to choose
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
                    borderRadius: BorderRadius.circular(10.0),
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
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Text(
                            "\nHi there, welcome to RabbitCare! \nAre you a volunteer or a general\nuser？ \n",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'Century Gothic')),
                        width: double.infinity,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    changeRole = true;
                                    HomePage.role = volunteer;
                                    prefs.setBool(keyIsFirstLoaded, false);
                                    prefs.setString("chooseType", volunteer);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  });
                                },
                                padding: const EdgeInsets.all(0.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.topRight,
                                        colors: <Color>[
                                          Color.fromRGBO(48, 187, 152, 1.0),
                                          Color.fromRGBO(146, 210, 187, 0.8),
                                        ]),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    constraints: const BoxConstraints(
                                        minWidth: 130.0, minHeight: 50.0),
                                    child: Text("Volunteer",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'Century Gothic'),
                                        textAlign: TextAlign.center),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    changeRole = false;
                                    HomePage.role = generalUser;
                                    prefs.setBool(keyIsFirstLoaded, false);
                                    prefs.setString("chooseType", generalUser);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  });
                                },
                                padding: const EdgeInsets.all(0.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.topRight,
                                        colors: <Color>[
                                          Color.fromRGBO(48, 187, 152, 1.0),
                                          Color.fromRGBO(146, 210, 187, 0.8),
                                        ]),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    constraints: const BoxConstraints(
                                        minWidth: 130.0, minHeight: 50.0),
                                    child: Text("General User",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'Century Gothic'),
                                        textAlign: TextAlign.center),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  )),
            );
          });
    }
  }

  showRatingDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Container(
                    height: MediaQuery.of(context).size.height / 2.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 80,
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
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Text(
                              "\nHow do you feel about the support and care from the volunteer?",
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'Century Gothic')),
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: SmoothStarRating(
                            allowHalfRating: false,
                            onRated: (value) {
                              setState(() {
                                _rating = value;
                              });
                            },
                            starCount: 5,
                            rating: _rating,
                            size: 50,
                            color: Colors.yellow,
                            borderColor: Colors.grey,
                            spacing: 15.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                              _rating == 5.0
                                  ? 'I love it'
                                  : ((_rating < 5.0) & (_rating > 3.0))
                                  ? 'I like it.'
                                  : ((_rating < 4.0) & (_rating > 2.0))
                                  ? 'It\'s okay.'
                                  : ((_rating < 3.0) & (_rating > 1.0))
                                  ? 'I don\'t like it.'
                                  : 'I hate it.',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Century Gothic')),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0.0),
                          child: Divider(
                            thickness: 1.0,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                showFeedbackDialog(context, _rating);
                              });
                            },
                            child: Text("SUBMIT",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(48, 187, 152, 1.0),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Century Gothic'),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    )),
              );
            },
          );
        });
  }

  showFeedbackDialog(BuildContext context, double rating) async {
    if (rating <= 3.0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Dialog(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    height: showBox
                        ? MediaQuery.of(context).size.height / 1.8
                        : MediaQuery.of(context).size.height / 1.3,
                    //height: MediaQuery.of(context).size.height / 2.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 80,
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
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Text(
                                "\nCould you share with us what happened?",
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: 'Century Gothic')),
                            width: double.infinity,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 3.3,
                              child: ListView(
                                children: feedback.keys.map((String key) {
                                  return new CheckboxListTile(
                                    controlAffinity:
                                    ListTileControlAffinity.leading,
                                    title: new Text(key,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Century Gothic',
                                        )),
                                    value: feedback[key],
                                    activeColor:
                                    Color.fromRGBO(0, 142, 142, 1.0),
                                    onChanged: (bool value) async {
                                      setState(() {
                                        feedback[key] = value;
                                      });
                                      print(key);
                                      if (key == "Others") {
                                        showBox = !showBox;
                                      }
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          showBox
                              ? SizedBox(
                            height: 0,
                          )
                              : Padding(
                            padding: const EdgeInsets.fromLTRB(
                                60.0, 10.0, 20.0, 0.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height /
                                  5.0,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                shape: BoxShape.rectangle,
                              ),
                              child: TextField(
                                style: TextStyle(
                                    fontFamily: 'Century Gothic'),
                                maxLines: null,
                                decoration: InputDecoration.collapsed(
                                    hintText: " Please specify here..."),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                180.0, 30.0, 0.0, 0.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text("THAT'S ALL",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(48, 187, 152, 1.0),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Century Gothic'),
                                  textAlign: TextAlign.right),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          });
    } //if
    else if (rating >= 4.0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 120,
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
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Text(
                              "\nWe glad that you enjoyed your conversation with our volunteer! You may"
                                  "share your comment here with the volunteer anonymously.",
                              maxLines: 6,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'Century Gothic')),
                          width: double.infinity,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: SizedBox(
                            height: 180,
                            child: TextField(
                              style: TextStyle(fontFamily: 'Century Gothic'),
                              maxLines: null,
                              decoration: InputDecoration.collapsed(
                                  hintText: " Type here..."),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(180.0, 30.0, 0.0, 0.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            },
                            child: Text("THAT'S ALL",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(48, 187, 152, 1.0),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Century Gothic'),
                                textAlign: TextAlign.right),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    } //else if
  }
}