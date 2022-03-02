import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/FBOScreen/UserSettingsScreen.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/tabbar_screen/Tenant_schedule_tab.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/tabbar_screen/Transient_schedule_tab.dart';

import 'FBO_Tenant_Schedule_tab.dart';

class FBO_ScheduleScreen extends StatefulWidget {
  @override
  _FBO_ScheduleScreenState createState() => _FBO_ScheduleScreenState();
}

class _FBO_ScheduleScreenState extends State<FBO_ScheduleScreen> {
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
                                            FBO_UserSettings()));
                              },
                              child: Icon(Icons.person_rounded,
                                  color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 14),
                      Column(
                        children: [
                          Text(
                            "FBO SCHEDULE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
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
                        child: Text("Tenant Schedule"))),
                Tab(
                    height: 36,
                    // text: "Transient Schedule",
                    child: Align(
                        alignment: Alignment.center,
                        child: Text("Transient Schedule")))
              ]),
        ),
        body: TabBarView(
          children: [
            FBO_Tenant_Schedule_Tab(),
            Transient_Schedule_Tab(),
          ],
        ),
      ),
    );
  }
}
