import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/Pilot_And_Transient_Screen/component/component.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../TenantScreen/AddPilot.dart';
import 'UserSettingsScreen.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Pilot_A_Transient_AircraftAssigned extends StatefulWidget {
  @override
  State<Pilot_A_Transient_AircraftAssigned> createState() =>
      _Pilot_A_Transient_AircraftAssignedState();
}

// ignore: camel_case_types
class _Pilot_A_Transient_AircraftAssignedState
    extends State<Pilot_A_Transient_AircraftAssigned> {
  bool check = true;
  List users = [];
  getDataAgain() async {
    users = await Services().getData();
    setState(() {
      check = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataAgain();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 12, right: 12, top: 12),
                      width: MediaQuery.of(context).size.width * 0.50,
                      height: 28,
                      decoration: BoxDecoration(
                          // border: Border.all(color: Colors.black),
                          ),
                      child: Text(
                        "Aircraft Assigned",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w900),
                      ),
                    ),
                    Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 12, right: 12),
                            child: Table(
                              border: TableBorder.all(
                                  color: Colors.blue, width: 1.0),
                              children: [
                                TableRow(children: [
                                  tableHeader("Registry"),
                                  tableHeader("Types"),
                                  tableHeader("Home"),
                                ]),
                              ],
                            ),
                          ),
                        ])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Table(
                        columnWidths: {},
                        children: users.map((user) {
                          return TableRow(children: [
                            Container(
                                height: 85,
                                // color: users.indexOf(user) % 2 == 0
                                //     ? Colors.blue[50]
                                //     : Colors.white,
                                padding: const EdgeInsets.only(
                                    left: 6.0, right: 6.0, top: 8.0),
                                child: Text(user.registry)),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                  height: 85,
                                  padding: const EdgeInsets.only(
                                      left: 6.0, right: 6.0, top: 8.0),
                                  child: Text(
                                    user.type,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  )),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                  height: 85,
                                  padding: const EdgeInsets.only(
                                      left: 6.0, right: 6.0, top: 8.0),
                                  child: Text(
                                    user.home,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  )),
                            )
                          ]);
                        }).toList(),
                        border: TableBorder.all(color: Colors.blue, width: 1.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class Services {
  //for fetching a list of notes from server
  Future getData() async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    var url = Uri.parse(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-aircrafts/pilot?id=$id");
    var data = await http.get(url);
    if (data.statusCode == 200) {
      final jsonData = json.decode(data.body);
      List usersList = [];
      for (var user in jsonData) {
        DataModel model = DataModel(
            id: user['id'],
            home: user['home'],
            registry: user['registry'],
            type: user['type']);
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
