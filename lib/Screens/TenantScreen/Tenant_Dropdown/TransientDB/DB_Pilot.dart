import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/tabbar_screen/Transient_schedule_tab.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../AddPilot.dart';

class DB_Transient_Pilots extends StatefulWidget {
  @override
  _DB_Transient_PilotsState createState() => _DB_Transient_PilotsState();
}

class _DB_Transient_PilotsState extends State<DB_Transient_Pilots> {
  String selectedName;
  List data = List();

  Future getAllName() async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    var response = await http.get(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-pilots-list?tenant_id=$id",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(response.statusCode);
    print("DBTenant");

    print(response.body.toString());

    setState(() {
      data = jsonData;
    });

    print(jsonData);
    return "success";
  }

  @override
  void initState() {
    super.initState();
    getAllName();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0),
          //   child: SimpleText("Select Pilot"),
          // ),
          Row(
            children: [
              Container(
                height: 35,
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(35),
                    right: Radius.circular(35),
                  ),
                  border: Border.all(color: Colors.blue),
                ),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text('Choose Option'), // Not necessary for Option 1
                      value: selectedName,
                      onChanged: (newValue) {
                        setState(() {
                          selectedName = newValue;
                          Provider.of<TransientScheduleProvider>(context,
                                  listen: false)
                              .onchange("Tid", newValue);
                        });
                      },
                      items: data != null
                          ? data.map((value) {
                              return DropdownMenuItem(
                                value: value["id"] == null
                                    ? ""
                                    : value["id"].toString(),
                                child: Text(
                                    value["name"] == null
                                        ? ""
                                        : value["name"].toString(),
                                    style: TextStyle(fontSize: 12)),
                              );
                            }).toList()
                          : [],
                    ),
                  ),
                ),
              ),
              Container(
                height: 35,
                width: MediaQuery.of(context).size.width * 0.13,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Tenant_AddPilot()));
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
          ///////////
        ],
      ),
    );
  }
}
