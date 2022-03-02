import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Auth_TextField extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final String hint;

  Auth_TextField(
      {@required this.child, @required this.onTap, @override this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 75.0),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(30),
            right: Radius.circular(30),
          ),
          border: Border.all(color: Colors.blueAccent, width: 1),
        ),
        child: TextField(
          keyboardType: TextInputType.phone,
          onChanged: onTap,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 4, left: 15, top: 10),
            hintText: hint,
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
    );
  }
}

class Auth_Login_Btn extends StatelessWidget {
  final Function onTap;
  final String hint;
  Auth_Login_Btn({@required this.onTap, @override this.hint});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: onTap,
        height: 45,
        minWidth: 140,
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(75),
          side: BorderSide(
            color: Colors.white,
            width: 3,
          ),
        ),
        child: Text(
          hint,
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class Textheader extends StatelessWidget {
  final String string;
  final double six;
  final Color color;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  Textheader(
      {@override this.string,
      @override this.six,
      @override this.color,
      @override this.textAlign,
      @override this.fontWeight});
  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style:
          TextStyle(fontSize: six, color: color, fontWeight: FontWeight.w900),
    );
  }
}
