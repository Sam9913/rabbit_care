
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rabbitcare/drawer/SignUp.dart';
import 'package:rabbitcare/drawer/VolunteerProfile.dart';
import 'package:rabbitcare/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
	@override
	_LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
	final nameController = TextEditingController();
	final passwordController = TextEditingController();

	@override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
  }

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Row(
					children: <Widget>[
						Expanded(
								flex: 8,
								child:
								Align(alignment: Alignment.centerRight, child: Text('Volunteer Pages', style:
								TextStyle
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
				crossAxisAlignment: CrossAxisAlignment.start,
				children: <Widget>[
					Padding(
					  padding: const EdgeInsets.all(8.0),
					  child: Center(
					    child: CircleAvatar(
					    	radius: 70,
					    	backgroundColor: Colors.lightBlueAccent,
					    	backgroundImage: NetworkImage("https://pecb.com/conferences/wp-content/uploads/2017/10/no-profile-picture.jpg"),
					    ),
					  ),
					),

					Padding(
					  padding: const EdgeInsets.all(8.0),
					  child: TextField(
							controller: nameController,
							decoration: InputDecoration(
								hintText: "Email",
							),
						),
					),
					Padding(
					  padding: const EdgeInsets.all(8.0),
					  child: TextField(
							controller: passwordController,
							decoration: InputDecoration(
								hintText: "Password",
							),
						),
					),

					Padding(
					  padding: const EdgeInsets.all(8.0),
					  child: Container(
					  	decoration: BoxDecoration(
					  		borderRadius: BorderRadius.circular(10.0),
					  		gradient: LinearGradient(
					  			colors: [Color.fromRGBO(135, 209, 214, 0.8), Colors.white],
					  			begin: Alignment.topLeft,
					  			end: Alignment.bottomLeft,
					  		),
					  	),
					  	child: FlatButton(
								onPressed: (){
									login(nameController.text, passwordController.text);
									//
								},
					  		child: Text("Log In",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
					  	),
					  ),
					),

					Padding(
					  padding: const EdgeInsets.fromLTRB(16.0,16.0,8.0,8.0),
					  child: InkWell(
							onTap: (){
								showDialog(
										context: context,
										builder: (BuildContext context) {
											return Dialog(
												elevation: 0,
												backgroundColor: Colors.transparent,
												shape: RoundedRectangleBorder(
														borderRadius: BorderRadius.circular(12)),
												child: Container(
														height: 160,
														decoration: BoxDecoration(
															color: Colors.white,
															shape: BoxShape.rectangle,
														),
														child: Column(
															children: <Widget>[
																Container(
																	child: Padding(
																		padding: const EdgeInsets.fromLTRB(16.0,8.0,8.0,0.0),
																		child: Row(
																		  children: <Widget>[
																		    Text("Recover Password",
																		    		textAlign: TextAlign.left,
																		    		style: TextStyle(
																		    				fontSize: 18,
																		    				fontWeight: FontWeight.bold,
																		    				color: Colors.black,
																		    				fontFamily: 'Century Gothic')),
																				Expanded(
																					flex: 1,
																				  child: Align(
																				  	alignment: Alignment.centerRight,
																				    child: Padding(
																							padding: const EdgeInsets.only(right:8.0),
																				      child: GestureDetector(
																				      	onTap: (){
																				      		Navigator.pop(context);
																				      	},
																				      	child: Icon(Icons.close),
																				      ),
																				    ),
																				  ),
																				),
																		  ],
																		),
																	),
																	width: double.infinity,
																),

																Padding(
																	padding: EdgeInsets.all(8.0),
																	child: TextField(
																		decoration: InputDecoration(
																			labelText: "Your email or username",
																		),
																	),
																),

																Align(
																	alignment: Alignment.center,
																	child: Container(
																	  child: FlatButton(
																	  	child: Text("EMAIL ME A RECOVERY LINK", textAlign:
																	  	TextAlign.center, style: TextStyle(fontWeight:
																	  	FontWeight.bold),),
																	  	onPressed: (){
																	  		Navigator.pop(context);
																	  	},
																	  ),
																		decoration: BoxDecoration(
																			gradient: LinearGradient(
																					begin: Alignment.topLeft,
																					end: Alignment.topRight,
																					colors: <Color>[
																						Color.fromRGBO(48, 187, 152, 1.0),
																						Color.fromRGBO(146, 210, 187, 0.8),
																					]),
																			borderRadius: BorderRadius.circular(20.0),
																		),
																	),
																)
															],
														)),
											);
										});
							},
					  	child: Text("Forgot password?",style: TextStyle(color: Colors.lightBlueAccent,
									fontWeight: FontWeight.bold),),
					  ),
					),
					Padding(
					  padding: const EdgeInsets.fromLTRB(16.0,8.0,8.0,8.0),
					  child: InkWell(
					  	onTap: (){
					  		Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
					  	},
					  	child: Text("Sign Up as volunteer",style: TextStyle(color: Colors.lightBlueAccent,
									fontWeight: FontWeight.bold),),
					  ),
					),
					Padding(
						padding: const EdgeInsets.fromLTRB(16.0,8.0,8.0,8.0),
						child: InkWell(
							onTap: (){

							},
							child: Text("Check registration status",style: TextStyle(color: Colors
									.lightBlueAccent,
									fontWeight: FontWeight.bold),),
						),
					),
				],
			),
		);
	}

	void login(String email, String password) async {
		SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

		Map data = {
			'password': password,
			'email': email,
		};

		var response = await http.post("https://rabbitcare.000webhostapp.com/api/auth/login", body:
		data);

		if(response.statusCode == 200){
			Token token = Token.fromJson(json.decode(response.body));
			sharedPreferences.setString("token", token.token_type + " " + token.access_token);
			sharedPreferences.setString("expire", token.expire_at);

			await getUser();
		}
		else{
			Fluttertoast.showToast(
					msg: "Server is busy, please try again later.",
					toastLength: Toast.LENGTH_SHORT,
					gravity: ToastGravity.BOTTOM,
					timeInSecForIosWeb: 1,
					backgroundColor: Colors.black,
					textColor: Colors.white,
					fontSize: 16.0
			);
		}
	}

	getUser() async{
		SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
		String token = sharedPreferences.getString("token");

		var response = await http.get("https://rabbitcare.000webhostapp.com/api/auth/user", headers: {
			'Authorization': token,
		});

		if(response.statusCode == 200){
			User user = User.fromJson(json.decode(response.body));

			if(user.email_verified_at == null){
				Fluttertoast.showToast(
						msg: "Your email haven't be verified.",
						toastLength: Toast.LENGTH_SHORT,
						gravity: ToastGravity.BOTTOM,
						timeInSecForIosWeb: 1,
						backgroundColor: Colors.black,
						textColor: Colors.white,
						fontSize: 16.0
				);

				return;
			}

			Fluttertoast.showToast(
					msg: "Welcome back, " + user.username,
					toastLength: Toast.LENGTH_SHORT,
					gravity: ToastGravity.BOTTOM,
					timeInSecForIosWeb: 1,
					backgroundColor: Colors.black,
					textColor: Colors.white,
					fontSize: 16.0
			);

			Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>VolunteerProfile
				(user: user,)));
		}
		else{
			logout();
		}
	}

	logout() async{
		SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
		String token = sharedPreferences.getString("token");

		var response = await http.get("https://rabbitcare.000webhostapp.com/api/auth/logout",
				headers: {
					'Authorization': token,
				});

		if(response.statusCode == 200) {
			sharedPreferences.remove("token");
		}
	}

}
