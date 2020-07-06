import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class CallHistory extends StatefulWidget {
	@override
	_CallHistoryState createState() => _CallHistoryState();
}

class _CallHistoryState extends State<CallHistory> {
	Future<void> _launched;
	final fullNameController = TextEditingController();
	final emailController = TextEditingController();
	final phoneController = TextEditingController();
	final ngoController = TextEditingController();
	final ngoMailController = TextEditingController();
	final passwordController = TextEditingController();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Row(
					children: <Widget>[
						Expanded(
								flex: 8,
								child:
								Align(alignment: Alignment.centerRight, child: Text('Call History', style: TextStyle
									(color: Colors.grey[600]),))),
						Expanded(
							child: Padding(
									padding: EdgeInsets.only(left: 8), child: Icon(Icons.history, color: Colors
									.grey[600],)),
						),
					],
				),
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
				leading: GestureDetector(
						onTap: () => Navigator.pop(context),
						child: Icon(Icons.keyboard_arrow_left, color: Colors.grey[600])),
			),
			body: Padding(
			  padding: const EdgeInsets.all(8.0),
			  child: Column(
			    children: <Widget>[
			      Text("Your privacy matters.\nWe ensure that all your information are kept anonymous."
								"\nThe information here is for you to contact organizations which you have "
								"connected if you would like to book extra service from them.",textAlign:
						TextAlign.center, style: TextStyle(fontSize: 20),),

						Container(
						  child: Padding(
						    padding: const EdgeInsets.fromLTRB(8.0,16.0,8.0,8.0),
						    child: Align(
									alignment: Alignment.centerLeft,
									child: Text("Recent activity", style: TextStyle(fontWeight: FontWeight.bold,
						  			fontSize: 16, color: Colors.black54),),
								),
						  ),
						),

						ListView.builder(
							shrinkWrap: true,
							itemCount: 3,
								itemBuilder: (context, snapshot){
								return Container(
									decoration: BoxDecoration(
										borderRadius: BorderRadius.circular(10.0),
										color: Color.fromRGBO(77, 182, 172, 0.1),
									),
									child: Padding(
									  padding: const EdgeInsets.fromLTRB(0.0,0.0,8.0,8.0),
									  child: ListTile(
									  	title: Align(
									  		alignment: Alignment.centerLeft,
									  	  child: RawMaterialButton(
									  	  		onPressed: () => setState(() {
									  	  			_launched = _launchInWebViewWithJavaScript("http://lifeline.org.my/cn/");
									  	  		}),
									  	  		child: Text("Life Line Association Malaysia", style: TextStyle(color:
									  	  		Colors.blue, fontWeight: FontWeight.bold),)),
									  	),
									  	subtitle: Text(snapshot.toString() + " Mar 2020"),
									  ),
									),
								);
								},
						)
			    ],
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
