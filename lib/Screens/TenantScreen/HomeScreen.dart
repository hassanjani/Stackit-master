import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/AddPilot.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/Tenant_Table.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TenantUserSetting_Screen.dart';
import 'package:flutter_forget_pass_recover_with_verify/Services/tenant_home_get.dart';
import 'package:flutter_forget_pass_recover_with_verify/Widgets/Component/internetError.dart';

class Tenant_HomeScreen extends StatefulWidget {
  final int selectedTypeId;
  final int id;
  const Tenant_HomeScreen({Key key, this.selectedTypeId, this.id})
      : super(key: key);

  @override
  _Tenant_HomeScreenState createState() => _Tenant_HomeScreenState();
}

class _Tenant_HomeScreenState extends State<Tenant_HomeScreen> {
  tenant_home_Get postService = tenant_home_Get();
  // List<String> list1 = ['Tenant', 'B', 'C', 'D']; // Option 2
  // List<String> list2 = ['Arival', 'Time', 'Date', 'Years']; // Option 2
  String _selectedLocation, select2;

  @override
  void initState() {
    super.initState();
    tenant_home_Get();
    print(postService);
    storeIdInSharedPreference();
    // getSharedPref();
  }

  storeIdInSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        leadingWidth: 0,
        leading: Text(""),
        title: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(),
                alignment: Alignment.center,
                height: 120,
                // height: MediaQuery.of(context).size.height * 0.20,
                child: Column(
                  children: [
                    // SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () => Scaffold.of(context).openDrawer(),
                            child: Icon(Icons.list, color: Colors.white)),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Tenant_UserSettings()));
                            },
                            child: Icon(Icons.person_rounded,
                                color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 14),
                    Column(
                      children: [
                        InkWell(
                          child: Text(
                            "TENANT ACTIVITY",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Tenant_Table_Screen()));
                          },
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Container(
                    //         height: 30,
                    //         width: MediaQuery.of(context).size.width * 0.40,
                    //         padding: EdgeInsets.only(left: 12),
                    //         decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           shape: BoxShape.rectangle,
                    //           borderRadius: BorderRadius.horizontal(
                    //             left: Radius.circular(30),
                    //             right: Radius.circular(30),
                    //           ),
                    //         ),
                    //         child: DropdownButtonHideUnderline(
                    //           child: DropdownButton(
                    //             hint: Text(
                    //               "Choose",
                    //               textAlign: TextAlign.center,
                    //               style: TextStyle(
                    //                 fontSize: 12,
                    //               ),
                    //             ), // Not necessary for Option 1
                    //             value: _selectedLocation,
                    //             onChanged: (newValue) {
                    //               setState(() {
                    //                 _selectedLocation = newValue;
                    //               });
                    //             },
                    //             items: list1.map((location) {
                    //               return DropdownMenuItem(
                    //                 child: new Text(location),
                    //                 value: location,
                    //               );
                    //             }).toList(),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Container(
                    //         height: 30,
                    //         width: MediaQuery.of(context).size.width * 0.40,
                    //         padding: EdgeInsets.only(left: 12),
                    //         decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           shape: BoxShape.rectangle,
                    //           borderRadius: BorderRadius.horizontal(
                    //             left: Radius.circular(30),
                    //             right: Radius.circular(30),
                    //           ),
                    //         ),
                    //         child: DropdownButtonHideUnderline(
                    //           child: DropdownButton(
                    //             hint: Text(
                    //               'choose',
                    //               style: TextStyle(
                    //                 fontSize: 12,
                    //               ),
                    //             ), // Not necessary for Option 1
                    //             value: select2,
                    //             onChanged: (newValue) {
                    //               setState(() {
                    //                 select2 = newValue;
                    //               });
                    //             },
                    //             items: list2.map((location) {
                    //               return DropdownMenuItem(
                    //                 child: new Text(location),
                    //                 value: location,
                    //               );
                    //             }).toList(),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder<List>(
            future: postService.getAllPost(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                print('Ok Data Home Screen Page');
                print(snapshot.data);
                return ListView.builder(
                    itemCount: snapshot == null ? 0 : snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            margin:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
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
                            alignment: Alignment.center,
                            child: ExpandablePanel(
                              header: ListTile(
                                leading: CircleAvatar(
                                  maxRadius: 24,
                                  backgroundColor: Color(
                                          (math.Random().nextDouble() *
                                                  0xFFFFFF)
                                              .toInt())
                                      .withOpacity(1.0),
                                  child: Text(
                                      snapshot.data[index]['pilot_name'] == null
                                          ? "E"
                                          : snapshot.data[index]['pilot_name']
                                              .toString()
                                              .split("")[0][0]
                                              .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.center),
                                ),
                                dense: false,
                                title: Row(
                                  children: [
                                    Text(snapshot.data[index]['pilot_name'] ==
                                            null
                                        ? "empty"
                                        : snapshot.data[index]['pilot_name']
                                            .toString()),
                                  ],
                                ),
                                subtitle: Text(snapshot.data[index]
                                        ['building_name']
                                    .toString()),
                              ),
                              collapsed: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Tenant_AddPilot()));
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/Group.png",
                                            height: 40,
                                            width: 30,
                                          ),
                                          Container(
                                            height: 30,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            child: Text(
                                                snapshot.data[index]
                                                        ['building_name']
                                                    .toString(),
                                                textAlign: TextAlign.center),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/departures.png",
                                          height: 40,
                                          width: 45,
                                        ),
                                        Container(
                                          height: 30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          child: Text(
                                              snapshot.data[index]
                                                      ['departure_time']
                                                  .toString(),
                                              textAlign: TextAlign.center),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/arrival-time.png",
                                          height: 40,
                                          width: 30,
                                        ),
                                        Container(
                                          height: 30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          child: Text(
                                              snapshot.data[index]
                                                      ['arrival_time']
                                                  .toString(),
                                              textAlign: TextAlign.center),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              expanded: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              "assets/images/Group.png",
                                              height: 40,
                                              width: 30,
                                            ),
                                            Container(
                                              height: 30,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              child: Text(
                                                  snapshot.data[index]
                                                          ['building_name']
                                                      .toString(),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Image.asset(
                                              "assets/images/departures.png",
                                              height: 40,
                                              width: 45,
                                            ),
                                            Container(
                                              height: 30,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              child: Text(
                                                  snapshot.data[index]
                                                          ['departure_time']
                                                      .toString(),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Image.asset(
                                              "assets/images/arrival-time.png",
                                              height: 40,
                                              width: 30,
                                            ),
                                            Container(
                                              height: 30,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              child: Text(
                                                  snapshot.data[index]
                                                          ['arrival_time']
                                                      .toString(),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              "assets/images/small-plane.png",
                                              height: 35,
                                              width: 35,
                                            ),
                                            Container(
                                              height: 32,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              child: Text(
                                                  snapshot.data[index]
                                                          ['aircraft']
                                                      .toString(),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Image.asset(
                                              "assets/images/TE-TR.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            Container(
                                              height: 30,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              child: Text(
                                                  snapshot.data[index]['te_tr']
                                                      .toString(),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Image.asset(
                                              "assets/images/Group1.png",
                                              height: 40,
                                              width: 30,
                                            ),
                                            Container(
                                              height: 30,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              child: Text(
                                                  snapshot.data[index]
                                                          ['receive_services']
                                                      .toString(),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              "assets/images/IATA.png",
                                              height: 40,
                                              width: 35,
                                            ),
                                            Container(
                                              height: 30,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              child: Text(
                                                  snapshot.data[index]['iata']
                                                      .toString(),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              tapHeaderToExpand: true,
                              iconColor: Colors.blue,
                              hasIcon: true,
                            ),
                          ),
                          // Widget to display the list of project
                        ],
                      );
                    });
              } else if (snapshot.hasError) {
                return InternetError();
              } else {
                return Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              }
            }),
      ),
      // ),
    );
  }
}
