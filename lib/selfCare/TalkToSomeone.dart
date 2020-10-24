import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:url_launcher/url_launcher.dart';

class TalkToSomeone extends StatefulWidget {
  @override
  _TalkToSomeoneState createState() => _TalkToSomeoneState();
}

class _TalkToSomeoneState extends State<TalkToSomeone> {
  List<TextEditingController> personController = [TextEditingController(),TextEditingController(),TextEditingController()];
  bool isClick = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for(TextEditingController textEditingController in personController){
      textEditingController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Talk to someone you trust",
              style: TextStyle(color: Colors.black),
            )),
        flexibleSpace: Container(
          child: Image(
            image: AssetImage("images/talkToSomeone.png"),
            fit: BoxFit.cover,
          ),
        ),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.keyboard_arrow_left, color: Colors.black)),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              isClick = !isClick;
            });
          },icon: Icon(Icons.info, color: Colors.black87,)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Offstage(
                offstage: isClick,
                child: Bubble(
                  color: Color.fromRGBO(135, 209, 214, 0.8),
                  child: Text(
                    "Contact someone who you trust, your loved one, your family, or your friend. "
                        "It's okay to seek help from others.",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                      colors: [Color.fromRGBO(135, 209, 214, 0.8), Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Name 3 persons you trust the most"),
                  ),
                ),
              ),

              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: personController[index],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Person " + (index + 1).toString(),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                      colors: [Color.fromRGBO(135, 209, 214, 0.8), Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Do you want to call them now?"),
                  ),
                ),
              ),

        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: FlatButton(child: Text("Yes, I want", style: TextStyle(color: Colors.black),),
                onPressed: ()async{
              launch("tel://21213123123");
              },),
          ),
        ),
            ],
          ),
        ),
      ),
    );
  }
}
