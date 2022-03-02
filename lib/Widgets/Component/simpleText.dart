import 'package:flutter/material.dart';

class SimpleText extends StatelessWidget {
  String text;

  SimpleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class TransientText extends StatelessWidget {
  String text;

  TransientText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class AircraftText extends StatelessWidget {
  String text2;
  AircraftText(this.text2);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
          decoration: BoxDecoration(
              // border: Border.all(color: Colors.grey.shade400),
              ),
          child: Text(
            text2,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          )),
    );
  }
}

class UserSetText extends StatelessWidget {
  String text3;
  UserSetText(this.text3);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 33,
      // width: MediaQuery.of(context).size.width * 0.16,
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.grey.shade400),
      // ),
      child: Text(
        text3,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class UserProfileText extends StatelessWidget {
  String text3;
  UserProfileText(this.text3);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 30,
      alignment: Alignment.centerLeft,
      // width: 66,
      decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey.shade400),
          ),
      child: Text(
        text3,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  String text3;
  UserProfile(this.text3);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33,
      // width: MediaQuery.of(context).size.width * 0.16,
      decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey.shade400),
          ),
      child: Center(
        child: Text(
          text3,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

class ViewAircrafts extends StatelessWidget {
  String text3;
  ViewAircrafts(this.text3);
  @override
  Widget build(BuildContext context) {
    return Container(
        // width: double.infinity,
        // height: 30.5,
        decoration: BoxDecoration(
            // border: Border.all(color: Colors.grey.shade400),
            ),
        child: Text(
          text3,
          // textAlign: TextAlign.end,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ));
  }
}
