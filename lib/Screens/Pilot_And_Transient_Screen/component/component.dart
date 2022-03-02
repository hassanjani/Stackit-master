import 'package:flutter/material.dart';

class tableHeader extends StatelessWidget {
  String text;

  tableHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      color: Colors.grey.shade400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text,
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
