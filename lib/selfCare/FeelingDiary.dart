import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

class FeelingDiary extends StatefulWidget {
  @override
  _FeelingDiaryState createState() => _FeelingDiaryState();
}

class _FeelingDiaryState extends State<FeelingDiary> {
	int showLength = 5;
	bool off = false;
  List<String> emotion = <String>["Depressed", "Angry", "Anxious", "Peaceful", "Joyful", "Others"];
  List<String> emotionIcon = <String>[
    "images/sad.png",
    "images/angry.png",
    "images/anxious"
        ".png",
    "images/peace.png",
    "images/joy.png",
    "images/other.png"
  ];
  List<String> appreciate = <String>[
    "Family",
    "Supportive Friends",
    "Good Health",
    "Yummy food",
    "Ni"
        "ce Weather",
    "Others"
  ];
  List<String> appreciateIcon = <String>[
    "images/family.png",
    "images/friends.png",
    "images/health"
        ".png",
    "images/food.png",
    "images/weather.png",
    "images/other.png"
  ];
  List<Color> emotionColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];
  List<Color> appreciationColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Feeling Diary",
              style: TextStyle(color: Colors.black),
            )),
        flexibleSpace: Container(
          child: Image(
            image: AssetImage("images/myFeelingDiary.png"),
            fit: BoxFit.cover,
          ),
        ),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.keyboard_arrow_left, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Bubble(
                color: Color.fromRGBO(135, 209, 214, 0.8),
                child: Text(
                  "Writing your feelings down and acknowledge them, it will help you to feel more"
                  " ease",
                  textAlign: TextAlign.center,
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
                    child: Text("How do you feel right now?"),
                  ),
                ),
              ),
              Container(
                height: size.height / 3.5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: emotion.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          emotionColor[index] = Color.fromRGBO(135, 209, 214, 0.8);
                          for (int i = 0; i < emotionColor.length; i++) {
                            if (i != index) {
                              emotionColor[i] = Colors.white;
                            }
                          }
                          if (index == emotion.length - 1) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)), //this right here
                                    child: Container(
                                      height: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Please list down your current feeling: "),
                                            TextField(
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Eg. Frustrated, Worry, Rejoice'),
                                            ),
                                            SizedBox(
                                              width: size.width,
                                              child: RaisedButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "Save",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                color: const Color(0xFF1BC0C5),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.width,
                                              child: RaisedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }
                        });
                      },
                      child: Card(
                          elevation: 0.4,
                          color: emotionColor[index],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  emotionIcon[index],
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(emotion[index]),
                              ],
                            ),
                          )),
                    );
                  },
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
                    child: Text("What do I appreciate in my life?"),
                  ),
                ),
              ),
              Container(
                height: size.height / 3.5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: appreciate.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          appreciationColor[index] = Color.fromRGBO(135, 209, 214, 0.8);
                          for (int i = 0; i < appreciationColor.length; i++) {
                            if (i != index) {
                              appreciationColor[i] = Colors.white;
                            }
                          }
                          if (index == appreciate.length - 1) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)), //this right here
                                    child: Container(
                                      height: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Please list down what you appreciate: "),
                                            TextField(
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Eg. Funny video, Games, Everything'),
                                            ),
                                            SizedBox(
                                              width: size.width,
                                              child: RaisedButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "Save",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                color: const Color(0xFF1BC0C5),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.width,
                                              child: RaisedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }
                        });
                      },
                      child: Card(
                          elevation: 0.4,
                          color: appreciationColor[index],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  appreciateIcon[index],
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(appreciate[index]),
                              ],
                            ),
                          )),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  minLines: 4,
                  maxLines: 8,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    hintText: "Enter your text here\nEg. I am feeling specifically\nI am "
                        "appreciate ... because ... (type)",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.teal,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            "images/white_rabbit.png",
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "RabbitTip: No matter how small the appreciation you have, write them down. "
                        "Being reminded of what you appreciate of could help to lighten your mood.",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              Offstage(
								offstage: off,
                child: Padding(
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
                      child: Text("My Previous Record"),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: showLength,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        ExpansionTile(
                          title: Text(
                            index.toString()  + " Mar 2020, 13:50",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      "I feel anxious right now. What I appreciate is my supportive family."),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

							Offstage(
								offstage: off,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(child: Text("See More", style: TextStyle(color: Colors.blue),),
										onPressed: (){
                    		setState(() {
												showLength += 5;
                    		});
										},),
                    Text(" | ", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
									FlatButton(child: Text("Clear History", style: TextStyle(color: Colors.blue),),
										onPressed: (){
										setState(() {
										  showLength = 0;
										  off = true;
										});
										},
									),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
