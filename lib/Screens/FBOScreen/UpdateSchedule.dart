import 'dart:convert';

import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Models/profile/ServiceModel.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/FBOScreen/FBO_Tenant_Schedule_tab.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/Tenant_Dropdown/TenantDBtn/DB_Pilot.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/Tenant_Dropdown/TenantDBtn/DB_Tenant.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/Tenant_Dropdown/TenantDBtn/DB_Tenant_Aircrafts.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/Tenant_Dropdown/TenantDBtn/DB_Tenant_Building.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/tabbar_screen/Tenant_schedule_tab.dart';
import 'package:flutter_forget_pass_recover_with_verify/Services/tenant_home_get.dart';
import 'package:flutter_forget_pass_recover_with_verify/TimerField/Tenant/date_picker_widget.dart';
import 'package:flutter_forget_pass_recover_with_verify/TimerField/Tenant/time_picker_widget.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/Component/simpleText.dart';

// ignore: camel_case_types
class UpdateSchedule extends StatefulWidget {
  int sid;
  UpdateSchedule(this.sid);

  @override
  _UpdateScheduleState createState() => _UpdateScheduleState(sid);
}

// ignore: camel_case_types
class _UpdateScheduleState extends State<UpdateSchedule> {
  int sid;
  _UpdateScheduleState(this.sid);
  bool radioButtonItem = true;
  List data = List();
  String phone;
  // int id = 1;
  bool fuelstatus = false;
  List<bool> _checkboxVal = [];
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
    GetData();
  }

  GetData() async {
    getSharedPref();
    Provider.of<TenantScheduleProvider>(context, listen: false).getServices();

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
                            setState(() => _groupValue = newValue),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: _myRadioButton(
                        title: "Ramp",
                        value: 1,
                        onChanged: (newValue) =>
                            setState(() => _groupValue = newValue),
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
                          blurRadius: 10,
                          color: Colors.grey,
                          offset: Offset(1, 3))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SimpleText("Tenant"),
                      DB_Tenant(),
                      SimpleText("Pilots"),
                      DB_Tenant_Pilot(),
                      SimpleText("Aircrafts"),
                      DB_Tenant_Aircrafts(),
                      SimpleText("Buildings"),
                      DB_Tenant_Building(),
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
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
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
                            blurRadius: 10,
                            color: Colors.grey,
                            offset: Offset(1, 3))
                      ]),
                  child: FutureBuilder(
                      future: Provider.of<FBO_TenantScheduleProvider>(context,
                              listen: false)
                          .getServices(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 6 / 1.5),
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
                  update_Reservation();
                },
                height: 40,
                minWidth: 180,
                color: Colors.blue.shade500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(75),
                ),
                child: Text(
                  "Update",
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
      ),
    );
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

  update_Reservation() async {
    var pp = Provider.of<FBO_TenantScheduleProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    print("userid $id");

    print(sid);
    print(pp.Tid);
    print(pp.Pid);
    print(pp.Aid);
    print(pp.Bid);
    print(pp.Adate);
    print(pp.Atime);
    print(fuelstatus);

    var map = {
      "id": sid.toString(),
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
        'http://wordpresswebsiteprogrammer.com/stackit/public/api/update-reservation';
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
