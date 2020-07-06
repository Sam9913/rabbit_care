import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AskRole extends StatefulWidget {
  @override
  _AskRoleState createState() => _AskRoleState();
}

class _AskRoleState extends State<AskRole> {
	List<String> role = ["Volunteer", "General User"];
	List<bool> isChecked = [false,false];
	String currentRole;

	@override
  void initState() {
    super.initState();
    getRole();
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
								Align(alignment: Alignment.centerRight, child: Text('Profile', style:
								TextStyle
									(color: Colors.grey[600]),))),
						Expanded(
							child: Padding(
									padding: EdgeInsets.only(left: 8), child: Icon(Icons.person, color: Colors
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
					Padding(
					  padding: const EdgeInsets.all(8.0),
					  child: Text("Hi there, welcome to RabbitCare! Are you a volunteer or a general user? "
								"", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
					),

					ListView.builder(
						shrinkWrap: true,
						itemCount: 2,
						itemBuilder: (context, index){
							return CheckboxListTile(
								title: Text(role[index]),
								value: isChecked[index],
								onChanged: (newValue) {
									setState(() {
										isChecked[index] = newValue;
										currentRole = role[index];
									});
								},
								controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
							);
						},
					),
				],
			),
		);
  }

  getRole() async{
		SharedPreferences prefs = await SharedPreferences.getInstance();
		currentRole = prefs.getString("chooseType") == "v" ? "Volunteer" : "General User";
		if(prefs.getString("chooseType") == "v")
			isChecked[0] = true;
		else
			isChecked[1] = false;
	}
}
