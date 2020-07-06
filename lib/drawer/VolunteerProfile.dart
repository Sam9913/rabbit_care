import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rabbitcare/CallingPage.dart';
import 'file:///D:/Degree/FYP/testing/rabbit_care/rabbit_care/lib/drawer/YourProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VolunteerProfile extends StatefulWidget {
  @override
  _VolunteerProfileState createState() => _VolunteerProfileState();
}

class _VolunteerProfileState extends State<VolunteerProfile> {
  static bool status = false;
  int showLength = 3;
  bool duringCall = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Future.delayed(Duration.zero, ()=>callStatus(context));
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromRGBO(172, 229, 215, 1.0)),
        home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: <Widget>[],
            title: duringCall ? Row(
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
            ) : Row(
              children: <Widget>[
                Text(
                  'Volunteers',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.supervisor_account,
                      color: Colors.grey[600],
                    )),
              ],
            ),
            flexibleSpace: duringCall?  InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  CallingPage())),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.teal),
              ),
            ) : Container(
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: <Color>[
                Color.fromRGBO(172, 229, 215, 1.0),
                Color.fromRGBO(207, 235, 225, 1.0),
              ])),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => YouProfile
                          ()));
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQOKJ-JG-9p3KgnMl24G0B9g73t19_Iv3cye7pGUndT0dKobKt-&usqp=CAU"),
                        radius: 50,
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              Icons.settings,
                              color: Colors.black,
                              size: 30,
                            )),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("Name"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("NGO Organization Name"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.teal.withOpacity(0.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: InkWell(
                            onTap: () {
                              if(!duringCall){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12)),
                                        child: Container(
                                            height: 360,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
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
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                                    child: Text("Your current rating is: 4.8 stars. ",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontFamily: 'Century Gothic')),
                                                  ),
                                                  width: double.infinity,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text("Your service and help is invaluable. \n\n"
                                                          "Here are the current week's reviews about your support and care for the users. Whether it is positive or constructive, they are here to help you grow too. Keep it up! ",
                                                        textAlign: TextAlign.justify,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 64.0,
                                                            right: 64.0),
                                                        child: Divider(
                                                          thickness: 1.0,
                                                        ),
                                                      ),
                                                      Text("Thank you so much for your wise words. \n"
                                                          "\nShe is a great volunteer! \n\nI felt so "
                                                          "much better... I feel like she doesn't understand much,"
                                                          " but at least she is listening. \n\nGood, "
                                                          "thanks. ", style: TextStyle(color: Colors.grey),),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: FlatButton(
                                                    onPressed: () {  },
                                                    child: Text("DOWNLOAD\nREPORT", textAlign:
                                                    TextAlign.right, style: TextStyle(fontWeight:
                                                    FontWeight.bold, color: Colors.teal.withOpacity(0.8)),),
                                                  ),
                                                )
                                              ],
                                            )),
                                      );
                                    });
                              }
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                ),
                                Text(
                                  " Rating : ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "4.8",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: InkWell(
                            onTap: () {
                              if(!duringCall){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12)),
                                        child: Container(
                                            height: 300,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
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
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                                    child: Text("Your cancellation rate is 3%",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontFamily: 'Century Gothic')),
                                                  ),
                                                  width: double.infinity,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text("This rate is calculated based on users\' "
                                                          "self-report. When the users did not obtain the sufficient support or "
                                                          "felt that your ser-vice was cut short due to unforseeable reasons, your service "
                                                          "will be rated as being cancelled.This cancellation"
                                                          " rate is to prevent volunteers from picking up "
                                                          "calls but did not deliv-er their service due to "
                                                          "environmental or personal reasons. It serves as "
                                                          "an indicator of your support for others.The "
                                                          "cancellation rate Is calculated as follow.",
                                                        textAlign: TextAlign.justify,),
                                                      Image.asset("images/calculation.png"),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                      );
                                    });
                              }
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                ),
                                Text(
                                  " Cancellation : ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "3%",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "I am ready to listen",
                        style: TextStyle(fontSize: 16),
                      ),
                      Expanded(
                        flex: 1,
                        child: SwitchListTile(
                          onChanged: (value) {
                            setState(() {
                              if(!duringCall){
                                status = value;
                              }
                            });
                          },
                          value: duringCall? true : status,
                          activeTrackColor: Colors.teal.withOpacity(0.5),
                          activeColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: Divider(
                    thickness: 1.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: SizedBox(
                      width: size.width,
                      child: Text("Call History", style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: showLength,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                      child: Container(
                        color: Color.fromRGBO(77, 182, 172, 0.2),
                        child: ExpansionTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                index.toString() + " Mar 2020, 13:50",
                                style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "17:00 - 17:50 (50 min)",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eu "
                                      "metus nibh. In eu felis eu tellus accumsan sagittis. Pellentesque "
                                      "rhoncus, lorem non dapibus malesuada, urna diam pretium neque, placerat "
                                      "efficitur risus mauris vel purus. Quisque tristique dapibus quam, quis "
                                      "convallis mi feugiat vitae. "),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width,
                    color: Color.fromRGBO(77, 182, 172, 0.2),
                    child: FlatButton(
                      child: Text(
                        "See More",
                        style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        setState(() {
                          showLength += 5;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    ),
      );
  }

  callStatus(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool afterCall = false;
    bool getCall = false;
    bool missCall = false;
    if(afterCall){
      //prefs.setBool("afterCall", false);

      showDialog(
          context: context,
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
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Your support to others is always important. You may write "
                              "down some notes about the call just now as a record. ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'Century Gothic')),
                        ),
                        width: double.infinity,
                      ),

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          maxLength: 350,
                          maxLines: 8,
                          decoration: InputDecoration.collapsed(hintText: "Type here (Limited "
                              "350 words)"),
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                          child: Text("SAVE", textAlign:
                          TextAlign.right, style: TextStyle(fontWeight:
                          FontWeight.bold, color: Colors.teal.withOpacity(0.8)),),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  )),
            );
          });
    }
    if(getCall){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            var size = MediaQuery.of(context).size;
            return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("A caller is calling.\nWould you able to accept the call?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'Century Gothic')),
                        ),
                        width: double.infinity,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                    Colors.teal.withOpacity(0.7),
                                    Colors.white,
                                  ]),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10)),
                          width: size.width/3,
                          child: FlatButton(
                            onPressed: () {
                              prefs.setBool("getCall", false);
                              Navigator.pop(context);
                            },
                            child: Text("Accept", style: TextStyle(color: Colors.white, fontSize:
                            16),),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                    Colors.red,
                                    Colors.white,
                                  ]),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10)),
                          width: size.width/3,
                          child: FlatButton(
                            onPressed: () {
                              prefs.setBool("getCall", false);
                              Navigator.pop(context);
                            },
                            child: Text("Decline", style: TextStyle(color: Colors.white, fontSize:
                            16),),
                          ),
                        ),
                      ),
                    ],
                  )),
            );
          });
    }
    if(missCall){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            var size = MediaQuery.of(context).size;
            return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.lock),
                              Text("To start receiving calls again, tap on the button below",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Century Gothic')),
                            ],
                          ),
                        ),
                        width: double.infinity,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                    Colors.teal.withOpacity(0.7),
                                    Colors.white,
                                  ]),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10)),
                          width: size.width/3,
                          child: FlatButton(
                            onPressed: () {
                              prefs.setBool("missCall", false);
                              Navigator.pop(context);
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.lock_open),
                                Text(" Unlock", style: TextStyle(fontSize: 16),),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  )),
            );
          });
    }
  }
}

