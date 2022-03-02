import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Models/profile/Add_TextField.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/Pilot_And_Transient_Screen/component/component.dart';
import 'package:flutter_forget_pass_recover_with_verify/Widgets/Component/simpleText.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../SplashScreen.dart';
import 'AddPilot.dart';
import 'Add_Tenant_Screen.dart';

class FBO_Tenant_Screen extends StatefulWidget {
  @override
  State<FBO_Tenant_Screen> createState() => _FBO_Tenant_ScreenState();
}

class _FBO_Tenant_ScreenState extends State<FBO_Tenant_Screen> {
  String Reg, Type, Home;
  bool check = true;
  List<CompanyModel> users = [];
  DataModelDeatails users2;
  TextEditingController Edt_Fname = TextEditingController();
  TextEditingController Edt_Lname = TextEditingController();

  getDataAgain() async {
    users = await ServicesFboTT().getDataFboT();
    setState(() {
      check = false;
    });
  }

  String id = "";

  @override
  void initState() {
    super.initState();
    getDataAgain();
    // getDetails("13");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: check
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 4),
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.black)),
                        child: Text(
                          "Tenants",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                            Container(
                              child: Table(
                                border: TableBorder.all(
                                    color: Colors.blue, width: 1.0),
                                children: [
                                  TableRow(children: [
                                    tableHeader("company"),
                                    tableHeader("Email"),
                                    tableHeader("Phone"),
                                  ]),
                                ],
                              ),
                            ),
                          ])),
                      Table(
                        columnWidths: {},
                        children: users.map((user) {
                          return TableRow(
                              decoration: BoxDecoration(
                                  color: id == user.id.toString()
                                      ? Colors.blue.shade50
                                      : Colors.white),
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      id = user.id.toString();
                                      Reg = user.id.toString();
                                    });
                                  },
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              12,
                                      decoration: BoxDecoration(
                                          // color: id == user.id.toString()
                                          //     ? Colors.blue
                                          //     : Colors.white
                                          ),
                                      padding: EdgeInsets.all(12),
                                      child: Text(user.companyName == null
                                          ? "Empty"
                                          : user.companyName)),
                                ),
                                Container(
                                    height:
                                        MediaQuery.of(context).size.height / 12,
                                    // color: users.indexOf(user) % 2 == 0
                                    //     ? Colors.blue[50]
                                    //     : Colors.white,
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8.0, right: 8.0),
                                    child: Text(
                                      user.email == null ? "Empty" : user.email,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                    )),
                                Container(
                                    height:
                                        MediaQuery.of(context).size.height / 12,
                                    // color: users.indexOf(user) % 2 == 0
                                    //     ? Colors.blue[50]
                                    //     : Colors.white,
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      user.phone == null ? "Empty" : user.phone,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                    ))
                              ]);
                        }).toList(),
                        border: TableBorder.all(color: Colors.blue),
                      ),
                      //////////////////////   Details Of tenant  /////////////////////
                      SizedBox(height: 15),
                      Container(
                        margin: EdgeInsets.only(bottom: 4),
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.black)),
                        child: Text(
                          "Details of Tenant",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              UserSetText("F-Name"),
                              SizedBox(width: 2),
                              Add_TextField(
                                  hint: "First Name", callback: Edt_Fname),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              UserSetText("L-Name:"),
                              Add_TextField(
                                  hint: "Last Name", callback: Edt_Lname),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Divider(height: 10, color: Colors.black),
                      ///////////////////////////////////////////////////////////////////////////

                      ///////////////////////// View Pilot  ////////
                      SizedBox(height: 15),
                      Container(
                        margin: EdgeInsets.only(bottom: 4),
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.black)),
                        child: Text(
                          "View Pilot",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                            Container(
                              child: Table(
                                border: TableBorder.all(
                                    color: Colors.blue, width: 1.0),
                                children: [
                                  TableRow(children: [
                                    tableHeader("F-Name"),
                                    tableHeader("L-Name"),
                                    tableHeader("Email"),
                                    tableHeader("Phone#"),
                                  ]),
                                ],
                              ),
                            ),
                          ])),

                      FutureBuilder<DataModelDeatails>(
                        future: getDataFboTDetail(id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Table(
                              columnWidths: {},
                              children: [
                                TableRow(children: [
                                  Container(
                                      height: 80,
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                          snapshot.data.first_name.toString())),
                                  Container(
                                      height: 80,
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                          snapshot.data.last_name.toString())),
                                  Container(
                                      height: 80,
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        snapshot.data.email1.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                      )),
                                  Container(
                                      height: 80,
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        snapshot.data.phone.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                      ))
                                ])
                              ],
                              border: TableBorder.all(
                                  color: Colors.blue, width: 1.0),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<DataModelDeatails> getDataFboTDetail(String id) async {
    var url2 = Uri.parse(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-tenant-detail?tenant_id=$id");

    var data = await http.get(url2);
    if (data.statusCode == 200) {
      final jsonData = json.decode(data.body);
      print("this data");
      print(data.body.toString());
      print(jsonData['first_name']);
      // List usersList2 = [];

      DataModelDeatails model = DataModelDeatails(
          id: jsonData['id'],
          first_name: jsonData['first_name'].toString(),
          last_name: jsonData['last_name'].toString(),
          email1: jsonData['email'].toString(),
          state: jsonData['state'].toString(),
          phone: jsonData['phone'].toString(),
          postal_code: jsonData['postal_code'].toString(),
          country: jsonData['country'].toString(),
          city: jsonData['city'].toString(),
          address: jsonData['address'].toString());

      Edt_Fname.text = model.first_name;
      Edt_Lname.text = model.last_name;
      print(model.first_name);
      return model;
    } else {
      print("Sorry we have an error");
      print(data.statusCode);
      return null;
    }
  }
}

///////////////////   Tenant Activity   /////////////////////////////////
class ServicesFboTT {
  // var url = Uri.parse(
  //     "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-tenants?id=40");
  //for fetching a list of notes from server

  Future getDataFboT() async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    var url = Uri.parse(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-tenants?id=$id");
    print("Good");
    var data = await http.get(url);
    if (data.statusCode == 200) {
      final jsonData = json.decode(data.body);
      print(data.body);
      List<CompanyModel> usersList = [];
      for (var user in jsonData) {
        CompanyModel model = CompanyModel(
            id: user['id'],
            companyName: user['company_name'] == null
                ? "Empty"
                : user['company_name'].toString(),
            email: user['email'] == null ? "Empty" : user['email'].toString(),
            phone: user['phone'] == null ? "Empty" : user['phone'].toString());
        usersList.add(model);
      }
      print(usersList.length);
      return usersList;
    } else {
      print("Sorry we have an error");
      print(data.statusCode);
      return null;
    }
  }
}

class DataModel {
  final int id;
  final String registry;
  final String type;
  final String home;
  DataModel({this.id, this.home, this.registry, this.type});
}

class DataModelDeatails {
  final int id;
  final String first_name;
  final String last_name;
  final String country;
  final String email1;
  final String city;
  final String state;
  final String phone;
  final String postal_code;
  final String address;
  DataModelDeatails(
      {this.id,
      this.first_name,
      this.city,
      this.last_name,
      this.phone,
      this.country,
      this.postal_code,
      this.state,
      this.address,
      this.email1});
}

class CompanyModel {
  CompanyModel({
    @required this.id,
    @required this.companyName,
    @required this.email,
    @required this.phone,
    @required this.phone2,
  });

  int id;
  String companyName;
  String email;
  String phone;
  String phone2;

  factory CompanyModel.fromMap(Map<String, dynamic> json) => CompanyModel(
        id: json["id"],
        companyName: json["company_name"],
        email: json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        phone2: json["phone2"] == null ? null : json["phone2"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "company_name": companyName,
        "email": email,
        "phone": phone == null ? null : phone,
        "phone2": phone2 == null ? null : phone2,
      };
}
