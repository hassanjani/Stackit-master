import 'package:flutter/material.dart';

class TextFeild extends StatelessWidget {
  String lableTxt, txtName, MobileNo;

  TextFeild(this.lableTxt, this.txtName);
  String phone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(txtName, style: TextStyle(fontSize: 14)),
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(30),
              right: Radius.circular(30),
            ),
            border: Border.all(
              color: Colors.blueAccent,
            ),
          ),
          child: SizedBox(
            height: 40,
            child: Center(
              child: TextFormField(
                onChanged: (val) {
                  phone = val;
                },
                decoration: InputDecoration(
                  hintText: lableTxt,
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
