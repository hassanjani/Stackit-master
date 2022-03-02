import 'dart:convert';

import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/Tenant_Dropdown/TransientDB/DB_Pilot2.dart';
import '../TenantScreen/Tenant_Dropdown/TransientDB/DB_Pilot.dart';
import '../TenantScreen/Tenant_Dropdown/TransientDB/DB_Transient_Air_Registery.dart';
import '../TenantScreen/Tenant_Dropdown/TransientDB/DB_Transient_Aircrafts.dart';
import '../TenantScreen/Tenant_Dropdown/TransientDB/DB_Transient_Company.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/Tenant_Dropdown/TenantDBtn/DB_Pilot.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/Tenant_Dropdown/TenantDBtn/DB_Tenant.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/Tenant_Dropdown/TenantDBtn/DB_Tenant_Aircrafts.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/Tenant_Dropdown/TenantDBtn/DB_Tenant_Building.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/Tenant_Dropdown/TransientDB/DB_Transient_Company.dart';
import 'package:flutter_forget_pass_recover_with_verify/Services/tenant_home_get.dart';
import 'package:flutter_forget_pass_recover_with_verify/TimerField/Tenant/date_picker_widget.dart';
import 'package:flutter_forget_pass_recover_with_verify/TimerField/Tenant/time_picker_widget.dart';
import 'package:flutter_forget_pass_recover_with_verify/TimerField/Transient/date_picker_widget.dart';
import 'package:flutter_forget_pass_recover_with_verify/TimerField/Transient/time_picker_widget.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/Component/simpleText.dart';

// ignore: camel_case_types
class Transient_Schedule_Tab2 extends StatefulWidget {
  @override
  _Transient_Schedule_Tab2State createState() =>
      _Transient_Schedule_Tab2State();
}

// ignore: camel_case_types
class _Transient_Schedule_Tab2State extends State<Transient_Schedule_Tab2> {
  bool radioButtonItem = true;
  List data = List();
  String phone;
  int id = 1;
  bool fuelstatus = false;
  List<bool> _checkboxVal = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  String selectedName;
  SharedPreferences prefs;
  bool check = true;

  getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      check = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  GetData() async {
    getSharedPref();
    Provider.of<TransientScheduleProvider2>(context, listen: false)
        .getServices();

    await tenant_home_Get();
    setState(() {});
  }

  int _groupValue = 0;

  Widget _myRadioButton({String title, int value = 0, Function onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: _myRadioButton(
                          title: "Arrival Schedule",
                          value: 0,
                          onChanged: (newValue) =>
                              setState(() => _groupValue = newValue))),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: _myRadioButton(
                          title: "Ramp",
                          value: 1,
                          onChanged: (newValue) =>
                              setState(() => _groupValue = newValue))),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TransientText("Select Pilot"),
                  DB_Transient_Pilots2(),
                  TransientText("Company"),
                  DB_Transient_Company(),
                  TransientText("Select Home"),
                  DB_Transient_Aircrafts(),
                  TransientText("Aircraft Registry"),
                  DB_Transient_Air_Registery(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TransientText("Arrival Date"),
                          // SimpleText("  Arrival Date"),
                          Container(child: DatePickerWidget2()),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TransientText("Arrival Time"),
                          // SimpleText("  Arrival Time"),
                          TimePickerWidget2(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
                height: 38,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.blue,
                    border: Border.all(color: Colors.blue, width: 2)),
                child: Center(
                  child: Text("SELECT SERVICES",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: Colors.white)),
                )),
            Container(
                height: 130,
                margin: EdgeInsets.fromLTRB(
                  10,
                  4,
                  10,
                  0,
                ),
                child: FutureBuilder(
                  future: Provider.of<TransientScheduleProvider2>(context,
                          listen: false)
                      .getServices(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 6 / 1.5),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          _checkboxVal.add(false);
                          return ServiceWidget(
                              context,
                              snapshot.data[index].name,
                              snapshot.data[index].price,
                              index,
                              snapshot.data[index].checked);
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )

                // Column(children: [
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       ServiceWidget(context, "Test Service", "test", 0),
                //       ServiceWidget(context, "Test Service", "test", 1),
                //       ServiceWidget(context, "Test Service", "test", 2),
                //     ],
                //   ),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       ServiceWidget(context, "Test Service", "test", 3),
                //       ServiceWidget(context, "Test Service", "test", 4),
                //       ServiceWidget(context, "Test Service", "test", 5),
                //     ],
                //   ),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       ServiceWidget(context, "Test Service", "test", 6),
                //     ],
                //   ),
                // ]),
                ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
              child: Row(
                children: [
                  Text(
                    "Fuel:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: _myRadioButton(
                          title: "Yes",
                          value: 0,
                          onChanged: (newValue) =>
                              setState(() => _groupValue = newValue))),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: _myRadioButton(
                          title: "No",
                          value: 1,
                          onChanged: (newValue) =>
                              setState(() => _groupValue = newValue))),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: () async {
                save_Reservation();
                // print(phone);
                // final result = await MyServices().tenantReservation(
                //     // status,
                //     // status,
                //     );
                // if (result != null) {}
              },
              height: 40,
              minWidth: 180,
              color: Colors.blue.shade500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(75),
              ),
              child: Text(
                "SUBMIT",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ServiceWidget(
      BuildContext, String title, String smalltitle, int index, int check) {
    return Container(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(shape: BoxShape.rectangle),
              child: Container(
                  height: 28,
                  margin: EdgeInsets.all(12),
                  width: 32,
                  child: Checkbox(
                      splashRadius: 40,
                      activeColor: Colors.grey.shade100,
                      focusColor: Colors.blue,
                      checkColor: Colors.blue,
                      onChanged: (bool value) {
                        if (value != null) {
                          setState(() {
                            _checkboxVal[index] = value;
                          });
                        }
                      },
                      value: _checkboxVal[index]))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$title",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$smalltitle",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  save_Reservation() async {
    var pp = Provider.of<TransientScheduleProvider2>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    print("userid $id");

    var map = {
      // "id": id,
      "schedule_type": "1",
      "tenant_id": "${pp.Tid}",
      "pilot_id": "${pp.Pid}",
      "aircraft_id": "${pp.Aid}",
      "building_id": "${pp.Bid}",
      "is_fuel": fuelstatus ? "1" : "0",
      //"arrival_date": "2021-12-30",
      "arrival_date": "${pp.Adate}",
      // "arrival_time": "15:00",
      "arrival_time": "${pp.Atime}",
      "services": "$_checkboxVal"
    };

    String url =
        'http://wordpresswebsiteprogrammer.com/stackit/public/api/save-reservation';
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
}

class TransientScheduleProvider2 extends ChangeNotifier {
  String Tid = "";
  String Pid = "";
  String Aid = "";
  String Bid = "";
  String Adate = "";
  String Atime = "";

  onchange(String variable, String value) {
    print("$variable  $value");
    switch (variable) {
      case "Tid":
        Tid = value;
        getPilots();
        break;
      case "Pid":
        Pid = value;
        getAircrafts();
        break;
      case "Aid":
        Aid = value;
        getAllBuildings();
        break;
      case "Bid":
        Bid = value;
        break;
      case "Adate":
        Bid = value;
        break;
      case "Atime":
        Bid = value;
        break;
    }
    notifyListeners();
  }

  List data = new List();
  String selectedPilot;

  List Aircraftdata = new List();
  String selectedAircraft;

  List Buildingsdata = new List();
  String selectedBuilding;

  getPilots() async {
    var response = await http.get(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-tenants-list",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(response.statusCode);
    print("DBPilot");
    print(response.body.toString());
    data = jsonData;
    String abc;
    selectedPilot = abc;
    notifyListeners();
  }

  getAircrafts() async {
    var response = await http.get(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-buildings-list?tenant_id=$Tid",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(response.statusCode);
    print("Aircraft");
    print(response.body.toString());
    Aircraftdata = jsonData;
    String abc;
    selectedAircraft = abc;
    print(jsonData);
    notifyListeners();
  }

  Future getAllBuildings() async {
    var response = await http.get(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-aircrafts/tenant?id=$Aid",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(response.statusCode);
    Buildingsdata = jsonData;
    String abc;
    selectedBuilding = abc;
    print(jsonData);
    notifyListeners();
  }

  Future getServices() async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');

    var map = {"user_id": id, "user_type_id": "1", "schedule_type": "0"};

    String url =
        'http://wordpresswebsiteprogrammer.com/stackit/public/api/get-services';
    var response = await post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: map,
        encoding: Encoding.getByName("utf-8"));
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print("Services Response");
    print(response.body.toString());
    // Buildingsdata = jsonData;
    // String abc;
    // selectedBuilding = abc;
    // print(jsonData);
    // notifyListeners();
  }
}
