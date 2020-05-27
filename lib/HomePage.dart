import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rabbitcare/CallingPage.dart';
import 'package:rabbitcare/privacy.dart';
import 'package:rabbitcare/safetyInfo/SafetyInfo.dart';
import 'package:rabbitcare/selfCare/self-care.dart';
import 'package:rabbitcare/termsCondition.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final keyIsFirstLoaded = 'is_first_loaded';
  ScrollController _hideBottomBar;
  bool _isVisible;
  bool showText = false;
  bool showLanguage = false;
  bool isChecked = true;
  Map<String, bool> language = {"English (Default)": true, "Bahasa Malaysia": false, "华文": false};
  int _index = 0;

  @override
  void initState() {
    // TODO: implement initState
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
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
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
                                padding: EdgeInsets.only(left: 8), child: Icon(Icons.settings)),
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
                    // Update the state of the app.
                    // ...
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
                    // Update the state of the app.
                    // ...
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
                    // Update the state of the app.
                    // ...
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
                    // Update the state of the app.
                    // ...
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
          body: SingleChildScrollView(
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
                        style: TextStyle(fontFamily: 'Century Gothic', color: Colors.black54),
                        children: [
                          TextSpan(
                              text: 'Are you feeling overwhelmed, \n or having suicidal thoughts ？',
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
                          context, MaterialPageRoute(builder: (context) => CallingPage()));
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        child: Row(
                          children: <Widget>[
                            Icon(showText ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                size: 35, color: Colors.white),
                            Text("  Who am I calling ？",
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
                  showText
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 0.0),
                          child: SizedBox(
                            height: 130,
                            child: Text(
                                "You will be connected to volunteers from Berienders, Life Line Association "
                                "and trained cousellors and pshcho-logists... across Malaysia, based on whoever"
                                "available on the line.",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        child: Row(
                          children: <Widget>[
                            Icon(showLanguage ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                size: 35, color: Colors.white),
                            Text("  Changing preferences",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontFamily: 'Century Gothic'),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                  ),
                  showLanguage
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 20.0),
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
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
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
                child: Icon(Icons.home, size: 50, color: Colors.white70),
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
                          icon: Icon(Icons.map, color: Colors.black, size: 32),
                          title: Text("Rabbit Self-Care", style: TextStyle(color: Colors.black))),
                      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("")),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.message, color: Colors.black, size: 32),
                          title: Text("Safety Info", style: TextStyle(color: Colors.black))),
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

  showDialogIfFirstLoaded(BuildContext context) async {
    String volunteer = "v";
    String generalUser = "gu";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (isFirstLoaded == null) {
      // return object of type Dialog
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                        child: Text(
                            "\nHi there, welcome to RabbitCare! \nAre you a volunteer or a general\nuser？ \n",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, color: Colors.white, fontFamily: 'Century Gothic')),
                        width: double.infinity,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: RaisedButton(
                                onPressed: () {
                                  prefs.setBool(keyIsFirstLoaded, false);
                                  prefs.setString("chooseType", volunteer);
                                  Navigator.of(context).pop();
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
                                    constraints:
                                        const BoxConstraints(minWidth: 130.0, minHeight: 50.0),
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
                                  prefs.setBool(keyIsFirstLoaded, false);
                                  prefs.setString("chooseType", generalUser);
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
                                    constraints:
                                        const BoxConstraints(minWidth: 130.0, minHeight: 50.0),
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
}
