import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/FBOScreen/FBO_BottomBar.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/Pilot_And_Transient_Screen/BottombarPilot&Transient.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/Tenant_Bottombar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AuthScreen/LoginScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SafeArea(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 60),
                      Container(
                        width: 290,
                        height: 120,
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 5.0),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Text(
                          "Welcome to Stackit",
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      if (prefs.getInt('selectedTypeUid') == null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      } else if (prefs.getInt('selectedTypeUid') == 1) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Teanant_Bottombar(
                                      selectedTypeId:
                                          prefs.getInt('selectedTypeUid'),
                                    )));
                      } else if (prefs.getInt('selectedTypeUid') == 2) {
                        //navigate to screen with selected id 3
                      } else if (prefs.getInt('selectedTypeUid') == 3) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FBO_Bottombar(
                                      selectedTypeId:
                                          prefs.getInt('selectedTypeUid'),
                                    )));
                      } else {
                        print('this executed');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BottombarPilotTransient()));
                      }
                    },
                    height: 45,
                    minWidth: 200,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(75),
                      side: BorderSide(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: Text(
                      "LOG IN",
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.blue,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Why Join Us?",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          )),
    );
  }
}
