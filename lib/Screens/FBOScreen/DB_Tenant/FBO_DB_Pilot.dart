import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../FBO_Tenant_Schedule_tab.dart';

// ignore: camel_case_types
class FBO_DB_Tenant_Pilot extends StatefulWidget {
  @override
  _FBO_DB_Tenant_PilotState createState() => _FBO_DB_Tenant_PilotState();
}

class _FBO_DB_Tenant_PilotState extends State<FBO_DB_Tenant_Pilot> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<FBO_TenantScheduleProvider>(
            builder: (context, pdata, child) {
              return Container(
                height: 35,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10),
                    right: Radius.circular(10),
                  ),
                  border: Border.all(color: Colors.blue),
                ),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: DropdownButton(
                      isExpanded: true,
                      icon: Container(
                        height: 35,
                        width: 32,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                      hint: Text('Choose Option'), // Not necessary for Option 1
                      value: getvalue(pdata.Pid, pdata.data),
                      onChanged: (newValue) {
                        Provider.of<FBO_TenantScheduleProvider>(context,
                                listen: false)
                            .selectedPilot = newValue;
                        Provider.of<FBO_TenantScheduleProvider>(context,
                                listen: false)
                            .onchange("Pid", newValue);

                        print(newValue);
                        print("changed");
                      },
                      items: pdata.data.map((value) {
                        return DropdownMenuItem(
                          value:
                              value["id"] == null ? "" : value["id"].toString(),
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
              );
            },
          ),
          ///////////
        ],
      ),
    );
  }

  String getvalue(String v, List<dynamic> list) {
    // dynamic value =
    //     list.singleWhere((item) => item["id"] == v, orElse: () => null);
    int a = 0;
    list.forEach((element) {
      print(v);
      print(element["id"]);
      if (element["id"].toString() == v) {
        print("true");
        a = 1;
      }
    });

    if (a == 1) {
      print("notnull");
      return v;
    } else {
      print("null");

      String abc;
      return abc;
    }
  }
}
