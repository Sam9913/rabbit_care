import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

class PsychologicalService extends StatefulWidget {
  @override
  _PsychologicalServiceState createState() => _PsychologicalServiceState();
}

class _PsychologicalServiceState extends State<PsychologicalService> {
  final personController = TextEditingController();
  bool changeOff = true;

  @override
  void dispose() {
    super.dispose();
    personController.dispose();
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
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
                      textAlign: TextAlign.center,style: TextStyle(fontSize: 16),
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
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0, right: 8.0),
                              child: TextField(
                                onEditingComplete: (){
                                  setState(() {
                                    changeOff = !changeOff;
                                  });
                                },
                                controller: personController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "Type...",
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: GestureDetector(
                                        onTap: (){},
                                        child: Icon(Icons.search)),
                                  ))),
                        ],
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, index){
                              return Offstage(
                                  offstage: changeOff,
                               child: Container(
                                   color: Colors.white,
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text("Show Here",),
                                   ))
                              );
                            }),
                    ],
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
