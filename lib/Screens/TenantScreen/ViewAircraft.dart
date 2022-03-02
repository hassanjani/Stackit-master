import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Models/profile/Add_TextField.dart';
import 'package:flutter_forget_pass_recover_with_verify/Models/profile/home_model.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/Pilot_And_Transient_Screen/component/component.dart';
import 'package:flutter_forget_pass_recover_with_verify/Services/post.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/Component/simpleText.dart';

class Tenant_ViewAircrafts extends StatefulWidget {
  @override
  State<Tenant_ViewAircrafts> createState() => _Tenant_ViewAircraftsState();
}

class _Tenant_ViewAircraftsState extends State<Tenant_ViewAircrafts> {
  String _mySelection;
  String _mySelection2;

  final String url =
      "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-pilots-list?tenant_id=13";

  List dataa = List(); //edited line

  Future<String> getSWData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      dataa = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  ////////////////////////////////////////////////////////
  String Reg, Type, Home;
  TextEditingController edtReg = TextEditingController();
  TextEditingController edtType = TextEditingController();
  TextEditingController edtHome = TextEditingController();
  String id;
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
    selectHome();
    this.getSWData();
  }

  final dataKey = new GlobalKey();

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
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          "View Aircraft",
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
                                    color: Colors.blue,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                                children: [
                                  TableRow(children: [
                                    tableHeader("A/c Registry"),
                                    tableHeader("A/c Types"),
                                    tableHeader("Home"),
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
                                      edtReg.text = user.registry;
                                      edtType.text = user.type;
                                      edtHome.text = user.home;
                                      Scrollable.ensureVisible(
                                          dataKey.currentContext);
                                    });
                                  },
                                  child: Container(
                                      height: 60,
                                      padding: EdgeInsets.all(12),
                                      child: Text(user.registry)),
                                ),
                                Container(
                                    height: 60,
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      user.type,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                    )),
                                Container(
                                    height: 60,
                                    padding: EdgeInsets.only(
                                        top: 5, left: 6, right: 6),
                                    child: Text(
                                      user.home,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                    ))
                              ]);
                        }).toList(),
                        border: TableBorder.all(color: Colors.blue, width: 1.0),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5, top: 20),
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.black)),
                        child: Text(
                          "Add/Edit Aircraft",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Divider(height: 4, color: Colors.black),
                      SizedBox(height: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ViewAircrafts("A/C Register"),
                            Add_TextField(
                                hint: "A/c Register",
                                callback: edtReg,
                                onChange: (String val) {
                                  Reg = val;
                                })
                          ]),
                      // SizedBox(height: 10),
                      Column(
                        key: dataKey,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ViewAircrafts("A/C Type    "),
                          SizedBox(height: 4),
                          Add_TextField(
                            hint: "A/c Type",
                            callback: edtType,
                            onChange: (String val) {
                              Type = val;
                            },
                          ),
                        ],
                      ),
                      // SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ViewAircrafts("Select Home"),
                          Container(
                            height: 37,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.blue, width: 1.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text(
                                      'Choose Option'), // Not necessary for Option 1
                                  value: selectedName,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedName = newValue;
                                      // Provider.of<TenantScheduleProvider>(
                                      //         context,
                                      //         listen: false)
                                      //     .onchange("Tid", newValue);
                                    });
                                  },
                                  items: data.map((value) {
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
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.blue, width: 1.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Tags(
                                          itemCount: tags.length,
                                          itemBuilder: (int index) {
                                            return Tooltip(
                                                message:
                                                    tags[index].id.toString(),
                                                child: ItemTags(
                                                  index: index,
                                                  title: tags[index]
                                                      .name
                                                      .toString(),
                                                  activeColor:
                                                      Colors.blueAccent,
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 5,
                                                      bottom: 5),
                                                  removeButton:
                                                      ItemTagsRemoveButton(
                                                    onRemoved: () {
                                                      // Remove the item from the data source.
                                                      setState(() {
                                                        // required
                                                        tags.removeAt(index);
                                                      });
                                                      //required
                                                      return true;
                                                    },
                                                  ), // OR null,
                                                  onPressed: (item) =>
                                                      print(item),
                                                ));
                                          },
                                        ),
                                      ),
                                      DropdownButton(
                                        hint: Text("Add Tags"),
                                        iconDisabledColor: Colors.white,
                                        iconEnabledColor: Colors.white,
                                        items: dataa.map((item) {
                                          return new DropdownMenuItem(
                                            child: new Text(
                                                item['name'].toString()),
                                            value: item,
                                          );
                                        }).toList(),
                                        onChanged: (newVal) {
                                          setState(() {
                                            // _mySelection2 = newVal;
                                            tags.add(pilotm(
                                                newVal['id'], newVal['name']));
                                          });
                                        },
                                        value: _mySelection2,
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(12),
                            width: 90,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue.shade500,
                                border: Border.all(color: Colors.white)),
                            child: TextButton(
                              onPressed: () async {
                                String pid = "";
                                tags.forEach((element) {
                                  pid = pid + element.id.toString() + ",";
                                });
                                final result = await Get().Add_Aircraft(
                                  context,
                                  Reg.toString(),
                                  Type.toString(),
                                  selectedName.toString(),
                                  pid,
                                );
                                // if (result != null) {
                                //   Navigator.push(context,
                                //       MaterialPageRoute(builder: (context) {
                                //     return Tenant_ViewAircrafts();
                                //   }));
                                // }
                              },
                              child: Text(
                                "Add",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(12),
                            width: 90,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                border: Border.all(color: Colors.white)),
                            child: TextButton(
                              onPressed: () async {
                                String pid = "";
                                tags.forEach((element) {
                                  pid = pid + element.id.toString() + ",";
                                });

                                await UpdateAircraft(
                                    id,
                                    edtReg.text.toString(),
                                    edtType.text.toString(),
                                    selectedName.toString(),
                                    pid);
                                // if (result != null) {
                                //   Navigator.push(context,
                                //       MaterialPageRoute(builder: (context) {
                                //     return Tenant_ViewAircrafts();
                                //   }));
                                // }
                              },
                              child: Text(
                                "Update",
                                style: TextStyle(color: Colors.white),
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

  List<pilotm> tags = [];
  String selectedName;
  List data = List();

  Future selectHome() async {
    final prefs = await SharedPreferences.getInstance();
    String tid = await prefs.getString('userid');
    var response = await http.get(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-buildings-list?tenant_id=$tid",
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
  //////////////////////////////////////////////

  Future UpdateAircraft(
      String id, String reg, String type, String home, String pilotids) async {
    final prefs = await SharedPreferences.getInstance();
    String tid = await prefs.getString('userid');
    var AddEdit_Aircraft = Uri.parse(
        'http://wordpresswebsiteprogrammer.com/stackit/public/api/update-aircraft?tenant_id=$id&pilot_id=$id');

    print('working');
    print("$tid");

    print('inside try');
    http.Response response = await http.post(AddEdit_Aircraft, body: {
      "id": id,
      'pilot_id': pilotids,
      "tenant_id": tid,
      "registry": reg,
      "type": type,
      "home_id": home,
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
      setState(() {
        getDataAgain();
      });
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

class pilotm {
  int id;
  String name;
  pilotm(this.id, this.name);
}
