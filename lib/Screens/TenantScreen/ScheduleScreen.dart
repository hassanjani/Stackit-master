import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/tabbar_screen/Tenant_schedule_tab.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/tabbar_screen/Transient_schedule_tab.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/tabbar_screen/Transient_schedule_tab_Pilot.dart';

import 'TenantUserSetting_Screen.dart';

class Tenant_ScheduleScreen extends StatefulWidget {
  @override
  _Tenant_ScheduleScreenState createState() => _Tenant_ScheduleScreenState();
}

class _Tenant_ScheduleScreenState extends State<Tenant_ScheduleScreen> {
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
                                            Tenant_UserSettings()));
                              },
                              child: Icon(Icons.person_rounded,
                                  color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 14),
                      Column(
                        children: [
                          Text(
                            "TE/TR SCHEDULE",
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
        // Text(
        //   "TE/TR SCHEDULE",
        //   style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold),
        // ),

        body: TabBarView(
          children: [
            Tenant_Schedule_Tab(),
            Transient_Schedule_Tab(),
          ],
        ),
      ),
    );
  }
}
