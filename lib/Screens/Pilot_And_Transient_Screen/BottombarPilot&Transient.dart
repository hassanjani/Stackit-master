import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/AuthScreen/LoginScreen.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/Pilot_And_Transient_Screen/AircraftAsigScreen.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/Pilot_And_Transient_Screen/ScheduleScreen.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/Pilot_And_Transient_Screen/Table_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';

class BottombarPilotTransient extends StatefulWidget {
  final int selectedTypeId;
  final int id;
  const BottombarPilotTransient({Key key, this.selectedTypeId, this.id})
      : super(key: key);

  @override
  _BottombarPilotTransientState createState() =>
      _BottombarPilotTransientState();
}

class _BottombarPilotTransientState extends State<BottombarPilotTransient> {
  storeIdInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedTypeUid', this.widget.selectedTypeId);
    prefs.setInt('Uid', this.widget.id);
    print('Id stored in local DB');
    print(prefs.getInt('selectedTypeUid'));
    print(prefs.getInt('Uid'));
  }

  @override
  void initState() {
    super.initState();
    storeIdInSharedPreference();
  }

  DataModel model;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
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
                      return BottombarPilotTransient();
                    }));
                  },
                  title: Text("Pilot Activity"),
                ),
                Divider(height: 4, color: Colors.black),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Pilot_A_Transient_Table_Activity();
                    }));
                  },
                  title: Text("Pilot Activity"),
                ),
                Divider(height: 4, color: Colors.black),
                ListTile(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove("selectedTypeUid");
                    Navigator.pushReplacement(context,
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
            Pilot_A_Transient_Home(),
            PTransient_ScheduleScreen(),
            Pilot_A_Transient_AircraftAssigned(),
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
                  "Make Reservation",
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
                  "Aircraft",
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
            image: DecorationImage(fit: BoxFit.fill, image: AssetImage(""))),
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
