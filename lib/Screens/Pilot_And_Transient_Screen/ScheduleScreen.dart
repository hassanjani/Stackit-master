import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/Pilot_And_Transient_Screen/Pilot_Tenant_Schedule_tab.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/Tenant_Dropdown/TransientDB/DB_Pilot2.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/tabbar_screen/Transient_schedule_tab_Pilot.dart';
import 'UserSettingsScreen.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/tabbar_screen/Tenant_schedule_tab.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/tabbar_screen/Transient_schedule_tab.dart';

class PTransient_ScheduleScreen extends StatefulWidget {
  @override
  _PTransient_ScheduleScreenState createState() =>
      _PTransient_ScheduleScreenState();
}

// ignore: camel_case_types
class _PTransient_ScheduleScreenState extends State<PTransient_ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70,
          leadingWidth: 0,
          leading: Text(""),
          title: SafeArea(
            child: Column(
              children: [
                Container(
                  height: 90,
                  decoration: BoxDecoration(),
                  alignment: Alignment.center,
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
                                            PT_UserSettings()));
                              },
                              child: Icon(Icons.person_rounded,
                                  color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 14),
                      Column(
                        children: [
                          Text(
                            "Pilot SCHEDULE",
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
          bottom: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.white,
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              automaticIndicatorColorAdjustment: true,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.white),
              tabs: [
                Tab(
                  height: 36,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Tenant Schedule"),
                  ),
                ),
                Tab(
                  height: 36,
                  // text: "Transient Schedule",
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Transient Schedule"),
                  ),
                ),
              ]),
        ),
        // appBar: AppBar(
        //   backgroundColor: Colors.blue,
        //   foregroundColor: Colors.white,
        //   toolbarHeight: 70,
        //   shadowColor: Colors.white,
        //   leadingWidth: 1,
        //   leading: Text(""),
        //   elevation: 0,
        //   title: Column(
        //     children: [
        //       SizedBox(height: 10),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           InkWell(
        //               onTap: () => Scaffold.of(context).openDrawer(),
        //               child: Icon(Icons.list, color: Colors.white)),
        //           InkWell(
        //               onTap: () {
        //                 Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) => PT_UserSettings()));
        //               },
        //               child: Icon(Icons.person_rounded, color: Colors.white)),
        //         ],
        //       ),
        //       SizedBox(height: 10),
        //       Text(
        //         "PILOT SCHEDULE",
        //         style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 18,
        //             fontWeight: FontWeight.bold),
        //       ),
        //     ],
        //   ),
        //   bottom: TabBar(
        //       labelColor: Colors.black,
        //       indicatorColor: Colors.white,
        //       unselectedLabelColor: Colors.white,
        //       indicatorSize: TabBarIndicatorSize.label,
        //       automaticIndicatorColorAdjustment: true,
        //       indicator: BoxDecoration(
        //           borderRadius: BorderRadius.only(
        //               topLeft: Radius.circular(10),
        //               topRight: Radius.circular(10)),
        //           color: Colors.white),
        //       tabs: [
        //         Tab(
        //           height: 36,
        //           child: Align(
        //             alignment: Alignment.center,
        //             child: Text("Tenant Schedule"),
        //           ),
        //         ),
        //         Tab(
        //           height: 36,
        //           // text: "Transient Schedule",
        //           child: Align(
        //             alignment: Alignment.center,
        //             child: Text("Transient Schedule"),
        //           ),
        //         ),
        //       ]),
        // ),
        body: TabBarView(
          children: [
            Pilot_Tenant_Schedule_Tab(),
            Transient_Schedule_Tab2(),
          ],
        ),
      ),
    );
  }
}
