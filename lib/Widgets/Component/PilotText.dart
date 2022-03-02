import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pilottext extends StatelessWidget {
  String txt;

  Pilottext(this.txt);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.22,
        // decoration:
        // BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
        // height: 30,
        alignment: Alignment.centerLeft,
        child: Text(
          txt,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ));
  }
}

class PilotHeaderText extends StatelessWidget {
  String txt;
  PilotHeaderText(this.txt);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 3,
        // decoration:
        //     BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
        height: 35,
        alignment: Alignment.centerLeft,
        child: Text(
          txt,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ));
  }
}
