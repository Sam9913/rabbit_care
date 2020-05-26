import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bubble/bubble.dart';
import 'package:rabbitcare/safetyInfo/SafetyInfo.dart';
import 'package:rabbitcare/selfCare/FeelingDiary.dart';
import 'package:rabbitcare/selfCare/TalkToSomeone.dart';
import 'dart:async';
import '../HomePage.dart';

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

  @override
  void initState() {
    // TODO: implement initState
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
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromRGBO(172, 229, 215, 1.0)),
      home: SafeArea(
        child: Scaffold(
          drawer: Drawer(),
          appBar: AppBar(
            title: Text("Self-Care",
                style: TextStyle(
                    fontFamily: 'Century Gothic',
                    fontSize: 20,
                    color:Colors.grey[600],
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
                          child: Text("Here are some useful ways to cope with overwhelming feelings"
                              "such as stress, depression and anxiety.", maxLines: 4, style: TextStyle
                            (fontSize: 16, color: Color.fromRGBO(109, 110, 113, 1.0)),),
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
                              width: size.width/1.1, height: size.height/5.0,fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 15.0),
                          child:Text("My Feelings Diary",
                            style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Century Gothic')),
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
                              width: size.width/1.1, height: size.height/5.0,fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 15.0),
                          child:Text("Talk to Someone You Trust",
                              style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Century Gothic')),
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
                child: Icon(Icons.home,
                    size: 50, color: Color.fromRGBO(114, 161, 166, 1.0)),
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
                        icon:Icon(Icons.map, color: Colors.white70, size: 32),
                              title: Text("Rabbit Self-Care",
                              style: TextStyle(color: Colors.white))),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), title: Text("")),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.message,
                              color: Colors.black, size: 32),
                          title: Text("Safety Info",
                              style: TextStyle(color: Colors.black,fontSize:16))),
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
}
