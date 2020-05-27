import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
			appBar: AppBar(
				title: Row(
					children: <Widget>[
						Expanded(
								flex: 8,
								child:
								Align(alignment: Alignment.centerRight, child: Text('Privacy Policy', style:
								TextStyle
									(color: Colors.grey[600]),))),
						Expanded(
							child: Padding(
									padding: EdgeInsets.only(left: 8), child: Icon(Icons.lock, color: Colors
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
			  child: Text("Informations...", style: TextStyle(fontWeight: FontWeight.bold, fontSize:
				20),),
			),
		);
  }
}
