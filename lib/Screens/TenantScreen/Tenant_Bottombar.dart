import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/AuthScreen/LoginScreen.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/AddPilot.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/HomeScreen.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/ScheduleScreen.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/Tenant_Table.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/TenantScreen/ViewAircraft.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'TenantUserSetting_Screen.dart';

class Teanant_Bottombar extends StatefulWidget {
  final int selectedTypeId;

  const Teanant_Bottombar({Key key, this.selectedTypeId}) : super(key: key);

  @override
  _Teanant_BottombarState createState() => _Teanant_BottombarState();
}

class _Teanant_BottombarState extends State<Teanant_Bottombar> {
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
                  onTap: () async {
                    // SharedPreferences prefs =
                    //     await SharedPreferences.getInstance();
                    // prefs.remove("selectedTypeUid");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Tenant_Table_Screen();
                    }));
                  },
                  title: Text("Tenant Activity"),
                ),
                Divider(height: 4, color: Colors.black),
                ListTile(
                  onTap: () async {
                    // SharedPreferences prefs =
                    //     await SharedPreferences.getInstance();
                    // prefs.remove("selectedTypeUid");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Tenant_AddPilot();
                    }));
                  },
                  title: Text("Add Pilot"),
                ),
                Divider(height: 4, color: Colors.black),
                ListTile(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove("selectedTypeUid");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Tenant_ViewAircrafts();
                    }));
                  },
                  title: Text("View Aircraft"),
                ),
                Divider(height: 4, color: Colors.black),
                ListTile(
                  onTap: () async {
                    // SharedPreferences prefs =
                    //     await SharedPreferences.getInstance();
                    // prefs.remove("selectedTypeUid");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Tenant_ViewAircrafts();
                    }));
                  },
                  title: Text("Add/Edit Aircraft"),
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
            ),
          ),
        ),
        bottomNavigationBar: menu(),
        body: TabBarView(
          children: [
            Tenant_HomeScreen(),
            Tenant_ScheduleScreen(),
            Tenant_ViewAircrafts(),
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
                  "Reservation",
                  style: TextStyle(fontSize: 14),
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
                  "Make Reservation",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
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
                  "Aircraft",
                  style: TextStyle(fontSize: 14),
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
