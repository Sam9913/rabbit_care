import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:rabbitcare/model/ServiceCenter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class PsychologicalService extends StatefulWidget {
  @override
  _PsychologicalServiceState createState() => _PsychologicalServiceState();
}

class _PsychologicalServiceState extends State<PsychologicalService> {
  String message = " ";
  final areaController = TextEditingController();
  bool changeOff = true;
  bool isClick = true;
  List<ServiceCenter> serviceCenterList = List<ServiceCenter>();
  int checkLength = 0;
  Future<void> _launched;
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
    areaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Psychological Services",
              style: TextStyle(color: Colors.black),
            )),
        flexibleSpace: Container(
          child: Image(
            image: AssetImage("images/psychoSlides.png"),
            fit: BoxFit.cover,
          ),
        ),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.keyboard_arrow_left, color: Colors.black)),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isClick = !isClick;
                });
              },
              icon: Icon(
                Icons.info,
                color: Colors.black87,
              )),
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
                        "If you would like to obtain psychological services from clinical psychologists"
                        " and counsellors, you may find their contact information from here.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
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
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: SizedBox(
                              height: 50,
                              child: TypeAheadField(
                                hideSuggestionsOnKeyboardHide: true,
                                textFieldConfiguration: TextFieldConfiguration(
                                    controller: areaController,
                                    style: TextStyle(fontSize: 14),
                                    decoration: InputDecoration(border: OutlineInputBorder())),
                                suggestionsCallback: (pattern) async {
                                  return FilteredServiceCenter.getSuggestions(pattern);
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
                                      areaController.text = suggestion;
                                      serviceCenterList.removeRange(0, serviceCenterList.length);
                                    });
                                    getAll();
                                  }
                                  else if(area.indexWhere((element) => element ==
                                      areaController.text) >= 0){
                                    setState(() {
                                      areaController.text = suggestion;
                                      serviceCenterList.removeRange(0, serviceCenterList.length);
                                    });
                                    getSpecificArea(suggestion);
                                  }
                                  else{
                                    setState(() {
                                      serviceCenterList.removeRange(0, serviceCenterList.length);
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
                              onTap: () => areaController.clear(),
                              child: Icon(Icons.clear),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () {
                                  if (areaController.text != null) {
                                    if(areaController.text == "All Centers"){
                                      setState(() {
                                        serviceCenterList.removeRange(0, serviceCenterList.length);
                                      });
                                      getAll();
                                    }
                                    else if(area.indexWhere((element) => element ==
                                        areaController.text) >= 0){
                                      setState(() {
                                        serviceCenterList.removeRange(0, serviceCenterList.length);
                                      });
                                      getSpecificArea(areaController.text);
                                    }
                                    else{
                                      setState(() {
                                        serviceCenterList.removeRange(0, serviceCenterList.length);
                                      });
                                      getSpecificName(areaController.text);
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
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Offstage(
                                offstage: changeOff,
                                child: Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Show Here",
                                      ),
                                    )));
                          }),
                    ],
                  ),
                ),
              ),
              checkLength == 0
                  ? Center(
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
                          itemCount: serviceCenterList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(173, 216, 230, 0.25),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (index+1).toString() + ". ",
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            Flexible(
                                                child: Text(
                                              serviceCenterList[index].name,
                                              maxLines: 2,
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                            )),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Icon(Icons.phone_android),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _launched = _makePhoneCall(
                                                        'tel:${serviceCenterList[index].contactNumber}');
                                                  });
                                                },
                                                child: Text(serviceCenterList[index].contactNumber,
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        decoration: TextDecoration.underline,
                                                        fontWeight: FontWeight.bold))),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Icon(Icons.location_on),
                                            ),
                                            Flexible(
                                                child: Text(
                                              serviceCenterList[index].address,
                                              maxLines: 3,
                                            )),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Icon(Icons.language, color: Color.fromRGBO(95, 158, 160, 1.0),),
                                            ),
                                            Flexible(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _launchInBrowser(serviceCenterList[index].link);
                                                  });
                                                },
                                                child: Text(
                                                  serviceCenterList[index].link,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      decoration: TextDecoration.underline,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
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
    var response = await http.get("https://rabbitcare.000webhostapp.com/api/service_centers");

    if (response.statusCode == 200) {
      var responseList = json.decode(response.body);

      for (int i = 0; i < responseList.length; i++) {
        ServiceCenter serviceCenter = ServiceCenter.fromJson(responseList[i]);

        if(FilteredServiceCenter.condition.indexWhere((element) => element == serviceCenter.name) == -1)
          FilteredServiceCenter.condition.add(serviceCenter.name);

        setState(() {
          serviceCenterList.add(serviceCenter);
        });
      }

      setState(() {
        checkLength = serviceCenterList.isEmpty? -1 : serviceCenterList.length;
      });
    }
  }

  void getSpecificArea(String area) async {
    var response = await http.get("https://rabbitcare.000webhostapp"
        ".com/api/service_centers/state=" +
        area);

    if (response.statusCode == 200) {
      var responseList = json.decode(response.body);

      for (int i = 0; i < responseList.length; i++) {
        ServiceCenter serviceCenter = ServiceCenter.fromJson(responseList[i]);
        setState(() {
          serviceCenterList.add(serviceCenter);
        });
      }

      setState(() {
        if(serviceCenterList.isEmpty){
          message = "Sorry, current area didn't contain any psychological services center";
          checkLength = -1;
        }
        else{
          checkLength = serviceCenterList.length;
        }
      });
    }
  }

  void getSpecificName(String name) async {
    var response = await http.get("https://rabbitcare.000webhostapp"
        ".com/api/service_centers/name=" +
        name);

    if (response.statusCode == 200) {
      var responseList = json.decode(response.body);

      for (int i = 0; i < responseList.length; i++) {
        ServiceCenter serviceCenter = ServiceCenter.fromJson(responseList[i]);
        setState(() {
          serviceCenterList.add(serviceCenter);
        });
      }

      setState(() {
        if(serviceCenterList.isEmpty){
          message = "Sorry, currently didn't contain any psychological service center with "
              "that name";
          checkLength = -1;
        }
        else{
          checkLength = serviceCenterList.length;
        }
      });
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
