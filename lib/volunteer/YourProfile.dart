import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rabbitcare/model/User.dart';

class YourProfile extends StatefulWidget {
	final User user;

  const YourProfile({Key key, this.user}) : super(key: key);

  @override
  _YourProfileState createState() => _YourProfileState();
}

class _YourProfileState extends State<YourProfile> {
	final usernameController = TextEditingController();
	final emailController = TextEditingController();
	final contactController = TextEditingController();
	final organizationController = TextEditingController();
	final oldpassController = TextEditingController();
	final newpassController = TextEditingController();
	final conpassController = TextEditingController();

	@override
  void initState() {
    super.initState();
    setState(() {
			usernameController.text = widget.user.username;
			emailController.text = widget.user.email;
			contactController.text = widget.user.phone_number;
			organizationController.text = widget.user.ngo_name;
    });
  }

	@override
  void dispose() {
    super.dispose();
		usernameController.dispose();
		emailController.dispose();
		contactController.dispose();
		organizationController.dispose();
		oldpassController.dispose();
		newpassController.dispose();
		conpassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
  	return Scaffold(
			appBar: AppBar(
				actions: <Widget>[],
				title: Text(
					'Your Profile',
					style: TextStyle(color: Colors.grey[600]),
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
						child: Icon(Icons.keyboard_arrow_left, color: Colors.black)),
			),
			body: SingleChildScrollView(
			  child: Padding(
			    padding: const EdgeInsets.all(8.0),
			    child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
			    	children: <Widget>[
			    		Center(
			    		  child: CircleAvatar(
			    		  	backgroundImage: NetworkImage(
			    		  			"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQOKJ-JG-9p3KgnMl24G0B9g73t19_Iv3cye7pGUndT0dKobKt-&usqp=CAU"),
			    		  	radius: 50,
			    		  ),
			    		),

			    		Text("Username"),

			    		Padding(
			    		  padding: const EdgeInsets.only(bottom: 8.0),
			    		  child: TextField(
			    		  	controller: usernameController,
			    		  ),
			    		),

			    		Text("Email"),

			    		Padding(
			    		  padding: const EdgeInsets.only(bottom: 8.0),
			    		  child: TextField(
			    		  	controller: emailController,
			    		  ),
			    		),

			    		Text("Contact number"),

			    		Padding(
			    		  padding: const EdgeInsets.only(bottom: 8.0),
			    		  child: TextField(
			    		  	controller: contactController,
			    		  ),
			    		),

			    		Text("Organization"),

			    		Padding(
			    		  padding: const EdgeInsets.only(bottom: 8.0),
			    		  child: TextField(
			    		  	controller: organizationController,
			    		  ),
			    		),

			    		Padding(
			    		  padding: const EdgeInsets.only(top: 16.0),
			    		  child: Text("Change password", style: TextStyle(fontWeight: FontWeight.bold, color:
										Colors.teal.withOpacity(0.7), fontSize: 16),),
			    		),

			    		Text("Original password"),

			    		Padding(
			    		  padding: const EdgeInsets.only(bottom: 8.0),
			    		  child: TextField(
			    		  	controller: oldpassController,
			    		  ),
			    		),

			    		Text("New password"),

			    		Padding(
			    		  padding: const EdgeInsets.only(bottom: 8.0),
			    		  child: TextField(
			    		  	controller: newpassController,
			    		  ),
			    		),

			    		Text("Confirm new password"),

			    		Padding(
			    		  padding: const EdgeInsets.only(bottom: 8.0),
			    		  child: TextField(
			    		  	controller: conpassController,
			    		  ),
			    		),

							Center(
							  child: Container(
									width: size.width,
							  	decoration: BoxDecoration(
							  		borderRadius: BorderRadius.circular(10.0),
							  		gradient: LinearGradient(
							  			colors: [Color.fromRGBO(135, 209, 214, 0.8), Colors.white],
							  			begin: Alignment.topLeft,
							  			end: Alignment.bottomLeft,
							  		),
							  	),
							  	child: FlatButton(child: Text("Save", style: TextStyle(color: Colors.black),),
							  		onPressed: (){},
							  	),
							  ),
							),
			    	],
			    ),
			  ),
			),
		);
  }
}
