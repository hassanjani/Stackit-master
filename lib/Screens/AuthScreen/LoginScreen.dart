import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Models/profile/auth_textfield.dart';
import 'package:flutter_forget_pass_recover_with_verify/Services/api.dart';

import 'OtpVerifyScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var idType = [
    'Tenant/Transient',
    // 'Company',
    'FBO',
    'Pilot',
  ];
  var _selectedType;
  int _selectedTypeId;
  String phone;
  String currentLanguage;
  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 8),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 8.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          SizedBox(height: 65),
                                          if (!isKeyboard)
                                            Textheader(
                                              string: "Welcome To",
                                              six: 18,
                                              color: Colors.black,
                                            ),
                                          if (!isKeyboard)
                                            Textheader(
                                                string: "The Stackit App",
                                                six: 22,
                                                color: Colors.blueAccent),
                                          Textheader(
                                              six: 14,
                                              string:
                                                  "Please Login to Continue"),
                                          const SizedBox(height: 20),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                              child: Textheader(
                                                six: 14,
                                                string: "Login As",
                                                color: Colors.black,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 75.0),
                                            child: Container(
                                              height: 42,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                  border: Border.all(
                                                      color: Colors.blue)),
                                              child: FormField<String>(
                                                builder: (FormFieldState<String>
                                                    state) {
                                                  return InputDecorator(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 4,
                                                              bottom: 12),
                                                      // labelStyle: textStyle,
                                                      errorStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.0),
                                                      border: InputBorder.none,
                                                    ),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton<
                                                          String>(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        hint: Text(
                                                            'Choose Option'),
                                                        value: _selectedType,
                                                        isDense: true,
                                                        onChanged:
                                                            (String val) {
                                                          currentLanguage = val;
                                                          setState(() {
                                                            if (val ==
                                                                'Tenant/Transient') {
                                                              _selectedTypeId =
                                                                  1;
                                                            } else if (val ==
                                                                'Company') {
                                                              _selectedTypeId =
                                                                  2;
                                                            } else if (val ==
                                                                'FBO') {
                                                              _selectedTypeId =
                                                                  3;
                                                            } else {
                                                              _selectedTypeId =
                                                                  4;
                                                            }
                                                            _selectedType = val;
                                                            state
                                                                .didChange(val);
                                                          });
                                                        },
                                                        items: idType.map(
                                                            (String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(
                                                              value,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
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
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                              child: Textheader(
                                                  six: 14,
                                                  string: "Phone Number")),
                                          Auth_TextField(
                                              child: null,
                                              hint: "Enter Phone Number",
                                              onTap: (val) {
                                                phone = val;
                                              }),
                                          SizedBox(height: 50),
                                          Auth_Login_Btn(
                                              hint: "LOG IN",
                                              onTap: () async {
                                                print(_selectedTypeId);
                                                print(
                                                    "here type _selectedTypeId");
                                                print(phone);
                                                final result = await Api()
                                                    .verificationOTP(
                                                        context,
                                                        _selectedTypeId
                                                            .toString(),
                                                        phone);
                                                if (result != null) {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return OtpVerifyScreen(
                                                      _selectedType.toString(),
                                                      _selectedTypeId,
                                                    );
                                                  }));
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    backgroundColor: Colors.red,
                                                    duration:
                                                        Duration(seconds: 2),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.90,
                                                    content: Text(
                                                        "Please Enter Field"),
                                                  ));
                                                }
                                              }),
                                        ]))
                                  ])))),
                ))));
  }
}
