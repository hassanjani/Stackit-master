import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Models/profile/Add_TextField.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/SplashScreen.dart';
import 'package:flutter_forget_pass_recover_with_verify/Services/fbo_post_api/add_tenant.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/Component/simpleText.dart';

class Add_Tenant_Screen extends StatefulWidget {
  @override
  _Add_Tenant_ScreenState createState() => _Add_Tenant_ScreenState();
}

class _Add_Tenant_ScreenState extends State<Add_Tenant_Screen> {
  // bool check = true;
  // DataModel model;

  TextEditingController fNamee = TextEditingController();
  TextEditingController LNamee = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController postal_code = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController cityy = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController phone2 = TextEditingController();
  // TextEditingController ide = TextEditingController();

  String country, state;

  @override
  void initState() {
    super.initState();

    getCountries();
    getStates("");
  }

  // Future<File> file;
  String status;

  setStatus(String message) {
    setState(() {
      status = message;
    });
    print(status);
  }

  @override
  Widget build(BuildContext context) {
    print("User Setting Screen");
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AircraftText("Add New Tenant"),
                SizedBox(height: 10),
                //////////////////////////////////////////////////////////////////////////////////
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     UserProfileText("Company Name:"),
                //     Add_TextField(
                //       hint: "Company Name",
                //       callback: fNamee,
                //       width: double.infinity,
                //     ),
                //   ],
                // ),
                //////////////////////////////////////////////////////////////////////////////////
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileText("First Name:"),
                    Add_TextField(
                      hint: "First Name",
                      callback: fNamee,
                      width: double.infinity,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileText("Last Name"),
                    Add_TextField(
                      hint: "Last Name:",
                      callback: LNamee,
                      width: double.infinity,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileText("Address"),
                    Add_TextField(
                      hint: "Address",
                      callback: address1,
                      width: double.infinity,
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileText("Address 2"),
                    Add_TextField(
                      hint: "Address 2",
                      callback: address2,
                      width: double.infinity,
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileText("Country:"),
                    // SizedBox(width: 2),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      height: 35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(5),
                          right: Radius.circular(5),
                        ),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text("country"), // Not necessary for Option 1
                            value: selectedCountry,
                            onChanged: (newValue) {
                              setState(() {
                                selectedCountry = newValue;
                                getStates(selectedCountry);
                                // Provider.of<TenantScheduleProvider>(context,listen: false).onchange("Tid", newValue);
                              });
                            },
                            items: data.map((value) {
                              return DropdownMenuItem(
                                value: value["id"] == null
                                    ? ""
                                    : value["id"].toString(),
                                child: Text(
                                    value["value"] == null
                                        ? ""
                                        : value["value"],
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: 2),
                  ],
                ),
                // SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileText("State:   "),
                    SizedBox(width: 2),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      height: 35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(5),
                          right: Radius.circular(5),
                        ),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text("state"), // Not necessary for Option 1
                            value: selectedState,
                            onChanged: (newValue) {
                              setState(() {
                                selectedState = newValue;
                                // Provider.of<TenantScheduleProvider>(context,listen: false).onchange("Tid", newValue);
                              });
                            },
                            items: StatesData.map((value) {
                              return DropdownMenuItem(
                                value: value["id"].toString(),
                                child: Text(value["value"],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileText("Post zip:"),
                    Add_TextField(
                      hint: "Post zip",
                      callback: postal_code,
                      width: double.infinity,
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileText("City:"),
                    Add_TextField(
                      hint: "City",
                      callback: cityy,
                      width: double.infinity,
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileText("Email:"),
                    Add_TextField(
                      hint: "Email",
                      callback: email,
                      width: double.infinity,
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileText("C Email:"),
                    Add_TextField(
                      hint: "C Email",
                      // callback: email,
                      width: double.infinity,
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileText("Password:"),
                    Add_TextField(
                      hint: "Password",
                      callback: pass,
                      width: double.infinity,
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileText("C Password:"),
                    Add_TextField(
                      hint: "C Password",
                      // callback: email,
                      width: double.infinity,
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileText("Phone #"),
                    Add_TextField(
                      hint: "Phone #",
                      callback: phone,
                      width: double.infinity,
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileText("After Ph #"),
                    Add_TextField(
                      hint: "After Ph #",
                      callback: phone2,
                      width: double.infinity,
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileText("Notes:  "),
                    // SizedBox(width: 2),
                    Container(
                      height: 150,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: note,
                          // onChanged: (val) {
                          //   note = val;
                          // },
                          maxLines: 5,
                          minLines: 5,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1.0),
                            ),
                            border: OutlineInputBorder(),
                            hintText: "note",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: 90,
                        height: 40,
                        margin: EdgeInsets.only(bottom: 20, top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue.shade500,
                        ),
                        child: TextButton(
                          onPressed: () async {
                            final result = await FBO_Api().FBO_ADD_TENANT(
                              context,
                              fNamee.text,
                              LNamee.text,
                              address1.text,
                              address2.text,
                              selectedCountry,
                              selectedState,
                              postal_code.text,
                              cityy.text,
                              email.text,
                              // pass.text,
                              note.text,
                              phone.text,
                              phone2.text,
                            );
                            return result;
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String selectedCountry;
  List data = List();
  Future getCountries() async {
    var response = await http.get(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/countries",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(response.statusCode);
    print(response.body.toString());

    setState(() {
      data = jsonData;
    });

    print(jsonData);

    return "success";
  }

  String selectedState;
  List StatesData = List();
  Future getStates(String country) async {
    var map = {"country": "USA"};
    var response = await http.get(
      "http://wordpresswebsiteprogrammer.com/stackit/public/api/states?country=$country",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
    );
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(response.statusCode);
    print(response.body.toString());
    String a;
    selectedState = a;
    setState(() {
      StatesData = jsonData;
    });
    print(jsonData);
    return "success";
  }
}
