import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Add_TextField extends StatelessWidget {
  final TextEditingController callback;
  final String hint;
  final double width;
  final Function onChange;

  Add_TextField(
      {@override this.hint, this.callback, this.width, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      height: 35,
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.5)),
      child: TextField(
        onChanged: onChange,
        controller: callback,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
          ),
          contentPadding: EdgeInsets.fromLTRB(8, 4, 2, 2),
          border: OutlineInputBorder(),
          hintText: hint,
        ),
      ),
    );
  }
}
