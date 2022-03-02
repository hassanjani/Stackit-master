import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Services/post.dart';
import 'package:flutter_forget_pass_recover_with_verify/Widgets/Component/internetError.dart';
import 'ScheduleScreen.dart';
import 'UserSettingsScreen.dart';

class Pilot_A_Transient_Table_Activity extends StatefulWidget {
  const Pilot_A_Transient_Table_Activity({Key key}) : super(key: key);

  @override
  _Pilot_A_Transient_Table_ActivityState createState() =>
      _Pilot_A_Transient_Table_ActivityState();
}

class _Pilot_A_Transient_Table_ActivityState
    extends State<Pilot_A_Transient_Table_Activity> {
  var orientation, size, height, width;
  Get postService = Get();
  List<String> list1 = ['Tenant/Tr']; //'B', 'C', 'D']; // Option 2
  List<String> list2 = ['Arrival']; // 'Time', 'Date', 'Years']; // Option 2
  String _selectedLocation, select2;

  @override
  void initState() {
    super.initState();
    Get();
    print(postService);
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.height * 0.98;
    orientation = MediaQuery.of(context).orientation;
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
                                      builder: (context) => PT_UserSettings()));
                            },
                            child: Icon(Icons.person_rounded,
                                color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 14),
                    Column(
                      children: [
                        Text(
                          "PILOT ACTIVITY",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
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
      body: Column(
        children: [
          Container(
            height: 40,
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 15,
                  margin: EdgeInsets.only(bottom: 2),
                  alignment: Alignment.center,
                  child: Text(
                    '',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11.0),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.21,
                  height: 15,
                  margin: EdgeInsets.only(bottom: 2),
                  alignment: Alignment.center,
                  child: Text(
                    'Pilot Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11.0),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.23,
                  height: 15,
                  margin: EdgeInsets.only(bottom: 2),
                  alignment: Alignment.center,
                  child: Text(
                    'Reg No',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11.0),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.19,
                  height: 24,
                  alignment: Alignment.center,
                  child: Text(
                    'Departure Time',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11.0),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.14,
                  height: 24,
                  margin: EdgeInsets.only(bottom: 2),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Arrival Time',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.17,
                  height: 24,
                  margin: EdgeInsets.only(bottom: 2),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Receive Services',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 11.0),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.73,
              width: MediaQuery.of(context).size.width * 0.99,
              child: FutureBuilder<List>(
                  future: postService.getAllPost(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      print('Ok Tenant Screen Page');
                      print(snapshot.data);
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ExpansionTile(
                              expandedAlignment: Alignment.center,
                              backgroundColor: Colors.grey[100],
                              // collapsedTextColor: Colors.black,
                              initiallyExpanded: false,
                              trailing: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.09,
                                    height: 50,
                                    margin: EdgeInsets.only(top: 4),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Text(
                                      snapshot.data[index]['receive_services'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 11.0, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          height: 50,
                                          width: 20,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.blue.shade500,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4),
                                                bottomLeft: Radius.circular(4),
                                              ),
                                              border: Border.all(
                                                  color: Colors.blue.shade500)),
                                          child: Icon(Icons.arrow_drop_down,
                                              color: Colors.white)),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.20,
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.blue),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4),
                                            )),
                                        child: Text(
                                          snapshot.data[index]['pilot_name'] ==
                                                  null
                                              ? "Empty"
                                              : snapshot.data[index]
                                                      ['pilot_name']
                                                  .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.20,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Text(
                                      snapshot.data[index]['building_name'] ==
                                              null
                                          ? "Empty"
                                          : snapshot.data[index]
                                                  ['building_name']
                                              .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.17,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Text(
                                      // snapshot.data[index]['departure_time'],
                                      snapshot.data[index]['departure_time'] ==
                                              null
                                          ? "Empty"
                                          : snapshot.data[index]
                                                  ['departure_time']
                                              .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 11.0, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.16,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Text(
                                      // snapshot.data[index]['arrival_time'],
                                      snapshot.data[index]['arrival_time'] ==
                                              null
                                          ? "Empty"
                                          : snapshot.data[index]['arrival_time']
                                              .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 11.0, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              tilePadding: EdgeInsets.only(bottom: -20),

                              children: [
                                ListTile(
                                    title: Column(children: [
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.30,
                                        height: 15,
                                        margin: EdgeInsets.only(bottom: 2),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Aircraft',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 11.0),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.10,
                                        height: 15,
                                        margin: EdgeInsets.only(bottom: 2),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'TE/TR',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 11.0),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.12,
                                        height: 15,
                                        margin: EdgeInsets.only(bottom: 2),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'IATA',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 11.0),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        height: 15,
                                        margin: EdgeInsets.only(bottom: 2),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Ramp Tm',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 11),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        height: 15,
                                        margin: EdgeInsets.only(bottom: 2),
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'Building',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 11.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.27,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blue),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                            // snapshot.data[index]['aircraft']
                                            //     .toString(),
                                            snapshot.data[index]['aircraft'] ==
                                                    null
                                                ? "Empty"
                                                : snapshot.data[index]
                                                        ['aircraft']
                                                    .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 11.0),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.10,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blue),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                            // snapshot.data[index]['te_tr']
                                            snapshot.data[index]['te_tr'] ==
                                                    null
                                                ? "Empty"
                                                : snapshot.data[index]['te_tr']
                                                    .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 11.0),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.12,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blue),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                            // snapshot.data[index]['iata']
                                            //     .toString(),
                                            snapshot.data[index]['iata'] == null
                                                ? "Empty"
                                                : snapshot.data[index]['iata']
                                                    .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 11.0),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.18,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blue),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                            // snapshot.data[index]['ramp_time']
                                            //     .toString(),
                                            snapshot.data[index]['ramp_time'] ==
                                                    null
                                                ? "Empty"
                                                : snapshot.data[index]
                                                        ['ramp_time']
                                                    .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 11.0),
                                          ),
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.18,
                                            height: 50,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue),
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Text(
                                                // snapshot.data[index]
                                                //         ['building_name']
                                                //     .toString(),
                                                snapshot.data[index]
                                                            ['building_name'] ==
                                                        null
                                                    ? "Empty"
                                                    : snapshot.data[index]
                                                            ['building_name']
                                                        .toString(),
                                                textAlign: TextAlign.center,
                                                style:
                                                    TextStyle(fontSize: 11.0)))
                                      ])
                                ]))
                              ],
                              // Divider(color: Colors.black),
                              // Widget to display the list of projec
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
