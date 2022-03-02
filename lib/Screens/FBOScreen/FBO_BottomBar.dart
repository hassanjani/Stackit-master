import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/AuthScreen/LoginScreen.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/FBOScreen/Activity_Screen.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/FBOScreen/AddPilot.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/FBOScreen/Add_Tenant_Screen.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/FBOScreen/Dashboard/Dashboard_Screen.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/Pilot_And_Transient_Screen/BottombarPilot&Transient.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/ViewAircraft.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ScheduleScreen.dart';
import 'TenantsScreen.dart';

class FBO_Bottombar extends StatefulWidget {
  final int selectedTypeId;

  const FBO_Bottombar({Key key, this.selectedTypeId}) : super(key: key);
  @override
  _FBO_BottombarState createState() => _FBO_BottombarState();
}

class _FBO_BottombarState extends State<FBO_Bottombar> {
  storeIdInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedTypeUid', this.widget.selectedTypeId);
    print('Id stored in local DB');
    print(prefs.getInt('selectedTypeUid'));
  }

  @override
  void initState() {
    super.initState();
    storeIdInSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Container(
            width: MediaQuery.of(context).size.width * 0.60,
            child: Drawer(
                child: ListView(
              children: <Widget>[
                createDrawerHeader(),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Tenant_ViewAircrafts();
                    }));
                  },
                  title: Text("View Aircrafts"),
                ),
                Divider(height: 4, color: Colors.black),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Add_Tenant_Screen();
                      // SharedPreferences prefs =
                      //     await SharedPreferences.getInstance();
                      // prefs.remove("selectedTypeUid");
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return LoginScreen();
                    }));
                  },
                  title: Text("Add Tenants"),
                ),
                Divider(height: 4, color: Colors.black),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FBO_AddPilot();
                    }));
                  },
                  title: Text("Add Pilot"),
                ),
                Divider(height: 4, color: Colors.black),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Dashboard_Screen();
                    }));
                  },
                  title: Text("Dashboard"),
                ),
                Divider(height: 4, color: Colors.black),
                ListTile(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove("selectedTypeUid");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  },
                  title: Text("Logout"),
                ),
              ],
            ))),
        bottomNavigationBar: menu(),
        body: TabBarView(
          children: [
            Activity_Screen(),
            FBO_ScheduleScreen(),
            FBO_Tenant_Screen(),
          ],
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1),
      color: Colors.white,
      child: TabBar(
        labelPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
        labelColor: Colors.black,
        indicator: BoxDecoration(
            color: Colors.blueGrey.shade300,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue, width: 0)),
        unselectedLabelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.white,
        tabs: [
          Tab(
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12,
                ),
                child: Center(
                    child: Text(
                  "Activity",
                  style: TextStyle(fontSize: 16),
                ))),
          ),
          Tab(
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12,
                ),
                child: Center(
                    child: Text(
                  "Arrival/Ramping",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ))),
          ),
          Tab(
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12,
                ),
                child: Center(
                    child: Text(
                  "Tenants",
                  style: TextStyle(fontSize: 16),
                ))),
          ),
        ],
      ),
    );
  }
}

Widget createDrawerHeader() {
  return Container(
    height: 120,
    child: DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('images/bg_header.jpeg'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 20.0,
              left: 16.0,
              child: Text("Welcome to Stackit",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500))),
        ])),
  );
}
