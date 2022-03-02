import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Widgets/Component/PilotText.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Tenant_AddPilot extends StatefulWidget {
  @override
  _Tenant_AddPilotState createState() => _Tenant_AddPilotState();
}

class _Tenant_AddPilotState extends State<Tenant_AddPilot> {
  String fname, lname, email, phone1, phone2, notees;
  String acReg, acType;

  Future addPilot(context, String fname, String lname, String email,
      String phone1, String phone2, String notees) async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    var uriPost = Uri.parse(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/store-pilot?tenant_id=$id");
    // "&firstname=$fname&lastname=$lname&email=$email&phone=$phone1&phone2=$phone2&Note=$notees");
    print('working');
    print('inside try');
    http.Response response = await http.post(uriPost, body: {
      "firstname": fname,
      "lastname": lname,
      "email": email,
      "phone": phone1,
      "phone2": phone2,
      "Note": notees,
    });
    print('done');
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data["success"]);
    String success = data["success"].toString();
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text(response.body.toString())));
    if (success == "1") {
      print(response.statusCode);
      print('done');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          width: MediaQuery.of(context).size.width * 0.90,
          content: Text(data["message"])));
    } else {
      print("Sorry we have an error");
      print(response.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          width: MediaQuery.of(context).size.width * 0.90,
          content: Text(data["message"])));
    }
    return response.body;
  }

  // Future addPilot() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String id = await prefs.getString('userid');
  //   var url = Uri.parse(
  //       "http://wordpresswebsiteprogrammer.com/stackit/public/api/store-pilot?tenant_id=$id&firstname=$fname&lastname=$lname&email=$email&phone=$phone1&phone2=$phone2&Note=$notees");
  //   var response = await http.post(url);
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(response.body.toString())));
  //   if (response.statusCode == 200) {
  //     print(response.statusCode);
  //     print('done');
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(response.body.toString())));
  //   } else {
  //     print("Sorry we have an error");
  //     print(response.statusCode);
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(response.body.toString())));
  //   }
  // }

  Future addAircraft() async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    var url = Uri.parse(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/store-aircraft?tenant_id=$id&pilot_id=$id&registry=$acReg&type=$acType&home_id=6");
    var response = await http.post(url);
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data["success"]);
    String success = data["success"].toString();
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text(response.body.toString())));
    if (success == "1") {
      print(response.statusCode);
      print('done');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          width: MediaQuery.of(context).size.width * 0.90,
          content: Text(data["message"])));
    } else {
      print("Sorry we have an error");
      print(response.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          width: MediaQuery.of(context).size.width * 0.90,
          content: Text(data["message"])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PilotHeaderText("Add Pilot"),
              Divider(height: 4, color: Colors.black),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Pilottext("F-Name"),
                  // SizedBox(width: 7),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        onChanged: (fnameVal) {
                          fname = fnameVal;
                        },
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.0),
                          ),
                          hintText: "F Name",
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Pilottext("L-Name"),
                  // SizedBox(width: 7),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        onChanged: (fnameVal) {
                          lname = fnameVal;
                        },
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.0),
                          ),
                          hintText: "L Name",
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Pilottext("Email"),
                  // SizedBox(width: 7),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        onChanged: (fnameVal) {
                          email = fnameVal;
                        },
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.0),
                          ),
                          hintText: "Email",
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Pilottext("Phone #"),
                  SizedBox(width: 7),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (fnameVal) {
                          phone1 = fnameVal;
                        },
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.0),
                          ),
                          hintText: "Phone #",
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Pilottext("After Ph"),
                  // SizedBox(width: 7),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (fnameVal) {
                          phone2 = fnameVal;
                        },
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.0),
                          ),
                          hintText: "After Ph #",
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Pilottext("Notes"),
                  // SizedBox(width: 7),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        onChanged: (fnameVal) {
                          notees = fnameVal;
                        },
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.0),
                          ),
                          hintText: "Notes",
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                      border: Border.all(color: Colors.white)),
                  child: TextButton(
                    onPressed: () async {
                      addPilot(
                          context,
                          fname.toString(),
                          lname.toString(),
                          email.toString(),
                          phone1.toString(),
                          phone2.toString(),
                          notees.toString());
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              ///////////////
              PilotHeaderText("Add A/c Reg"),
              Divider(height: 4, color: Colors.black),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Pilottext("A/c Reg"),
                  // SizedBox(width: 7),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        onChanged: (acRegister) {
                          acReg = acRegister;
                        },
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.0),
                          ),
                          hintText: "A/c Reg",
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Pilottext("A/c Type"),
                  // SizedBox(width: 7),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        onChanged: (acTypess) {
                          acType = acTypess;
                        },
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.0),
                          ),
                          hintText: "A/c Type",
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.shade500,
                      border: Border.all(color: Colors.white)),
                  child: TextButton(
                    onPressed: () async {
                      addAircraft();
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
        ),
      ),
    );
  }
}
