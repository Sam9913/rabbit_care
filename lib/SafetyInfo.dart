import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:rabbitcare/HelpAFriend.dart';
import 'package:rabbitcare/Helplines.dart';
import 'package:rabbitcare/PsychologicalService.dart';
import 'package:rabbitcare/SuicideWarning.dart';

class SafetyInfo extends StatefulWidget {
  @override
  _SafetyInfoState createState() => _SafetyInfoState();
}

class _SafetyInfoState extends State<SafetyInfo> {
  @override
  Widget build(BuildContext context) {
		var size = MediaQuery.of(context).size;

    return Scaffold(
			drawer: Drawer(),
			appBar: AppBar(
				title: Text("Safety Info"),
			),
			body: SingleChildScrollView(
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
										child: Text("Sometimes we need more information to know how to take care "
												"of ourselves and people we care about", maxLines: 4, style: TextStyle
											(fontSize: 14, color: Color.fromRGBO(109, 110, 113, 1.0)),),
									),
								),
			  		  ],
			  		),
			  		Row(
							mainAxisAlignment: MainAxisAlignment.center,
			  			children: <Widget>[
			  				Padding(
			  				  padding: const EdgeInsets.fromLTRB(8.0,8.0,0.0,8.0),
			  				  child: InkWell(
										onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SuicideWarningSign())),
			  				    child: Container(
									width: size.width / 2.2,
			  				    		height: size.height / 3,
			  				    	decoration: BoxDecoration(
			  				    		borderRadius: BorderRadius.circular(10.0),
			  				    		color: Colors.teal,
			  				    	),
			  				    	child: Align(
												alignment: Alignment.bottomLeft,
												child: Padding(
												  padding: const EdgeInsets.all(8.0),
												  child: Text("Suicide warning signs", style: TextStyle(fontSize: 20),),
												)),
			  				    ),
			  				  ),
			  				),
			  				Padding(
			  				  padding: const EdgeInsets.all(8.0),
			  				  child: InkWell(
										onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)
		=> HelpAFriend())),
			  				    child: Container(
									width: size.width / 2.2,
			  				    		height: size.height / 3,
			  				    	decoration: BoxDecoration(
			  				    		borderRadius: BorderRadius.circular(10.0),
			  				    		color: Colors.pinkAccent,
			  				    	),
			  				    	child: Align(
												alignment: Alignment.bottomLeft,
												child: Padding(
												  padding: const EdgeInsets.all(8.0),
												  child: Text("Help a friend", style: TextStyle(fontSize: 20),),
												)),
			  				    ),
			  				  ),
			  				),
			  			],
			  		),
			  		Row(
							mainAxisAlignment: MainAxisAlignment.center,
			  			children: <Widget>[
			  				Padding(
			  				  padding: const EdgeInsets.fromLTRB(8.0,8.0,0.0,8.0),
			  				  child: InkWell(
										onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)
										=> Helplines())),
									  child: Container(
									  width: size.width / 2.2,
			  				  		height: size.height / 3,
			  				  	decoration: BoxDecoration(
			  				  		borderRadius: BorderRadius.circular(10.0),
			  				  		color: Colors.lightGreenAccent,
			  				  	),
			  				  	child: Align(
									  			alignment: Alignment.bottomLeft,
									  			child: Padding(
									  			  padding: const EdgeInsets.all(8.0),
									  			  child: Text("Helplines", style: TextStyle(fontSize: 20),),
									  			)),
			  				  ),
									),
			  				),
			  				Padding(
			  				  padding: const EdgeInsets.all(8.0),
			  				  child: InkWell(
										onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)
										=> PsychologicalService())),
			  				    child: Container(
									width: size.width / 2.2,
			  				    		height: size.height / 3,
			  				    	decoration: BoxDecoration(
			  				    		borderRadius: BorderRadius.circular(10.0),
			  				    		color: Colors.yellow,
			  				    	),
			  				    	child: Align(
												alignment: Alignment.bottomLeft,
												child: Padding(
												  padding: const EdgeInsets.all(8.0),
												  child: Text("Psychological Services", style: TextStyle(fontSize: 20),),
												)),
			  				    ),
			  				  ),
			  				),
			  			],
			  		),
			  	],
			  ),
			),
		);
  }
}
