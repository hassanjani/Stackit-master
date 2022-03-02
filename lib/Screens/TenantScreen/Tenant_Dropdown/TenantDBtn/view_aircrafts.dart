import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/tabbar_screen/Tenant_schedule_tab.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class View_Aircrafts extends StatefulWidget {
  @override
  _View_AircraftsState createState() => _View_AircraftsState();
}

class _View_AircraftsState extends State<View_Aircrafts> {
  String selectedName;
  List data = List();

  Future getAllName() async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    var response = await http.get(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-buildings-list?tenant_id=$id",
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 35,
            width: MediaQuery.of(context).size.width * 0.60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(10),
                right: Radius.circular(10),
              ),
              border: Border.all(color: Colors.blue),
            ),
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: DropdownButton(
                  isExpanded: true,
                  icon: Container(
                    height: 35,
                    width: 32,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                  ),
                  hint: Text('Choose Option'), // Not necessary for Option 1
                  value: selectedName,
                  onChanged: (newValue) {
                    setState(() {
                      selectedName = newValue;
                      Provider.of<TenantScheduleProvider>(context,
                              listen: false)
                          .onchange("Tid", newValue);
                    });
                  },
                  items: data.map((value) {
                    return DropdownMenuItem(
                      value: value["id"] == null ? "" : value["id"].toString(),
                      child: Text(
                          value["name"] == null ? "" : value["name"].toString(),
                          style: TextStyle(fontSize: 12)),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          ///////////
        ],
      ),
    );
  }
}
