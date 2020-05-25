import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:url_launcher/url_launcher.dart';

class Helplines extends StatefulWidget {
  @override
  _HelplinesState createState() => _HelplinesState();
}

class _HelplinesState extends State<Helplines> {
	Future<void> _launched;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			appBar: AppBar(
				title: Align(alignment: Alignment.centerRight, child: Text("Helplines")),
				leading: GestureDetector(
						onTap: () => Navigator.pop(context), child: Icon(Icons.keyboard_arrow_left)),
			),
			body: SingleChildScrollView(
				child: Padding(
					padding: const EdgeInsets.all(8.0),
					child: Column(
						children: <Widget>[
							Bubble(
								color: Color.fromRGBO(135, 209, 214, 0.8),
								child: Text(
									"Want to contact specific helplines? \nHere are all the contact information of "
											"the available helplines in Malaysia",
									textAlign: TextAlign.center,
								),
							),
							Padding(
							  padding: const EdgeInsets.all(8.0),
							  child: Container(
							  	decoration: BoxDecoration(
										color: Color.fromRGBO(173, 216, 230, 1.0),
										borderRadius: BorderRadius.circular(10.0),
									),
							  	child: Row(
							  		children: <Widget>[
							  			Expanded(
													flex: 9,
													child: Padding(
													  padding: const EdgeInsets.all(8.0),
													  child: Text("All centers"),
													)),
							  			Padding(
							  			  padding: const EdgeInsets.all(8.0),
							  			  child: Icon(Icons.search),
							  			),
							  		],
							  	),
							  ),
							),
							Padding(
								padding: const EdgeInsets.all(8.0),
								child: Container(
									color: Color.fromRGBO(173, 216, 230, 0.25),
									child: Padding(
									  padding: const EdgeInsets.fromLTRB(8.0,16.0,8.0,8.0),
									  child: Column(
									  	mainAxisAlignment: MainAxisAlignment.start,
									  	crossAxisAlignment: CrossAxisAlignment.start,
									  	children: <Widget>[
									  		Text("1. Life Line Association Malaysia", style: TextStyle(fontWeight:
									  		FontWeight.bold),),
									  		Row(
									  		  children: <Widget>[
														Icon(Icons.language, color: Color.fromRGBO(95, 158, 160, 1.0),),
									  		    Padding(
															padding: const EdgeInsets.only(left: 8.0),
									  		      child: RawMaterialButton(
									  		      	onPressed: () => setState(() {
									  		      		_launched = _launchInWebViewWithJavaScript("http://lifeline.org.my/cn/");
									  		      	}),
									  		      	child: const Text('http://lifeline.org.my/cn/', style: TextStyle
																	(color: Color.fromRGBO(95, 158, 160, 1.0)),),
									  		      ),
									  		    ),
									  		  ],
									  		),
									  		Row(
									  		  children: <Widget>[
														Icon(Icons.location_on),
									  		    Flexible(
									  		      child: Padding(
									  		        padding: const EdgeInsets.only(left: 8.0),
									  		        child: Text("No. 1-3, 3rd Floor, Jalan Jelatek 1, Pusat Perniagaan Jelatek, "
									  		        		"Setiawangsa, 54200 Kuala Lumpur"),
									  		      ),
									  		    ),
									  		  ],
									  		),
									  	],
									  ),
									),
								),
							),
							Padding(
							  padding: const EdgeInsets.all(8.0),
							  child: Container(
							    color: Color.fromRGBO(173, 216, 230, 0.25),
							    child: Padding(
							      padding: const EdgeInsets.fromLTRB(8.0,16.0,8.0,8.0),
							      child: Column(
							  			mainAxisAlignment: MainAxisAlignment.start,
							  			crossAxisAlignment: CrossAxisAlignment.start,
							  			children: <Widget>[
							  				Text("2. Bestfrienders Kuala Lumpur", style: TextStyle(fontWeight:
							  				FontWeight.bold),),
							  				Row(
							  				  children: <Widget>[
														Icon(Icons.language, color: Color.fromRGBO(95, 158, 160, 1.0),),
							  				    Padding(
															padding: const EdgeInsets.only(left: 8.0),
							  				      child: RawMaterialButton(
							  				      	onPressed: () => setState(() {
							  				      		_launched = _launchInWebViewWithJavaScript("https://www.befrienders.org.my/");
							  				      	}),
							  				      	child: const Text("https://www.befrienders.org.my/", style: TextStyle(color: Color.fromRGBO(95, 158, 160, 1.0)),),
							  				      ),
							  				    ),
							  				  ],
							  				),
							  				Row(
							  				  children: <Widget>[
							  				  	Icon(Icons.location_on),
														Flexible(
														  child: Padding(
							  				      padding: const EdgeInsets.only(left: 8.0),
							  				      child: Text("95 Jalan Templer, 46000 Petaling Jaya, Selangor, Malaysia"),
							  				    ),
														),
							  				  ],
							  				),
							  			],
							  		),
							    ),
							  ),
							),
						],
					),
				),
			),
		);
  }

	Future<void> _launchInWebViewWithJavaScript(String url) async {
		if (await canLaunch(url)) {
			await launch(
				url,
				forceSafariVC: true,
				forceWebView: true,
				enableJavaScript: true,
			);
		} else {
			throw 'Could not launch $url';
		}
	}
}
