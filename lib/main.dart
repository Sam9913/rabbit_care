import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rabbitcare/volunteer/VolunteerProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'HomePage.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if(sharedPreferences.getString("expire") != null) {
    DateTime expireDateTime = DateTime.parse(sharedPreferences.getString("expire"));
    if (expireDateTime
        .difference(DateTime.now())
        .isNegative) {
      sharedPreferences.clear();
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SplashScreen(),
        theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 142, 142, 1.0),
        ));
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  String token;
  @override
  void initState() {
    super.initState();
    getData();
    Future.delayed(Duration(seconds: 4), () {
      token != null? Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VolunteerProfile(),
          )) :
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    });
  }

  getData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences.getString("token");
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Container(
            width: size.width,
            height: size.height,
            child: Image.asset("images/front page background 2-29.png", fit: BoxFit.fill,)),
        ),
    );
  }
}

