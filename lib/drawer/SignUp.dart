import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'VolunteerProfile.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
	final usernameController = TextEditingController();
  final conPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final ngoEmailController = TextEditingController();
  final ngoNameController = TextEditingController();
  Map<String, bool> language = {"English": false, "Bahasa Malaysia": false, "华文": false};
  List<Color> weekColor = [Colors.grey,Colors.grey,Colors.grey,Colors.grey,Colors.grey,Colors
			.grey,Colors.grey];
  List<bool> weekChosen = [false,false,false,false,false,false,false];
  List<String> week = List<String>();
	String _date = "Not set";
	String _time = "Not set";
  bool setTime = false;

  @override
  void dispose() {
    super.dispose();
		ngoEmailController.dispose();
		ngoNameController.dispose();
		usernameController.dispose();
		conPasswordController.dispose();
		passwordController.dispose();
		phoneController.dispose();
		fullNameController.dispose();
		emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
                flex: 8,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.grey[600]),
                    ))),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.supervisor_account,
                    color: Colors.grey[600],
                  )),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: <Color>[
            Color.fromRGBO(172, 229, 215, 1.0),
            Color.fromRGBO(207, 235, 225, 1.0),
          ])),
        ),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.keyboard_arrow_left, color: Colors.grey[600])),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Thank you for your interest in signing up as a volunteer! We are looking"
                  " for individuals who are currently volunteering in NGOS and also certified "
                  "counsellors & psychologists, if you fulfill the requirements, please submit your"
                  " individual details and we will get back to you through email/phone.",
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                child: TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    border: new UnderlineInputBorder(
														borderSide: new BorderSide(
																color: Colors.black
														)
												),
                    labelText: "Full Name",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: new UnderlineInputBorder(
														borderSide: new BorderSide(
																color: Colors.black
														)
												),
                    labelText: "E-mail",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: new UnderlineInputBorder(
														borderSide: new BorderSide(
																color: Colors.black
														)
												),
                    labelText: "Phone Number",
                  ),
                ),
              ),
							Padding(
								padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
								child: TextField(
									controller: usernameController,
									decoration: InputDecoration(
										border: new UnderlineInputBorder(
												borderSide: new BorderSide(
														color: Colors.black
												)
										),
										labelText: "Username (for anonymous purpose)",
									),
								),
							),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: new UnderlineInputBorder(
														borderSide: new BorderSide(
																color: Colors.black
														)
												),
                    labelText: "Password",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                child: TextField(
                  controller: conPasswordController,
                  decoration: InputDecoration(
												border: new UnderlineInputBorder(
														borderSide: new BorderSide(
																color: Colors.black
														)
												),
                    labelText: "Confirm Password",
                  ),
                ),
              ),
							Padding(
								padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
								child: TextField(
									controller: ngoNameController,
									decoration: InputDecoration(
										border: new UnderlineInputBorder(
												borderSide: new BorderSide(
														color: Colors.black
												)
										),
										labelText: "NGO organization name",
									),
								),
							),
							Padding(
								padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
								child: TextField(
									controller: ngoEmailController,
									decoration: InputDecoration(
										border: new UnderlineInputBorder(
												borderSide: new BorderSide(
														color: Colors.black
												)
										),
										labelText: "NGO organization email",
									),
								),
							),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Time which you are available to volunteer",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Century Gothic',
                      )),
                ),
              ),

							Offstage(
								offstage: setTime,
							  child: Row(
									mainAxisAlignment: MainAxisAlignment.spaceEvenly,
							  	children: <Widget>[
							  		Column(
							  			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
							  			children: [
							  				Padding(
							  				  padding: const EdgeInsets.all(8.0),
							  				  child: ClipRRect(
							  				  	borderRadius: BorderRadius.circular(5.0),
							  				  	child: Material(
							  				  		color: weekColor[0], // button color
							  				  		child: InkWell(
							  				  			splashColor: Color.fromRGBO(172, 229, 215, 1.0), // inkwell color
							  				  			child: SizedBox(width: 100, height: 50, child: Center(
							  				  				child: Text("Monday",style: TextStyle(
							  				  					fontSize: 14,
							  				  					fontFamily: 'Century Gothic',
							  				  				)),
							  				  			)),
							  				  			onTap: () {
							  				  				setState(() {
							  				  					weekChosen[0] = !weekChosen[0];
							  				  					weekColor[0] = weekChosen[0] ? Color.fromRGBO(172, 229, 215, 1.0) : Colors.grey;
							  				  				});
							  				  			},
							  				  		),
							  				  	),
							  				  ),
							  				),

							  				Padding(
							  				  padding: const EdgeInsets.all(8.0),
							  				  child: ClipRRect(
							  				  	borderRadius: BorderRadius.circular(5.0),
							  				  	child: Material(
							  				  		color: weekColor[1], // button color
							  				  		child: InkWell(
							  				  			splashColor: Color.fromRGBO(172, 229, 215, 1.0), // inkwell color
							  				  			child: SizedBox(width: 100, height: 50, child: Center(
							  				  				child: Text("Tuesday",style: TextStyle(
							  				  					fontSize: 14,
							  				  					fontFamily: 'Century Gothic',
							  				  				)),
							  				  			)),
							  				  			onTap: () {
							  				  				setState(() {
							  				  					weekChosen[1] = !weekChosen[1];
							  				  					weekColor[1] = weekChosen[1] ? Color.fromRGBO(172, 229, 215, 1.0) : Colors.grey;
							  				  				});
							  				  			},
							  				  		),
							  				  	),
							  				  ),
							  				),

							  				Padding(
							  				  padding: const EdgeInsets.all(8.0),
							  				  child: ClipRRect(
							  				  	borderRadius: BorderRadius.circular(5.0),
							  				  	child: Material(
							  				  		color: weekColor[2], // button color
							  				  		child: InkWell(
							  				  			splashColor: Color.fromRGBO(172, 229, 215, 1.0), // inkwell color
							  				  			child: SizedBox(width: 100, height: 50, child: Center(
							  				  				child: Text("Wednesday",style: TextStyle(
							  				  					fontSize: 14,
							  				  					fontFamily: 'Century Gothic',
							  				  				)),
							  				  			)),
							  				  			onTap: () {
							  				  				setState(() {
							  				  					weekChosen[2] = !weekChosen[2];
							  				  					weekColor[2] = weekChosen[2] ? Color.fromRGBO(172, 229, 215, 1.0) : Colors.grey;
							  				  				});
							  				  			},
							  				  		),
							  				  	),
							  				  ),
							  				),

							  			],
							  		),

							  		Column(
							  			children: [
												Padding(
													padding: const EdgeInsets.all(8.0),
													child: ClipRRect(
														borderRadius: BorderRadius.circular(5.0),
														child: Material(
															color: weekColor[3], // button color
															child: InkWell(
																splashColor: Color.fromRGBO(172, 229, 215, 1.0), // inkwell color
																child: SizedBox(width: 100, height: 50, child: Center(
																	child: Text("Thursday",style: TextStyle(
																		fontSize: 14,
																		fontFamily: 'Century Gothic',
																	)),
																)),
																onTap: () {
																	setState(() {
																		weekChosen[3] = !weekChosen[3];
																		weekColor[3] = weekChosen[3] ? Color.fromRGBO(172, 229, 215, 1.0) : Colors.grey;
																	});
																},
															),
														),
													),
												),

							  				Padding(
							  				  padding: const EdgeInsets.all(8.0),
							  				  child: ClipRRect(
							  				  	borderRadius: BorderRadius.circular(5.0),
							  				  	child: Material(
							  				  		color: weekColor[4], // button color
							  				  		child: InkWell(
							  				  			splashColor: Color.fromRGBO(172, 229, 215, 1.0), // inkwell color
							  				  			child: SizedBox(width: 100, height: 50, child: Center(
							  				  				child: Text("Friday",style: TextStyle(
							  				  					fontSize: 14,
							  				  					fontFamily: 'Century Gothic',
							  				  				)),
							  				  			)),
							  				  			onTap: () {
							  				  				setState(() {
							  				  					weekChosen[4] = !weekChosen[4];
							  				  					weekColor[4] = weekChosen[4] ? Color.fromRGBO(172, 229, 215, 1.0) : Colors.grey;
							  				  				});
							  				  			},
							  				  		),
							  				  	),
							  				  ),
							  				),

							  				Padding(
							  				  padding: const EdgeInsets.all(8.0),
							  				  child: ClipRRect(
							  				  	borderRadius: BorderRadius.circular(5.0),
							  				  	child: Material(
							  				  		color: weekColor[5], // button color
							  				  		child: InkWell(
							  				  			splashColor: Color.fromRGBO(172, 229, 215, 1.0), // inkwell color
							  				  			child: SizedBox(width: 100, height: 50, child: Center(
							  				  				child: Text("Saturday",style: TextStyle(
							  				  					fontSize: 14,
							  				  					fontFamily: 'Century Gothic',
							  				  				)),
							  				  			)),
							  				  			onTap: () {
							  				  				setState(() {
							  				  					weekChosen[5] = !weekChosen[5];
							  				  					weekColor[5] = weekChosen[5] ? Color.fromRGBO(172, 229, 215, 1.0) : Colors.grey;
							  				  				});
							  				  			},
							  				  		),
							  				  	),
							  				  ),
							  				),
							  			],
							  		),

										Padding(
											padding: const EdgeInsets.all(8.0),
											child: ClipRRect(
												borderRadius: BorderRadius.circular(5.0),
												child: Material(
													color: weekColor[6], // button color
													child: InkWell(
														splashColor: Color.fromRGBO(172, 229, 215, 1.0), // inkwell color
														child: SizedBox(width: 100, height: 50, child: Center(
															child: Text("Sunday",style: TextStyle(
																fontSize: 14,
																fontFamily: 'Century Gothic',
															)),
														)),
														onTap: () {
															setState(() {
																weekChosen[6] = !weekChosen[6];
																weekColor[6] = weekChosen[6] ? Color.fromRGBO(172, 229, 215, 1.0) : Colors.grey;
															});
														},
													),
												),
											),
										),
							  	],
							  ),
							),

              Offstage(
								offstage: setTime,
								child: Padding(
									padding: const EdgeInsets.all(8.0),
									child: Container(
										decoration: BoxDecoration(
												borderRadius: BorderRadius.circular(10.0),
												gradient: weekChosen.contains(true) ?LinearGradient(
														begin: Alignment.topLeft,
														end: Alignment.topRight,
														colors: <Color>[
															Color.fromRGBO(172, 229, 215, 1.0),
															Color.fromRGBO(207, 235, 225, 1.0),
														]) :  LinearGradient(
														begin: Alignment.topLeft,
														end: Alignment.topRight,
														colors: <Color>[
															Colors.grey,
															Colors.grey,
														])
										),
										child: RawMaterialButton(
											onPressed: () {
												setState(() {
													List<String> weekName = ["Monday","Tuesday","Wednesday","Thursday","Fri"
															"day","Saturday","Sunday"];

													for(int index = 0 ; index < weekChosen.length ; index++){
														if(weekChosen[index] && !week.contains(weekName[index])){
															week.add(weekName[index]);
														}
													}

													setTime = true;
												});
											},
											child: Text("Done",style: TextStyle(
												fontSize: 14,
												fontFamily: 'Century Gothic',
											)),
										),
									),
								),
							),

              Offstage(
								offstage: !setTime,
								child: Column(
								  children: [
								  	Padding(
								  	  padding: const EdgeInsets.all(8.0),
								  	  child: InkWell(
												onTap: (){
													setState(() {
													  setTime = false;
													});
												},
								  	    child: Row(
								  	      children: [
								  	  			Icon(Icons.arrow_back_ios),
								  	  			Text("Back to choose day"),
								  	      ],
								  	    ),
								  	  ),
								  	),
								    ListView.builder(
								    	shrinkWrap: true,
								    	physics: NeverScrollableScrollPhysics(),
								    	itemCount: week.length,
								    	itemBuilder: (context,index){
								    			return Padding(
								    				padding: const EdgeInsets.all(8.0),
								    				child: Row(
								    					children: [
								    						Text(week[index] + " : ", style: TextStyle(
								    							fontSize: 14,
								    							fontFamily: 'Century Gothic',
								    						)),
														RaisedButton(
															shape: RoundedRectangleBorder(
																	borderRadius: BorderRadius.circular(5.0)),
															elevation: 4.0,
															onPressed: () {
																DatePicker.showTimePicker(context,
																		theme: DatePickerTheme(
																			containerHeight: 210.0,
																		),
																		showTitleActions: true, onConfirm: (time) {
																			print('confirm $time');
																			_time = '${time.hour} : ${time.minute}';
																			setState(() {});
																		}, currentTime: DateTime.now(), locale: LocaleType.en);
																setState(() {});
															},
															child: Row(
																children: <Widget>[
																	Icon(
																		Icons.access_time,
																		size: 18.0,
																		color: Colors.teal,
																	),
																	Text(
																		" $_time",
																		style: TextStyle(
																				color: Colors.teal,
																				fontWeight: FontWeight.bold,
																				fontSize: 18.0),
																	),
																],
															),),
																Text(" - "),
																RaisedButton(
																	shape: RoundedRectangleBorder(
																			borderRadius: BorderRadius.circular(5.0)),
																	elevation: 4.0,
																	onPressed: () {
																		DatePicker.showTimePicker(context,
																				theme: DatePickerTheme(
																					containerHeight: 210.0,
																				),
																				showTitleActions: true, onConfirm: (time) {
																					print('confirm $time');
																					_time = '${time.hour} : ${time.minute}';
																					setState(() {});
																				}, currentTime: DateTime.now(), locale: LocaleType.en);
																		setState(() {});
																	},
																	child: Row(
																		children: <Widget>[
																			Icon(
																				Icons.access_time,
																				size: 18.0,
																				color: Colors.teal,
																			),
																			Text(
																				" $_time",
																				style: TextStyle(
																						color: Colors.teal,
																						fontWeight: FontWeight.bold,
																						fontSize: 18.0),
																			),
																		],
																	),),
								    					],
								    				),
								    			);
								    	},
								    ),
								  ],
								),
							),

              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Languages that you can speak fluently",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Century Gothic',
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: language.keys.map((String key) {
                    return new CheckboxListTile(
                      title: new Text(key,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Century Gothic',
                          )),
                      value: language[key],
                      activeColor: Color.fromRGBO(0, 142, 142, 1.0),
                      onChanged: (bool value) async {},
                    );
                  }).toList(),
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
                  child: FlatButton(
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
											/*signUp(fullNameController.text, usernameController.text,passwordController
													.text, conPasswordController.text, );*/
                      /*Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => VolunteerProfile()));*/
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

	void signUp(String name, String username, String remarks, String password, String confirmPass,
			String time_available, String language, String email, String ngo_email, String ngo_name,
			String phoneNo) async {

		Map data = {
			'full_name': name,
			'password': password,
			'password_confirmation': confirmPass,
			'remarks': remarks,
			'time_available': time_available,
			'language': language,
			'ngo_email': ngo_email,
			'ngo_name': ngo_name,
			'phone_number': phoneNo,
			'username': username,
			'email': email,
		};

		var response = await http.post("https://rabbitcare.000webhostapp.com/api/auth/signup",
				headers: {
			'Content-Type': 'application/json',
			'X-Requested-With': 'XMLHttpRequest'
		}, body: data);

		if(response.statusCode == 200){
			Fluttertoast.showToast(
					msg: "Please wait 2 - 3 days for verification",
					toastLength: Toast.LENGTH_SHORT,
					gravity: ToastGravity.BOTTOM,
					timeInSecForIosWeb: 1,
					backgroundColor: Colors.black,
					textColor: Colors.white,
					fontSize: 16.0
			);
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
}
