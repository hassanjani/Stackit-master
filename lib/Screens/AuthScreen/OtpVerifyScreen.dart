import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Models/profile/auth_textfield.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/FBOScreen/FBO_BottomBar.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/Pilot_And_Transient_Screen/BottombarPilot&Transient.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/SplashScreen.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/Tenant_Bottombar.dart';
import 'package:flutter_forget_pass_recover_with_verify/Services/api.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerifyScreen extends StatefulWidget {
  String select;
  int selectedindex;

  OtpVerifyScreen(this.select, this.selectedindex);

  @override
  _OtpVerifyScreenState createState() =>
      _OtpVerifyScreenState(select, selectedindex);
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  String select;
  int selectedindex;

  _OtpVerifyScreenState(this.select, this.selectedindex);

  Api api = Api();
  var idType = [
    'Tenant/Transient',
    // 'Company',
    'FBO',
    'Pilot',
  ];
  var _selectedType;

  var token;
  int _selectedTypeId;
  String otp;

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_type_id';
    final value = token;
    prefs.setString(key, value);
  }

  @override
  void initState() {
    _selectedTypeId = selectedindex;
    super.initState();
    _save(token);
    // getSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    // if (_selectedTypeId == null) {
    //   _selectedTypeId = widget.selectedindex;
    // }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background_home_page.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 65),
                            if (!isKeyboard) Textheader(string: "", six: 18),
                            if (!isKeyboard)
                              Textheader(
                                  string: "Verify Otp",
                                  six: 22,
                                  color: Colors.blueAccent),
                            Textheader(
                                six: 14, string: 'Please Login to Continue'),
                            const SizedBox(height: 20),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Textheader(string: 'Login As', six: 14)),
                            Padding(
                              padding: const EdgeInsets.only(right: 75.0),
                              child: Container(
                                height: 42,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(35),
                                    border: Border.all(color: Colors.blue)),
                                child: FormField<String>(
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 12, top: 4),
                                        // labelStyle: textStyle,
                                        errorStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0),
                                        border: InputBorder.none,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: select,
                                          isDense: true,
                                          onChanged: (String val) {
                                            setState(() {
                                              if (val == 'Tenant/Transient') {
                                                _selectedTypeId = 1;
                                              } else if (val == 'Company') {
                                                _selectedTypeId = 2;
                                              } else if (val == 'FBO') {
                                                _selectedTypeId = 3;
                                              } else {
                                                _selectedTypeId = 4;
                                              }
                                              _selectedType = widget.select;
                                              state.didChange(widget.select);
                                            });
                                          },
                                          items: idType.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child:
                                    Textheader(six: 14, string: "Verify Otp")),
                            Auth_TextField(
                                child: null,
                                hint: "Verify Otp",
                                onTap: (val) {
                                  otp = val;
                                }),
                            SizedBox(height: 50),
                            Auth_Login_Btn(
                                hint: "LOG IN",
                                onTap: () {
                                  VerifyOtp(otp);
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  navigate() async {
    switch (_selectedTypeId) {
      case 1:
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Teanant_Bottombar(selectedTypeId: _selectedTypeId);
          },
        ));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return SplashScreen();
          },
        ));
        break;
      case 3:
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return FBO_Bottombar(selectedTypeId: _selectedTypeId);
          },
        ));

        break;
      default:
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BottombarPilotTransient(selectedTypeId: _selectedTypeId);
            },
          ),
        );
    }
  }

  VerifyOtp(String otp) async {
    print(otp);
    String url =
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/verify-otp";
    var map = {
      "user_type_id": _selectedTypeId.toString(),
      "otp": otp.toString()
    };
    var response = await post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: map,
        encoding: Encoding.getByName("utf-8"));
    print(response.body.toString());

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data["success"]);
    String success = data["success"].toString();

    print('done');
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Success here');
      if (success == "1") {
        Saveuserid(data["id"].toString());
        navigate();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          width: MediaQuery.of(context).size.width * 0.90,
          content: Text(data["message"]),
        ));
      }
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   backgroundColor: Colors.red,
      //   behavior: SnackBarBehavior.floating,
      //   width: MediaQuery.of(context).size.width * 0.90,
      //   content: Text(data["message"]),
      // ));
    }
  }

  Saveuserid(String id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userid', id);
  }
}
