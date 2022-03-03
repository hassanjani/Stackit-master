import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Models/profile/Add_TextField.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/Pilot_And_Transient_Screen/component/component.dart';
import 'package:flutter_forget_pass_recover_with_verify/Widgets/Component/simpleText.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FBO_Tenant_Schedule_tab.dart';
import 'UpdateSchedule.dart';

class Activity_Screen extends StatefulWidget {
  @override
  State<Activity_Screen> createState() => _Activity_ScreenState();
}

class _Activity_ScreenState extends State<Activity_Screen> {
  bool check = true;
  bool isPressed = false;
  int selectedid = 0;
  List users = [];

  getDataAgain() async {
    users = await ServicesFbo().getDataFbo();
    setState(() {
      check = false;
    });
  }

  TextEditingController edt_pilot = TextEditingController();
  TextEditingController edt_aircraft = TextEditingController();
  TextEditingController edt_RDt = TextEditingController();
  TextEditingController edt_arrDt = TextEditingController();
  TextEditingController edt_dDt = TextEditingController();
  TextEditingController edt_status = TextEditingController();
  TextEditingController edt_services = TextEditingController();
  TextEditingController edt_iata = TextEditingController();
  TextEditingController edt_is_fuel = TextEditingController();
  TextEditingController edt_building_name = TextEditingController();
  // TextEditingController edt_pilot=TextEditingController();
  // TextEditingController edt_pilot=TextEditingController();
  // TextEditingController edt_pilot=TextEditingController();

  @override
  void initState() {
    super.initState();
    edt_pilot.text = "";
    edt_aircraft.text = "";
    edt_arrDt.text = "";
    edt_RDt.text = "";
    edt_dDt.text = "";
    edt_status.text = "";
    edt_services.text = "";
    edt_iata.text = "";
    edt_is_fuel.text = "";
    edt_building_name.text = "";
    getDataAgain();
  }

  final dataKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin:
                                  EdgeInsets.only(left: 0, bottom: 0, top: 10),
                              child: Text("Activity Log",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18))),
                          Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                Container(
                                  child: Table(
                                    border: TableBorder.all(
                                        color: Colors.blue, width: 1),
                                    children: [
                                      TableRow(children: [
                                        tableHeader("E/R"),
                                        tableHeader("IATA"),
                                        tableHeader("B"),
                                        tableHeader("Time"),
                                      ]),
                                    ],
                                  ),
                                ),
                              ])),
                          Table(
                            // defaultVerticalAlignment: ,
                            columnWidths: {},
                            children: users.map((user) {
                              return TableRow(
                                  decoration: BoxDecoration(
                                    color: selectedid == user.id
                                        ? Colors.blue.shade50
                                        : Colors.white,
                                  ),
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        getdata(user.id.toString());
                                        setState(() {
                                          selectedid = user.id;
                                          Scrollable.ensureVisible(
                                              dataKey.currentContext);
                                        });
                                        EditReservationss();
                                      },
                                      child: Container(
                                          height: 100,
                                          padding: const EdgeInsets.only(
                                              left: 6.0, right: 6.0, top: 8.0),
                                          child: Text(user.te_tr)),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                          height: 100,
                                          padding: const EdgeInsets.only(
                                              left: 6.0, right: 6.0, top: 8.0),
                                          child: Text(
                                            user.iata,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400),
                                          )),
                                    ),
                                    InkWell(
                                      child: Container(
                                          height: 100,
                                          padding: const EdgeInsets.only(
                                              left: 6.0, right: 6.0, top: 8.0),
                                          child: Text(
                                            user.building_name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400),
                                          )),
                                    ),
                                    Container(
                                        // height: MediaQuery.of(context).size.height / 7.1,
                                        height: 100,
                                        padding: const EdgeInsets.only(
                                            left: 6.0, right: 6.0, top: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 28,
                                              width: 36,
                                              child: Text(
                                                user.departure_time,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Divider(
                                              height: 2,
                                              color: Colors.black,
                                            ),
                                            Container(
                                              height: 29,
                                              width: 36,
                                              child: Text(
                                                user.arrival_time,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ]);
                            }).toList(),
                            border:
                                TableBorder.all(width: 1, color: Colors.blue),
                          ),
                          ////////////
                          Container(
                              margin:
                                  EdgeInsets.only(left: 0, bottom: 0, top: 30),
                              alignment: Alignment.centerLeft,
                              child: Text("Details of Transient",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18))),
                          Divider(height: 10, color: Colors.black),
                          Column(
                            key: dataKey,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              UserSetText("Pilot"),
                              Add_TextField(
                                  hint: "Pilot",
                                  callback: edt_pilot,
                                  width: double.infinity),
                              UserSetText("A/ct"),
                              Row(
                                children: [
                                  Add_TextField(
                                    hint: "Aircrafts",
                                    callback: edt_aircraft,
                                    width: MediaQuery.of(context).size.width *
                                        0.84,
                                  ),
                                  SizedBox(width: 4),
                                  Add_TextField(
                                    hint: "P",
                                    callback: edt_status,
                                    width: 35,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  UserSetText("R.Dt"),
                                  SizedBox(width: 4),
                                  Add_TextField(
                                    hint: "Pilot",
                                    callback: edt_RDt,
                                    width: MediaQuery.of(context).size.width *
                                        0.50,
                                  ),
                                ],
                              ),
                              SizedBox(width: 3),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  UserSetText("Rrr.Dt"),
                                  SizedBox(width: 3),
                                  Add_TextField(
                                    hint: "Aircrafts",
                                    callback: edt_dDt,
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                  ),
                                ],
                              ),
                              SizedBox(width: 3),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  UserSetText("D.Dt"),
                                  SizedBox(width: 3),
                                  Add_TextField(
                                    hint: "D Dt",
                                    callback: edt_dDt,
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    UserSetText("Service"),
                                    Container(
                                      height: 35,
                                      width: 51,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.5)),
                                        child: TextField(
                                          controller: edt_services,
                                          decoration: InputDecoration(
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.blue,
                                                  width: 1.0),
                                            ),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20, 4, 2, 2),
                                            border: OutlineInputBorder(),
                                            hintText: "S",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 2),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    UserSetText("Fuel "),
                                    Container(
                                      height: 35,
                                      width: 45,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.5)),
                                        child: TextField(
                                          controller: edt_is_fuel,
                                          decoration: InputDecoration(
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.blue,
                                                  width: 1.0),
                                            ),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                18, 4, 2, 2),
                                            border: OutlineInputBorder(),
                                            hintText: "F",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 3),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    UserSetText("App Edit Activity log"),
                                    Add_TextField(
                                        hint: "App Edit Activity log",
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.38)
                                  ],
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      UserSetText(""),
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              border: Border.all(
                                                  color: Colors.white)),
                                          height: 35,
                                          child: MaterialButton(
                                              onPressed: () {
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             FBO_Tenant_Schedule_Tab()));

                                                Future.delayed(
                                                    const Duration(seconds: 1),
                                                    () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UpdateSchedule(
                                                                  editReservation
                                                                      .id)));
                                                });
                                              },
                                              child: Text("Schedule",
                                                  style: TextStyle(
                                                      color: Colors.white))))
                                    ])
                              ])
                        ])))));
  }

  setTransient(Pilot pilot) {
    setState(() {
      edt_pilot.text = pilot.buildingName;
      edt_aircraft.text = pilot.aircraft;
      edt_arrDt.text = pilot.arrivalDt;
      edt_RDt.text = pilot.teTr;
      edt_services.text = pilot.services;
      edt_iata.text = pilot.iata;
      edt_is_fuel.text = pilot.isFuel;
      edt_status.text = pilot.status.characters.first;
      edt_dDt.text = pilot.departureDt.toString();
    });
  }

  getdata(String id) async {
    // var pp=Provider.of<TenantScheduleProvider>(context,listen: false);
    // final prefs = await SharedPreferences.getInstance();
    // String id = await prefs.getString('userid');

    // var map = {
    //   "id": id,
    // };

    print(id);

    String url =
        'http://wordpresswebsiteprogrammer.com/stackit/public/api/get-reservation-details?id=$id';
    var response = await http.get(Uri.parse(url));
    print(response.body.toString());
    pilot = Pilot.fromMap(json.decode(response.body));
    setTransient(pilot);
  }

  Pilot pilot;
  EditReservation editReservation;
  Future EditReservationss() async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    var url = Uri.parse(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/edit-reservation?id=$selectedid");
    var response = await http.get(
      url,
    );
    print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body);

    editReservation = EditReservation.fromMap(json.decode(response.body));
    setProviderData();
    // if (success == "1") {
    //   print(response.statusCode);
    //   print('done');
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       backgroundColor: Colors.green,
    //       duration: Duration(seconds: 2),
    //       behavior: SnackBarBehavior.floating,
    //       width: MediaQuery.of(context).size.width * 0.90,
    //       content: Text(data["message"])));
    // } else {
    //   print("Sorry we have an error");
    //   print(response.statusCode);
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       backgroundColor: Colors.red,
    //       duration: Duration(seconds: 2),
    //       behavior: SnackBarBehavior.floating,
    //       width: MediaQuery.of(context).size.width * 0.90,
    //       content: Text(data["message"])));
    //}
  }

  void setProviderData() {
    Provider.of<FBO_TenantScheduleProvider>(context, listen: false).getTenant();

    Provider.of<FBO_TenantScheduleProvider>(context, listen: false)
        .onchange("Pid", editReservation.pilotId.toString());
    Provider.of<FBO_TenantScheduleProvider>(context, listen: false)
        .onchange("Tid", editReservation.tenantId.toString());
    Provider.of<FBO_TenantScheduleProvider>(context, listen: false)
        .onchange("Aid", editReservation.aircraftId.toString());
    Provider.of<FBO_TenantScheduleProvider>(context, listen: false)
        .onchange("Bid", editReservation.buildingId.toString());

    Provider.of<FBO_TenantScheduleProvider>(context, listen: false)
        .onchange("Adate", editReservation.arrivalDate);
    Provider.of<FBO_TenantScheduleProvider>(context, listen: false)
        .onchange("Atime", editReservation.arrivalTime);

    Provider.of<FBO_TenantScheduleProvider>(context, listen: false).changename(
      pilot.pilotName.toString(),
      pilot.aircraft,
      pilot.buildingName,
      pilot.iata,
      pilot.status,
    );
  }
}

class ServicesFbo {
  //for fetching a list of notes from server
  Future getDataFbo() async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    var url = Uri.parse(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/reservations?id=$id");
    var data = await http.get(url);
    if (data.statusCode == 200) {
      final jsonData = json.decode(data.body);
      print(data.body.toString());
      List usersList = [];
      for (var user in jsonData) {
        DataModel model = DataModel(
          id: user['id'],
          arrival_time: user['arrival_time'].toString(),
          iata: user['iata'].toString(),
          te_tr: user['te_tr'].toString(),
          building_name: user['building_name'].toString(),
          ramp_time: user['ramp_time'].toString(),
          departure_time: user['departure_time'].toString(),
        );
        usersList.add(model);
      }
      print("Lenth");

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
  final String te_tr;
  final String departure_time;
  final String ramp_time;
  final String iata;
  final String building_name;
  final String arrival_time;
  DataModel(
      {this.id,
      this.building_name,
      this.te_tr,
      this.iata,
      this.departure_time,
      this.ramp_time,
      this.arrival_time});
}

class Pilot {
  Pilot({
    @required this.id,
    @required this.pilotName,
    @required this.aircraft,
    @required this.status,
    @required this.services,
    @required this.isFuel,
    @required this.teTr,
    @required this.iata,
    @required this.buildingName,
    @required this.departureDt,
    @required this.arrivalDt,
    @required this.rampDt,
  });

  int id;
  dynamic pilotName;
  String aircraft;
  String status;
  String services;
  String isFuel;
  String teTr;
  String iata;
  String buildingName;
  DateTime departureDt;
  String arrivalDt;
  dynamic rampDt;

  factory Pilot.fromMap(Map<String, dynamic> json) => Pilot(
        id: json["id"],
        pilotName: json["pilot_name"],
        aircraft: json["aircraft"],
        status: json["status"],
        services: json["services"],
        isFuel: json["is_fuel"],
        teTr: json["te_tr"],
        iata: json["iata"],
        buildingName: json["building_name"],
        departureDt: DateTime.now(), // DateTime.parse(json["departure_dt"]),
        arrivalDt: json["arrival_dt"],
        rampDt: json["ramp_dt"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "pilot_name": pilotName,
        "aircraft": aircraft,
        "status": status,
        "services": services,
        "is_fuel": isFuel,
        "te_tr": teTr,
        "iata": iata,
        "building_name": buildingName,
        "departure_dt": departureDt.toIso8601String(),
        "arrival_dt": arrivalDt,
        "ramp_dt": rampDt,
      };
}

// To parse this JSON data, do
//
//     final editReservation = editReservationFromMap(jsonString);

EditReservation editReservationFromMap(String str) =>
    EditReservation.fromMap(json.decode(str));

String editReservationToMap(EditReservation data) => json.encode(data.toMap());

class EditReservation {
  EditReservation({
    @required this.id,
    @required this.scheduleType,
    @required this.tenantId,
    @required this.pilotId,
    @required this.aircraftId,
    @required this.buildingId,
    @required this.isFuel,
    @required this.arrivalDate,
    @required this.arrivalTime,
  });

  int id;
  String scheduleType;
  String tenantId;
  String pilotId;
  String aircraftId;
  String buildingId;
  String isFuel;
  String arrivalDate;
  String arrivalTime;

  factory EditReservation.fromMap(Map<String, dynamic> json) => EditReservation(
        id: json["id"],
        scheduleType: json["schedule_type"],
        tenantId: json["tenant_id"],
        pilotId: json["pilot_id"],
        aircraftId: json["aircraft_id"],
        buildingId: json["building_id"],
        isFuel: json["is_fuel"],
        arrivalDate: json["arrival_date"],
        arrivalTime: json["arrival_time"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "schedule_type": scheduleType,
        "tenant_id": tenantId,
        "pilot_id": pilotId,
        "aircraft_id": aircraftId,
        "building_id": buildingId,
        "is_fuel": isFuel,
        "arrival_date": arrivalDate,
        "arrival_time": arrivalTime,
      };
}
