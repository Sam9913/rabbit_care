
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rabbitcare/volunteer/SignUp.dart';
import 'package:rabbitcare/volunteer/VolunteerProfile.dart';
import 'package:rabbitcare/model/User.dart';
import 'package:rabbitcare/volunteer/CheckStatus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
	@override
	_LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
	final nameController = TextEditingController();
	final passwordController = TextEditingController();
	final TextEditingController inviationCode = TextEditingController();
	bool visible = true;

	@override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    inviationCode.dispose();
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
			body: SingleChildScrollView(
			  child: Column(
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
								obscureText: visible,
			  				decoration: InputDecoration(
			  					hintText: "Password",
										suffixIcon: visible ? InkWell(
												onTap: (){
													setState(() {
														visible = !visible;
													});
												},
												child: Icon(Icons.visibility_off)) : InkWell(
												onTap: (){
													setState(() {
														visible = !visible;
													});
												},
												child: Icon(Icons.visibility))
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
			  									shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
			  									child: Container(
			  										height: 180,
			  										decoration: BoxDecoration(
			  											color: Colors.white,
			  											shape: BoxShape.rectangle,
			  											borderRadius: BorderRadius.circular(5.0),
			  										),
			  										child: Column(
			  											children: <Widget>[
			  												Container(
			  													height: 40,
			  													decoration: BoxDecoration(
			  															gradient: LinearGradient(
			  																	begin: Alignment.topLeft,
			  																	end: Alignment.topRight,
			  																	colors: <Color>[
			  																		Color.fromRGBO(48, 187, 152, 1.0),
			  																		Color.fromRGBO(146, 210, 187, 0.8),
			  																	]),
			  															shape: BoxShape.rectangle,
			  															borderRadius: BorderRadius.only(
			  																	topLeft: Radius.circular(5), topRight: Radius
			  																	.circular(5))),
			  													child: Padding(
			  														padding: const EdgeInsets.all(8.0),
			  														child: Text(
			  																"Recovery Link",
			  																textAlign: TextAlign.center,
			  																style: TextStyle(
			  																		fontSize: 18, color: Colors.white, fontFamily: 'Century Gothic')),
			  													),
			  													width: double.infinity,
			  												),

			  												Padding(
			  													padding: const EdgeInsets.fromLTRB(16.0,8.0,16.0,8.0),
			  													child: TextField(
			  														controller: nameController,
			  														decoration: InputDecoration(
			  															border:
			  															new UnderlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
			  															labelText: "Username",
			  														),
			  													),
			  												),

			  												Padding(
			  													padding: const EdgeInsets.all(8.0),
			  													child: RaisedButton(
			  														shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
			  														padding: const EdgeInsets.all(0.0),
			  														onPressed: (){
			  															sendPassword(nameController.text);
			  														},
			  														child: Ink(
			  															decoration: BoxDecoration(
			  																borderRadius: BorderRadius.circular(20.0),
			  																gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: <Color>[
			  																	Colors.tealAccent[100],
			  																	Colors.grey[100],
			  																],
			  																),
			  															),
			  															child: Container(
			  																constraints: BoxConstraints(minWidth: 100.0, minHeight:
			  																36.0),
			  																child: Center(
			  																	child: Text("Continue",
			  																		textAlign: TextAlign.center,
			  																		style: TextStyle(
			  																				fontSize: 18, fontFamily: 'Century Gothic',
			  																				color: Colors.grey[600],
			  																				fontWeight: FontWeight.bold),
			  																	),
			  																),
			  															),
			  														),
			  													),
			  												),

			  											],
			  										),
			  									),
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
			  					showDialog(
			  							context: context,
			  							builder: (BuildContext context) {
			  								return Dialog(
			  									elevation: 0,
			  									backgroundColor: Colors.transparent,
			  									shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
			  									child: Container(
			  										height: 180,
			  										decoration: BoxDecoration(
			  											color: Colors.white,
			  											shape: BoxShape.rectangle,
			  											borderRadius: BorderRadius.circular(5.0),
			  										),
			  										child: Column(
			  											children: <Widget>[
			  												Container(
			  													height: 40,
			  													decoration: BoxDecoration(
			  															gradient: LinearGradient(
			  																	begin: Alignment.topLeft,
			  																	end: Alignment.topRight,
			  																	colors: <Color>[
			  																		Color.fromRGBO(48, 187, 152, 1.0),
			  																		Color.fromRGBO(146, 210, 187, 0.8),
			  																	]),
			  															shape: BoxShape.rectangle,
			  															borderRadius: BorderRadius.only(
			  																	topLeft: Radius.circular(5), topRight: Radius
			  																	.circular(5))),
			  													child: Padding(
			  														padding: const EdgeInsets.all(8.0),
			  														child: Text(
			  																"Invitation code",
			  																textAlign: TextAlign.center,
			  																style: TextStyle(
			  																		fontSize: 18, color: Colors.white, fontFamily: 'Century Gothic')),
			  													),
			  													width: double.infinity,
			  												),

			  												Padding(
			  													padding: const EdgeInsets.fromLTRB(16.0,8.0,16.0,8.0),
			  													child: TextField(
			  														controller: inviationCode,
			  														decoration: InputDecoration(
			  															border:
			  															new UnderlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
			  															hintText: "ex. ABC-123",
			  														),
			  													),
			  												),

			  												Padding(
			  													padding: const EdgeInsets.all(8.0),
			  													child: RaisedButton(
			  														shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
			  														padding: const EdgeInsets.all(0.0),
			  														onPressed: (){
			  															checkInvitationCode(inviationCode.text);
			  														},
			  														child: Ink(
			  															decoration: BoxDecoration(
			  																borderRadius: BorderRadius.circular(20.0),
			  																gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: <Color>[
			  																	Colors.tealAccent[100],
			  																	Colors.grey[100],
			  																],
			  																),
			  															),
			  															child: Container(
			  																constraints: BoxConstraints(minWidth: 100.0, minHeight:
			  																36.0),
			  																child: Center(
			  																	child: Text("Verify",
			  																		textAlign: TextAlign.center,
			  																		style: TextStyle(
			  																				fontSize: 18, fontFamily: 'Century Gothic',
			  																				color: Colors.grey[600],
			  																				fontWeight: FontWeight.bold),
			  																	),
			  																),
			  															),
			  														),
			  													),
			  												),

			  											],
			  										),
			  									),
			  								);
			  							});
			  		  	},
			  		  	child: Text("Sign Up as volunteer",style: TextStyle(color: Colors.lightBlueAccent,
			  						fontWeight: FontWeight.bold),),
			  		  ),
			  		),
			  		Padding(
			  			padding: const EdgeInsets.fromLTRB(16.0,8.0,8.0,8.0),
			  			child: InkWell(
			  				onTap: (){
			  					Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckStatus()));
			  				},
			  				child: Text("Check registration status",style: TextStyle(color: Colors
			  						.lightBlueAccent,
			  						fontWeight: FontWeight.bold),),
			  			),
			  		),
			  	],
			  ),
			),
		);
	}

	checkInvitationCode(String code) async{
		var response = await http.get("https://rabbitcare.000webhostapp"
				".com/api/invitationcode/code=" + code);

		if(response.statusCode == 200 && jsonDecode(response.body).length > 0){
			Navigator.pop(context);
			Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp(remarks: code,)));
		}
		else{
			Fluttertoast.showToast(
					msg: "Invitation code is invalid. Please ask inviter for help.",
					toastLength: Toast.LENGTH_LONG,
					gravity: ToastGravity.BOTTOM,
					timeInSecForIosWeb: 1,
					backgroundColor: Colors.black,
					textColor: Colors.white,
					fontSize: 16.0
			);
		}
	}

	void sendPassword(String username) async{

	}

	void login(String email, String password) async {
		SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

		Map data = {
			'password': password,
			'email': email,
		};

		var response = await http.post("https://rabbitcare.000webhostapp.com/api/login", body:
		data);

		print(response.body);

		if(response.statusCode == 200){
			MiddlewareToken middleware = MiddlewareToken.fromJson(json.decode(response.body));
			sharedPreferences.setString("token", middleware.success.token);

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

		var response = await http.post("https://rabbitcare.000webhostapp.com/api/details", headers: {
			'Authorization': 'Bearer ' + token,
		});

		if(response.statusCode == 200){
			User user = User.fromJson(json.decode(response.body)[0]);

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

				logout();
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
		sharedPreferences.remove("token");
	}

}
