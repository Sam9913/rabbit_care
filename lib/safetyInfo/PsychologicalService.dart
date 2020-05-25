import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

class PsychologicalService extends StatefulWidget {
  @override
  _PsychologicalServiceState createState() => _PsychologicalServiceState();
}

class _PsychologicalServiceState extends State<PsychologicalService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
			appBar: AppBar(
				title: Align(alignment: Alignment.centerRight, child: Text("Psychological services")),
				leading: GestureDetector(
						onTap: () => Navigator.pop(context), child: Icon(Icons.keyboard_arrow_left)),
			),
			body: SingleChildScrollView(
				child: Padding(
					padding: const EdgeInsets.all(8.0),
					child: Column(
						children: <Widget>[
							Bubble(
								color: Color.fromRGBO(135, 209, 214, 0.8),
								child: Text(
									"If you would like to obtain psychological services from clinical psychologists"
											" and counsellors, you may find their contact information from here.",
									textAlign: TextAlign.center,
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
											Expanded(
													flex: 9,
													child: Padding(
														padding: const EdgeInsets.all(8.0),
														child: Text("Type..."),
													)),
											Padding(
												padding: const EdgeInsets.all(8.0),
												child: Icon(Icons.search),
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
  }
}
