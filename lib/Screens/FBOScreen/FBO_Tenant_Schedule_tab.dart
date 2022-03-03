import 'dart:convert';

import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Models/profile/ServiceModel.dart';
import 'package:flutter_forget_pass_recover_with_verify/Services/tenant_home_get.dart';
import 'package:flutter_forget_pass_recover_with_verify/TimerField/Tenant/date_picker_widget.dart';
import 'package:flutter_forget_pass_recover_with_verify/TimerField/Tenant/time_picker_widget.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/Component/simpleText.dart';
import 'DB_Tenant/FBO_DB_Pilot.dart';
import 'DB_Tenant/FBO_DB_Tenant.dart';
import 'DB_Tenant/FBO_DB_Tenant_Aircrafts.dart';
import 'DB_Tenant/FBO_DB_Tenant_Building.dart';

// ignore: camel_case_types
class FBO_Tenant_Schedule_Tab extends StatefulWidget {
  @override
  _FBO_Tenant_Schedule_TabState createState() =>
      _FBO_Tenant_Schedule_TabState();
}

// ignore: camel_case_types
class _FBO_Tenant_Schedule_TabState extends State<FBO_Tenant_Schedule_Tab> {
  bool radioButtonItem = true;
  List data = List();
  String phone;
  int id = 1;
  bool fuelstatus = false;
  List<bool> _checkboxVal = [];
  String selectedName;
  SharedPreferences prefs;
  bool check = true;

  getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      check = false;
      print(prefs);
    });
  }

  @override
  void initState() {
    super.initState();

    GetData();
  }

  GetData() async {
    getSharedPref();
    Provider.of<FBO_TenantScheduleProvider>(context, listen: false).Clearall();
    Provider.of<FBO_TenantScheduleProvider>(context, listen: false)
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
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
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
                onChanged: (newValue) => setState(() => _groupValue = newValue),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: _myRadioButton(
                title: "Ramp",
                value: 1,
                onChanged: (newValue) => setState(() => _groupValue = newValue),
              ),
            ),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(10),
              right: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleText("Tenant"),
              FBO_DB_Tenant(),
              SimpleText("Pilots"),
              FBO_DB_Tenant_Pilot(),
              SimpleText("Aircrafts"),
              FBO_DB_Tenant_Aircrafts(),
              SimpleText("Buildings"),
              FBO_DB_Tenant_Building(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SimpleText("Arrival Date"),
                      Container(child: DatePickerWidget()),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SimpleText("Arrival Time"),
                      TimePickerWidget(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 10),
      Container(
          height: 38,
          width: 180,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(10),
                right: Radius.circular(10),
              ),
              border: Border.all(color: Colors.blue, width: 2)),
          child: Center(
            child: Text(
              "SELECT SERVICES",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
            ),
          )),
      Container(
          height: 130,
          margin: EdgeInsets.fromLTRB(
            10,
            4,
            10,
            0,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(10),
                right: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))
              ]),
          child: FutureBuilder(
              future: Provider.of<FBO_TenantScheduleProvider>(context,
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
              })),
      SizedBox(height: 10),
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
            CustomSwitch(
              activeColor: Colors.blueAccent,
              value: fuelstatus,
              onChanged: (value) {
                fuelstatus = value;
              },
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      MaterialButton(
          onPressed: () async {
            save_Reservation();
          },
          height: 40,
          minWidth: 180,
          color: Colors.blue.shade500,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
          child: Text("SUBMIT",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w900)))
    ]))));
  }

  List<ServicesModel> servicelist = [];

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
    var pp = Provider.of<FBO_TenantScheduleProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    print("userid $id");

    print(id);
    print(pp.Tid);
    print(pp.Pid);
    print(pp.Aid);
    print(pp.Bid);
    print(pp.Adate);
    print(pp.Atime);
    print(fuelstatus);

    var map = {
      "id": id,
      "schedule_type": "$_groupValue", //"1"
      "tenant_id": "${pp.Tid}",
      "pilot_id": "${pp.Pid}",
      "aircraft_id": "${pp.Aid}",
      "building_id": "${pp.Bid}",
      "is_fuel": fuelstatus ? "1" : "0",
      // "arrival_date": "",
      "arrival_date": "${pp.Adate}",
      // "arrival_time": "15:00",
      "arrival_time": "${pp.Atime}",
      "services": "$servicelist"
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

class FBO_TenantScheduleProvider extends ChangeNotifier {
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
        Adate = value;
        break;
      case "Atime":
        Atime = value;
        break;
    }
    print("$variable  $value");
    notifyListeners();
  }

  getTenant() {
    getAllTenants();
    notifyListeners();
  }

  List data = new List();
  String selectedPilot = "";

  // ignore: non_constant_identifier_names
  List AircraftData = new List();
  String selectedAircraft;

  // ignore: deprecated_member_use, non_constant_identifier_names
  List BuildingsData = new List();
  String selectedBuilding;

  List TenantssData = new List();
  String selectedTenant;

  List IataData = new List();
  String selectedIata;

  List ServicesData = new List();
  String selectedServices;

  changename(String pilot, String aircraft, String building, String iata,
      String status) {
    selectedPilot = pilot;
    selectedAircraft = aircraft;
    selectedBuilding = building;
    selectedIata = iata;
    selectedServices = status;
    notifyListeners();
  }

  getPilots() async {
    print("pilot: $Tid");
    var response = await http.get(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-pilots-list?tenant_id=$Tid",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(response.statusCode);
    print("DBPilot");
    print(response.body.toString());
    data = jsonData;
    // String abc;
    // selectedPilot = abc;
    notifyListeners();
  }

  Clearall() {
    String abc;
    Tid = abc;
    Pid = abc;
    Aid = abc;
    Bid = abc;
    Adate = "";
    Atime = "";
    notifyListeners();
  }

  getAircrafts() async {
    print("aircraft: $Pid");

    var response = await http.get(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-aircrafts-list?pilot_id=$Pid",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(response.statusCode);
    print("Aircraft");
    print(response.body.toString());
    AircraftData = jsonData;
    String abc;
    selectedAircraft = abc;
    print(jsonData);
    notifyListeners();
  }

  Future getAllBuildings() async {
    print("building: $Aid");

    var response = await http.get(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-buildings-list?aircraft_id=$Aid",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(response.statusCode);
    BuildingsData = jsonData;
    // String abc;
    // selectedBuilding = abc;
    print(jsonData);
    notifyListeners();
  }

  Future<List<ServicesModel>> getServices() async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');

    var map = {"user_id": "$id", "user_type_id": "3", "schedule_type": "1"};

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
    List<ServicesModel> servicelist = [];

    servicelist = List<ServicesModel>.from(
        json.decode(response.body).map((x) => ServicesModel.fromMap(x)));
    print("Service lenth");
    print(servicelist.length);
    return servicelist;
  }

  Future getAllTenants() async {
    var response = await http.get(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-tenants-list",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(response.statusCode);
    TenantssData = jsonData;
    // String abc;
    // selectedTenant = abc;
    print(jsonData);
    notifyListeners();
  }

  // Future getAllName() async {
  //   var response = await http.get(
  //       "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-tenants-list",
  //       headers: {"Accept": "application/json"});
  //   var jsonBody = response.body;
  //   var jsonData = json.decode(jsonBody);
  //   print(response.statusCode);
  //   print("DBTenant");
  //
  //   print(response.body.toString());
  //
  //   setState(() {
  //     data = jsonData;
  //   });
  //
  //   print(jsonData);
  //   return "success";
  // }
}
