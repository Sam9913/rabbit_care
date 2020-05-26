import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

class FeelingDiary extends StatefulWidget {
  @override
  _FeelingDiaryState createState() => _FeelingDiaryState();
}

class _FeelingDiaryState extends State<FeelingDiary> {
	List<String> emotion = <String>["Depressed","Angry","Anxious","Peaceful","Joyful","Others"];
	List<String> emotionIcon = <String>["images/sad.png", "images/angry.png","images/anxious"
			".png","images/peace.png","images/joy.png","images/other.png"];
	List<String> appreciate = <String>["Family","Supportive Friends","Good Health","Yummy food","Ni"
			"ce Weather", "Others"];
	List<String> appreciateIcon = <String>["images/family.png", "images/friends.png","images/health"
			".png","images/food.png","images/weather.png","images/other.png"];

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
								padding: const EdgeInsets.fromLTRB(8.0,16.0,8.0,8.0),
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
							  	itemBuilder: (context, index){
							  		return Card(
											elevation: 0.4,
												child: Padding(
												  padding: const EdgeInsets.all(8.0),
												  child: Column(
												    children: <Widget>[
												    	Image.asset(emotionIcon[index], width: 100,),
												      SizedBox(height: 20,),
												      Text(emotion[index]),
												    ],
												  ),
												));
							  	},
							  ),
							),

              Padding(
                padding: const EdgeInsets.fromLTRB(8.0,16.0,8.0,8.0),
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
									itemCount: emotion.length,
									itemBuilder: (context, index){
										return Card(
												elevation: 0.4,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: Column(
														children: <Widget>[
															Image.asset(appreciateIcon[index], width: 100,),
															SizedBox(height: 20,),
															Text(appreciate[index]),
														],
													),
												));
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
							    	      child: Image.asset("images/white_rabbit.png", width: 30,),
							    	    ),
							    	  ),
							    	),
							      Flexible(
							        child: Text("RabbitTip: No matter how small the appreciation you have, write them down. "
							        		"Being reminded of what you appreciate of could help to lighten your mood.",
							        	style: TextStyle(fontSize: 12),),
							      ),
							    ],
							  ),
							),

							Padding(
								padding: const EdgeInsets.fromLTRB(8.0,16.0,8.0,8.0),
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

							ListView.builder(
								shrinkWrap: true,
								itemCount: 3,
								itemBuilder: (context, index){
									return Padding(
										padding: const EdgeInsets.all(8.0),
										child: Column(
											children: <Widget>[
												ExpansionTile(
													title: Text("3 Mar 2020, 13:50", style: TextStyle(color: Colors.black,
															fontWeight: FontWeight.bold),),
													children: <Widget>[
														Padding(
															padding: const EdgeInsets.all(8.0),
															child: Column(
																mainAxisAlignment: MainAxisAlignment.start,
																crossAxisAlignment: CrossAxisAlignment.start,
																children: <Widget>[
																	Text("I feel anxious right now. What I appreciate is my supportive family."),
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
            ],
          ),
        ),
      ),
    );
  }
}
