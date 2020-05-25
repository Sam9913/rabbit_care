import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/rendering.dart';
import 'package:rabbitcare/safetyInfo/HelpAFriend.dart';
import 'package:rabbitcare/safetyInfo/Helplines.dart';
import 'package:rabbitcare/safetyInfo/PsychologicalService.dart';
import 'package:rabbitcare/safetyInfo/SuicideWarning.dart';
import 'package:rabbitcare/selfCare/self-care.dart';

import '../HomePage.dart';

class SafetyInfo extends StatefulWidget {
  @override
  _SafetyInfoState createState() => _SafetyInfoState();
}

class _SafetyInfoState extends State<SafetyInfo> {
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
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text("Safety Info",
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
        body: SingleChildScrollView(
          controller: _hideBottomBar,
          child: Column(
            children: <Widget>[
              Row(
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
                        "Sometimes we need more information to know how to take care "
                        "of ourselves and people we care about...",
                        maxLines: 4,
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(109, 110, 113, 1.0)),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SuicideWarningSign())),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset('images/suicideWarning.png',
                                width: size.width/2.2, height: size.height/3,fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 15.0),
                            child:Text("Suicide Warning \nSigns",
                                style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Century Gothic')),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HelpAFriend())),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset('images/helpAFriend.png',
                                width: size.width/2.2, height: size.height/3,fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 15.0),
                            child:Text("Help a Friend",
                                style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Century Gothic')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Helplines())),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset('images/helplines.png',
                                width: size.width/2.2, height: size.height/3,fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 15.0),
                            child:Text("Helplines",
                                style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Century Gothic')),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,8.0),
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PsychologicalService())),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset('images/psychology.png',
                                width: size.width/2.2, height: size.height/3,fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 15.0),
                            child:Text("Psychological \nServices",
                                style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Century Gothic')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
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
                        icon: Icon(Icons.map, color: Colors.black, size: 32),
                        title: Text("Rabbit Self-Care",
                            style: TextStyle(color: Colors.black))),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), title: Text("")),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.message,
                            color: Colors.white70, size: 32),
                        title: Text("Safety Info",
                            style: TextStyle(color: Colors.white,fontSize:16))),
                  ],
                  backgroundColor: Color.fromRGBO(108, 200, 191, 1.0))),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
