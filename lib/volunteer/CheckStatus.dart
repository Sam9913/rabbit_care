import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:rabbitcare/model/User.dart';

class CheckStatus extends StatefulWidget {
  @override
  _CheckStatusState createState() => _CheckStatusState();
}

class _CheckStatusState extends State<CheckStatus> {
  final TextEditingController usernameController = TextEditingController();
  String verifiedMessage = "Invalid";

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Status check",style: TextStyle(color: Colors.grey[600]),),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.keyboard_arrow_left, color: Colors.grey[600])),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient:
              LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: <Color>[
                Color.fromRGBO(172, 229, 215, 1.0),
                Color.fromRGBO(207, 235, 225, 1.0),
              ])),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Enter username to check whether registration have been verified.", style:
          TextStyle(fontSize: 20), textAlign: TextAlign.center,),
              Padding(
                padding: const EdgeInsets.only(left:8.0, right:8.0),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border:
                    new UnderlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
                    labelText: "Username",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: <Color>[
                        Color.fromRGBO(172, 229, 215, 1.0),
                        Color.fromRGBO(207, 235, 225, 1.0),
                      ],
                      ),
                    ),
                    child: Container(
                        constraints: BoxConstraints(maxWidth: size.width, minHeight: 36.0),
                        child: Center(child: Text("Submit",style: TextStyle(color: Colors
                            .grey[600], fontWeight: FontWeight.bold),))),
                  ),
                  onPressed: (){
                    getStatus(usernameController.text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getStatus(String username) async{
    var response = await http.get("https://rabbitcare.000webhostapp.com/api/user/username=" + username);

    if(response.statusCode == 200){
      List<dynamic> tempUser = jsonDecode(response.body);
      User user = User.fromJson(tempUser[0]);
      setState(() {
        verifiedMessage = user.email_verified_at == null ? "Not yet verified. Do wait for 2 - 3 "
            "days more." : "User already verified on " +  user.email_verified_at;
      });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 70,
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
                                "Registration status   ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white, fontFamily: 'Century Gothic')),
                            Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset("images/white_rabbit.png", width: 80,))),
                          ],
                        ),
                      ),
                      width: double.infinity,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(verifiedMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontFamily: 'Century Gothic')),
                    ),

                  ],
                ),
              ),
            );
          });
    }else{
      Fluttertoast.showToast(
          msg: "Username did not exist.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    //https://rabbitcare.000webhostapp.com/api/user/username=test
  }
}
