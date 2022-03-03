import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/FBOScreen/FBO_Tenant_Schedule_tab.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class DB_Tenant_Building extends StatefulWidget {
  @override
  _DB_Tenant_BuildingState createState() => _DB_Tenant_BuildingState();
}

// ignore: camel_case_types
class _DB_Tenant_BuildingState extends State<DB_Tenant_Building> {
  var _selectedType;

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
                      value: pdata.selectedBuilding,
                      onChanged: (newValue) {
                        Provider.of<FBO_TenantScheduleProvider>(context,
                                listen: false)
                            .selectedBuilding = newValue;
                        Provider.of<FBO_TenantScheduleProvider>(context,
                                listen: false)
                            .onchange("Bid", newValue);

                        print(newValue);
                        print("changed");
                      },
                      items: pdata.BuildingsData.map((value) {
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
}
