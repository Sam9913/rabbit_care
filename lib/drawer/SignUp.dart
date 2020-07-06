import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'file:///D:/Degree/FYP/testing/rabbit_care/rabbit_care/lib/drawer/VolunteerProfile.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
	final conPasswordController = TextEditingController();
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
								Align(alignment: Alignment.centerRight, child: Text('Sign Up', style: TextStyle
									(color: Colors.grey[600]),))),
						Expanded(
							child: Padding(
									padding: EdgeInsets.only(left: 8), child: Icon(Icons.supervisor_account, color: Colors
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
			body: Column(
			  children: <Widget>[
			  	Flexible(
						child: Padding(
						  padding: const EdgeInsets.all(8.0),
						  child: Text("Thank you for your interest in signing up as a volunteer! We are looking"
						  		" for individuals who are currently volunteering in NGOS and also certified "
						  		"counsellors & psychologists, if you fulfill the requirements, please submit your"
						  		" individual details and we will get back to you through email/phone.",
						  	textAlign: TextAlign.justify,),
						),
					),

			    Padding(
			    	padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
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
			    				controller: fullNameController,
			    				decoration: InputDecoration(
			    					border: InputBorder.none,
			    					hintText: "Full Name",
			    				),
			    			),
			    		),
			    	),
			    ),

					Padding(
						padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
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
									controller: emailController,
									decoration: InputDecoration(
										border: InputBorder.none,
										hintText: "E-mail",
									),
								),
							),
						),
					),

					Padding(
						padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
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
									controller: phoneController,
									decoration: InputDecoration(
										border: InputBorder.none,
										hintText: "Phone Number",
									),
								),
							),
						),
					),

					Padding(
						padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
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
									controller: ngoController,
									decoration: InputDecoration(
										border: InputBorder.none,
										hintText: "Organization/NGOs",
									),
								),
							),
						),
					),

					Padding(
						padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
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
									controller: ngoMailController,
									decoration: InputDecoration(
										border: InputBorder.none,
										hintText: "Organization Mailing Address",
									),
								),
							),
						),
					),

					Padding(
						padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
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
									controller: passwordController,
									decoration: InputDecoration(
										border: InputBorder.none,
										hintText: "Password",
									),
								),
							),
						),
					),

					Padding(
						padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
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
									controller: conPasswordController,
									decoration: InputDecoration(
										border: InputBorder.none,
										hintText: "Confirm Password",
									),
								),
							),
						),
					),

					Padding(
						padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
						child: Container(
							decoration: BoxDecoration(
								borderRadius: BorderRadius.circular(10.0),
								gradient: LinearGradient(
									colors: [Color.fromRGBO(135, 209, 214, 0.8), Colors.white],
									begin: Alignment.topLeft,
									end: Alignment.bottomLeft,
								),
							),
							child: FlatButton(child: Text("Submit", style: TextStyle(color: Colors.black),),
								onPressed: (){
								Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
										VolunteerProfile()));
								},
							),
						),
					),
			  ],
			),
		);
  }
}
