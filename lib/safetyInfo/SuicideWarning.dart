import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:bubble/bubble.dart';

class SuicideWarningSign extends StatefulWidget {
  @override
  _SuicideWarningSignState createState() => _SuicideWarningSignState();
}

class _SuicideWarningSignState extends State<SuicideWarningSign> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
			appBar: AppBar(
				title: Align(
						alignment: Alignment.centerRight,
						child: Text("Suicide warning signs")),
				leading: GestureDetector(
						onTap: () => Navigator.pop(context),
						child: Icon(Icons.keyboard_arrow_left)),
			),
			body: Padding(
			  padding: const EdgeInsets.all(8.0),
			  child: SingleChildScrollView(
			    child: Column(
			    	crossAxisAlignment: CrossAxisAlignment.start,
			    	children: <Widget>[
			    		Bubble(
			    				color: Color.fromRGBO(135, 209, 214, 0.8),
			    				child: Text("Do a self-check or help others to notice the well being"
			    				".", textAlign: TextAlign.center,)),
			    		Padding(
			    		  padding: const EdgeInsets.all(8.0),
			    		  child: ConfigurableExpansionTile(
			    		  	header: Flexible(
			    		  	  child: Padding(
			    		  	    padding: const EdgeInsets.all(8.0),
			    		  	    child: Row(
			    		  	  		children: <Widget>[
			    		  	  			CircleAvatar(
			    		  	  				radius: 16,
			    		  	  				backgroundColor: Colors.grey,
			    		  	  				child: CircleAvatar(
			    		  	  					radius: 15,
			    		  	  					child: Text("1", style: TextStyle(color: Colors.black),),
			    		  	  					backgroundColor: Colors.white,
			    		  	  				),
			    		  	  			),
			    		  	  			Padding(
			    		  	  				padding: const EdgeInsets.only(left: 8.0),
			    		  	  				child: Text("General feelings", style: TextStyle(color: Colors.black,
			    		  	  						fontWeight: FontWeight.bold),),
			    		  	  			),
			    		  	  		],
			    		  	  	),
			    		  	  ),
			    		  	),
			    		  	animatedWidgetFollowingHeader: const Icon(
			    		  		Icons.expand_more,
			    		  		color: Colors.grey,
			    		  	),
			    		  	children: <Widget>[
			    		  		Padding(
			    		  		  padding: const EdgeInsets.only(left: 56.0),
			    		  		  child: Column(
			    		  		  	children: <Widget>[
			    		  		  		Row(
			    		  		  			children: <Widget>[
			    		  		  				CircleAvatar(
			    		  		  					radius: 2,
			    		  		  					backgroundColor: Colors.black,),
			    		  		  				Padding(
			    		  		  				  padding: const EdgeInsets.only(left: 8.0),
			    		  		  				  child: Text("Feeling hopeless and helpless."),
			    		  		  				),
			    		  		  			],
			    		  		  		),
			    		  		  		Row(
			    		  		  			children: <Widget>[
			    		  		  				CircleAvatar(
			    		  		  					radius: 2,
			    		  		  					backgroundColor: Colors.black,),
			    		  		  				Padding(
			    		  		  				  padding: const EdgeInsets.only(left: 8.0),
			    		  		  				  child: Text("Feeling in rage or furious."),
			    		  		  				),
			    		  		  			],
			    		  		  		),
			    		  		  		Row(
			    		  		  			children: <Widget>[
			    		  		  				CircleAvatar(
			    		  		  					radius: 2,
			    		  		  					backgroundColor: Colors.black,),
			    		  		  				Padding(
			    		  		  				  padding: const EdgeInsets.only(left: 8.0),
			    		  		  				  child: Text("Depressed or sad most of the time."),
			    		  		  				),
			    		  		  			],
			    		  		  		),
			    		  		  		Row(
			    		  		  			children: <Widget>[
			    		  		  				CircleAvatar(
			    		  		  					radius: 2,
			    		  		  					backgroundColor: Colors.black,),
			    		  		  				Padding(
			    		  		  				  padding: const EdgeInsets.only(left: 8.0),
			    		  		  				  child: Text("Experiencing frequent mood swings."),
			    		  		  				),
			    		  		  			],
			    		  		  		),
			    		  		  		Row(
			    		  		  			children: <Widget>[
			    		  		  				CircleAvatar(
			    		  		  					radius: 2,
			    		  		  					backgroundColor: Colors.black,),
			    		  		  				Padding(
			    		  		  					padding: const EdgeInsets.only(left: 8.0),
			    		  		  					child: Text("Feeling a lot of guilt or shame."),
			    		  		  				),
			    		  		  			],
			    		  		  		),
			    		  		  	],
			    		  		  ),
			    		  		)
			    		  	],
			    		  ),
			    		),


			    		Padding(
			    			padding: const EdgeInsets.all(8.0),
			    			child: ConfigurableExpansionTile(
			    				header: Flexible(
			    					child: Padding(
			    						padding: const EdgeInsets.all(8.0),
			    						child: Row(
			    							children: <Widget>[
			    								CircleAvatar(
			    									radius: 16,
			    									backgroundColor: Colors.grey,
			    									child: CircleAvatar(
			    										radius: 15,
			    										child: Text("2", style: TextStyle(color: Colors.black),),
			    										backgroundColor: Colors.white,
			    									),
			    								),
			    								Padding(
			    									padding: const EdgeInsets.only(left: 8.0),
			    									child: Text("Behaviours", style: TextStyle(color: Colors.black,
			    											fontWeight: FontWeight.bold),),
			    								),
			    							],
			    						),
			    					),
			    				),
			    				animatedWidgetFollowingHeader: const Icon(
			    					Icons.expand_more,
			    					color: Colors.grey,
			    				),
			    				children: <Widget>[
			    					Padding(
			    						padding: const EdgeInsets.only(left: 56.0),
			    						child: Column(
			    							children: <Widget>[
			    								Row(
			    									children: <Widget>[
			    										CircleAvatar(
			    											radius: 2,
			    											backgroundColor: Colors.black,),
			    										Flexible(
			    										  child: Padding(
			    										  	padding: const EdgeInsets.only(left: 8.0),
			    										  	child: Text("Discuss or write down about death or suicide.",
			    										  		maxLines: 2,),
			    										  ),
			    										),
			    									],
			    								),
			    								Row(
			    									children: <Widget>[
			    										CircleAvatar(
			    											radius: 2,
			    											backgroundColor: Colors.black,),
			    										Padding(
			    											padding: const EdgeInsets.only(left: 8.0),
			    											child: Text("Changes in personality observed."),
			    										),
			    									],
			    								),
			    								Row(
			    									children: <Widget>[
			    										CircleAvatar(
			    											radius: 2,
			    											backgroundColor: Colors.black,),
			    										Padding(
			    											padding: const EdgeInsets.only(left: 8.0),
			    											child: Text("Impulsive decision making."),
			    										),
			    									],
			    								),
			    								Row(
			    									children: <Widget>[
			    										CircleAvatar(
			    											radius: 2,
			    											backgroundColor: Colors.black,),
			    										Flexible(
			    										  child: Padding(
			    										  	padding: const EdgeInsets.only(left: 8.0),
			    										  	child: Text("Unable to perform and cope at work or in school.",
			    													maxLines: 2,),
			    										  ),
			    										),
			    									],
			    								),
			    								Row(
			    									children: <Widget>[
			    										CircleAvatar(
			    											radius: 2,
			    											backgroundColor: Colors.black,),
			    										Padding(
			    											padding: const EdgeInsets.only(left: 8.0),
			    											child: Text("Withdrawing from family and friends."),
			    										),
			    									],
			    								),
			    								Row(
			    									children: <Widget>[
			    										CircleAvatar(
			    											radius: 2,
			    											backgroundColor: Colors.black,),
															Flexible(
															  child: Padding(
			    											padding: const EdgeInsets.only(left: 8.0),
			    											child: Text("Give away important personal belongings."),
			    										),
															),
			    									],
			    								),
			    								Row(
			    									children: <Widget>[
			    										CircleAvatar(
			    											radius: 2,
			    											backgroundColor: Colors.black,),
			    										Padding(
			    											padding: const EdgeInsets.only(left: 8.0),
			    											child: Text("Writing a will."),
			    										),
			    									],
			    								),
			    							],
			    						),
			    					)
			    				],
			    			),
			    		),


			    		Padding(
			    			padding: const EdgeInsets.all(8.0),
			    			child: ConfigurableExpansionTile(
			    				header: Flexible(
			    					child: Padding(
			    						padding: const EdgeInsets.all(8.0),
			    						child: Row(
			    							children: <Widget>[
			    								CircleAvatar(
			    									radius: 16,
			    									backgroundColor: Colors.grey,
			    									child: CircleAvatar(
			    										radius: 15,
			    										child: Text("3", style: TextStyle(color: Colors.black),),
			    										backgroundColor: Colors.white,
			    									),
			    								),
			    								Padding(
			    									padding: const EdgeInsets.only(left: 8.0),
			    									child: Text("Thoughts", style: TextStyle(color: Colors.black,
			    											fontWeight: FontWeight.bold),),
			    								),
			    							],
			    						),
			    					),
			    				),
			    				animatedWidgetFollowingHeader: const Icon(
			    					Icons.expand_more,
			    					color: Colors.grey,
			    				),
			    				children: <Widget>[
			    					Padding(
			    						padding: const EdgeInsets.only(left: 56.0),
			    						child: Column(
			    							children: <Widget>[
			    								Row(
			    									children: <Widget>[
			    										CircleAvatar(
			    											radius: 2,
			    											backgroundColor: Colors.black,),
			    										Flexible(
			    										  child: Padding(
			    										  	padding: const EdgeInsets.only(left: 8.0),
			    										  	child: Text("Thinks that there no way out of a difficult situation"
			    														".", maxLines: 2,),
			    										  ),
			    										),
			    									],
			    								),
			    								Row(
			    									children: <Widget>[
			    										CircleAvatar(
			    											radius: 2,
			    											backgroundColor: Colors.black,),
			    										Flexible(
			    										  child: Padding(
			    										  	padding: const EdgeInsets.only(left: 8.0),
			    										  	child: Text("Lost interest in most activities or previously enjoyed "
			    										  			"hobbies.", maxLines: 2,),
			    										  ),
			    										),
			    									],
			    								),
			    							],
			    						),
			    					)
			    				],
			    			),
			    		),

			    		Padding(
			    			padding: const EdgeInsets.all(8.0),
			    			child: ConfigurableExpansionTile(
			    				header: Flexible(
			    					child: Padding(
			    						padding: const EdgeInsets.all(8.0),
			    						child: Row(
			    							children: <Widget>[
			    								CircleAvatar(
			    									radius: 16,
			    									backgroundColor: Colors.grey,
			    									child: CircleAvatar(
			    										radius: 15,
			    										child: Text("4", style: TextStyle(color: Colors.black),),
			    										backgroundColor: Colors.white,
			    									),
			    								),
			    								Padding(
			    									padding: const EdgeInsets.only(left: 8.0),
			    									child: Text("Others", style: TextStyle(color: Colors.black,
			    											fontWeight: FontWeight.bold),),
			    								),
			    							],
			    						),
			    					),
			    				),
			    				animatedWidgetFollowingHeader: const Icon(
			    					Icons.expand_more,
			    					color: Colors.grey,
			    				),
			    				children: <Widget>[
			    					Padding(
			    						padding: const EdgeInsets.only(left: 56.0),
			    						child: Column(
			    							children: <Widget>[
			    								Row(
			    									children: <Widget>[
			    										CircleAvatar(
			    											radius: 2,
			    											backgroundColor: Colors.black,),
			    										Padding(
			    											padding: const EdgeInsets.only(left: 8.0),
			    											child: Text("Abuse drugs or alcohol."),
			    										),
			    									],
			    								),
			    								Row(
			    									children: <Widget>[
			    										CircleAvatar(
			    											radius: 2,
			    											backgroundColor: Colors.black,),
			    										Flexible(
			    										  child: Padding(
			    										  	padding: const EdgeInsets.only(left: 8.0),
			    										  	child: Text("Not getting enough sleep, or sleeping too much.",
			    													maxLines: 2,),
			    										  ),
			    										),
			    									],
			    								),
			    								Row(
			    									children: <Widget>[
			    										CircleAvatar(
			    											radius: 2,
			    											backgroundColor: Colors.black,),
			    										Padding(
			    											padding: const EdgeInsets.only(left: 8.0),
			    											child: Text("Eating too little or too much."),
			    										),
			    									],
			    								),
			    							],
			    						),
			    					)
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