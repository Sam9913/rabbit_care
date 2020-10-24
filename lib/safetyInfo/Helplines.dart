import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rabbitcare/model/NgoCenter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Helplines extends StatefulWidget {
  @override
  _HelplinesState createState() => _HelplinesState();
}

class _HelplinesState extends State<Helplines> {
	Future<void> _launched;
	final centerController = TextEditingController();
	bool isClick = true;
	List<NgoCenter> ngoCenterList = List<NgoCenter>();
	int checkLength = 0;
	String message = " ";
	List<String> area = ['Johor', 'Kedah', 'Kelantan', 'Kuala Lumpur', 'Labuan', 'Malacca',
		'Negeri Sembilan', 'Pahang', 'Putrajaya', 'Penang', 'Perak',
		'Perlis', 'Sarawak', 'Sabah', 'Selangor', 'Terengganu'];

	@override
  void initState() {
    super.initState();
    getAll();
  }

	@override
  void dispose() {
    super.dispose();
    centerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			appBar: AppBar(
				title: Align(alignment: Alignment.centerRight,
						child: Text("Helplines", style: TextStyle(color: Colors.black),)),
				flexibleSpace: Container(
					child: Image(
						image: AssetImage("images/helplinesSlide.png"),
						fit: BoxFit.cover,
					),
				),
				leading:  GestureDetector(
						onTap: () => Navigator.pop(context), child: Icon(Icons.keyboard_arrow_left,
						color: Colors.black)),
				actions: [
					IconButton(onPressed: (){
						setState(() {
							isClick = !isClick;
						});
					},icon: Icon(Icons.info, color: Colors.black87,)),
				],
			),
			body: SingleChildScrollView(
				child: Padding(
					padding: const EdgeInsets.all(8.0),
					child: Column(
						children: <Widget>[
							Offstage(
								offstage: isClick,
								child: Container(
									decoration: BoxDecoration(
										borderRadius: BorderRadius.circular(10.0),
										color: Color.fromRGBO(135, 200, 200, 1.0),
									),
									child: Padding(
										padding: const EdgeInsets.all(8.0),
										child: Center(
											child: Text(
												"Want to contact specific helplines? \nHere are all the contact information of "
														"the available helplines in Malaysia",
												textAlign: TextAlign.center, style: TextStyle(fontSize: 16),
											),
										),
									),
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
											Flexible(
												child: SizedBox(
													height: 50,
													child: TypeAheadField(
														hideSuggestionsOnKeyboardHide: true,
														textFieldConfiguration: TextFieldConfiguration(
																controller: centerController,
																style: TextStyle(fontSize: 14),
																decoration: InputDecoration(border: OutlineInputBorder())),
														suggestionsCallback: (pattern) async {
															return FilteredNgoCenter.getSuggestions(pattern);
														},
														itemBuilder: (context, suggestion) {
															return ListTile(
																leading: Icon(Icons.location_on),
																title: Text(suggestion),
															);
														},
														onSuggestionSelected: (suggestion) {
															if(suggestion == "All Centers"){
																setState(() {
																	centerController.text = suggestion;
																	ngoCenterList.removeRange(0, ngoCenterList.length);
																});
																getAll();
															}
															else if(area.indexWhere((element) => element ==
																	centerController.text) >= 0){
																setState(() {
																	centerController.text = suggestion;
																	ngoCenterList.removeRange(0, ngoCenterList.length);
																});
																getSpecificArea(suggestion);
															}
															else{
																setState(() {
																	ngoCenterList.removeRange(0, ngoCenterList.length);
																});
																getSpecificName(suggestion);
															}
														},
													),
												),
											),
											Padding(
												padding: const EdgeInsets.all(8.0),
												child: GestureDetector(
													onTap: () => centerController.clear(),
													child: Icon(Icons.clear),
												),
											),
											Padding(
											  padding: const EdgeInsets.all(8.0),
											  child: GestureDetector(
											  			onTap: (){
											  				if (centerController.text != null) {
											  					if(centerController.text == "All Centers"){
											  						setState(() {
											  							ngoCenterList.removeRange(0, ngoCenterList.length);
											  						});
											  						getAll();
											  					}
											  					else if(area.indexWhere((element) => element ==
																			centerController.text) >= 0){
																		setState(() {
																			ngoCenterList.removeRange(0, ngoCenterList.length);
																		});
																		getSpecificArea(centerController.text);
																	}
											  					else{
											  						setState(() {
											  							ngoCenterList.removeRange(0, ngoCenterList.length);
											  						});
											  						getSpecificName(centerController.text);
											  					}
											  				} else {
											  					Fluttertoast.showToast(
											  						msg: "No location typed",
											  						toastLength: Toast.LENGTH_SHORT,
											  						gravity: ToastGravity.BOTTOM,
											  						timeInSecForIosWeb: 1,
											  						backgroundColor: Colors.black,
											  						textColor: Colors.white,
											  					);
											  				}
											  			},
											  			child: Icon(Icons.search)),
											),
							  	  ],
							  	),
							  ),
							),
							checkLength == 0 ? Center(
								child: CircularProgressIndicator(
									valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
								),
							)
									: checkLength == -1
									? Padding(
								padding: const EdgeInsets.all(8.0),
								child: Center(
										child: Text(message)),
							)
									: ListView.builder(
								physics: NeverScrollableScrollPhysics(),
								shrinkWrap: true,
								itemCount: ngoCenterList.length,
								itemBuilder: (context, index){
									return Padding(
										padding: const EdgeInsets.all(8.0),
										child: Container(
											decoration:BoxDecoration(
												color: Color.fromRGBO(173, 216, 230, 0.25),
												borderRadius: BorderRadius.circular(10.0),
											),
											child: Padding(
											  padding: const EdgeInsets.all(8.0),
											  child: Column(
											  	mainAxisAlignment: MainAxisAlignment.start,
											  	crossAxisAlignment: CrossAxisAlignment.start,
											  	children: <Widget>[
											  		Text((index + 1).toString() + ". " + ngoCenterList[index].name, style:
											  		TextStyle
											  			(fontWeight:
											  		FontWeight.bold),),
											  		Padding(
											  		  padding: ngoCenterList[index].address == "NA" ?
															const EdgeInsets.only(top:8.0, bottom: 8.0) :
															const EdgeInsets.only(top:8.0),
											  		  child: Row(
											  		  	crossAxisAlignment: CrossAxisAlignment.start,
											  		  	children: <Widget>[
											  		  		Padding(
											  		  		  padding: const EdgeInsets.only(right: 8.0),
											  		  		  child: Icon(Icons.language, color: Color.fromRGBO(95, 158, 160, 1.0),),
											  		  		),
											  		  		Flexible(
											  		  		  child: InkWell(
											  		  		  	onTap: () => setState(() {
											  		  		  		_launched = _launchInWebViewWithJavaScript
											  		  		  			(ngoCenterList[index].link);
											  		  		  	}),
											  		  		  	child: Text(ngoCenterList[index].link, maxLines: 2, style:
											  		  		  	TextStyle
											  		  		  		(color: Color.fromRGBO(95, 158, 160, 1.0)),),
											  		  		  ),
											  		  		),
											  		  	],
											  		  ),
											  		),
											  		Offstage(
															offstage: ngoCenterList[index].address == "NA",
											  		  child: Padding(
											  		    padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
											  		    child: Row(
											  		    	children: <Widget>[
											  		    		Padding(
											  		    		  padding: const EdgeInsets.only(right: 8.0),
											  		    		  child: Icon(Icons.location_on),
											  		    		),
											  		    		Flexible(
											  		    			child: Text(ngoCenterList[index].address),
											  		    		),
											  		    	],
											  		    ),
											  		  ),
											  		),
											  	],
											  ),
											),
										),
									);
								},
							),

						],
					),
				),
			),
		);
  }

	void getAll() async {
		var response = await http.get("https://rabbitcare.000webhostapp.com/api/ngo_centers");

		if (response.statusCode == 200) {
			var responseList = json.decode(response.body);

			for (int i = 0; i < responseList.length; i++) {
				NgoCenter ngoCenter = NgoCenter.fromJson(responseList[i]);

				if(FilteredNgoCenter.condition.indexWhere((element) => element == ngoCenter.name) == -1)
					FilteredNgoCenter.condition.add(ngoCenter.name);

				setState(() {
					ngoCenterList.add(ngoCenter);
				});
			}

			setState(() {
				checkLength = ngoCenterList.isEmpty ? -1 : ngoCenterList.length;
			});
		}
	}

	void getSpecificArea(String area) async {
		var response = await http.get("https://rabbitcare.000webhostapp.com/api/ngo_centers/state=" +
				area);

		print(response.body);
		if (response.statusCode == 200) {

			var responseList = json.decode(response.body);

			for (int i = 0; i < responseList.length; i++) {
				NgoCenter ngoCenter = NgoCenter.fromJson(responseList[i]);
				setState(() {
					ngoCenterList.add(ngoCenter);
				});
			}

			setState(() {
				if(ngoCenterList.isEmpty){
					message = "Sorry, current area didn't contain any NGO organization center";
					checkLength = -1;
				}
				else{
					checkLength = ngoCenterList.length;
				}
			});
		}
	}

	void getSpecificName(String name) async {
		var response = await http.get("https://rabbitcare.000webhostapp.com/api/ngo_centers/name=" +
				name);

		print(response.body);
		if (response.statusCode == 200) {

			var responseList = json.decode(response.body);

			for (int i = 0; i < responseList.length; i++) {
				NgoCenter ngoCenter = NgoCenter.fromJson(responseList[i]);
				setState(() {
					ngoCenterList.add(ngoCenter);
				});
			}

			setState(() {
				if(ngoCenterList.isEmpty){
					message = "Sorry, currently didn't contain any NGO organization center with "
							"that name";
					checkLength = -1;
				}
				else{
					checkLength = ngoCenterList.length;
				}
			});
		}
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
