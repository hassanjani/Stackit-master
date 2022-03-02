import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/tabbar_screen/Transient_schedule_tab.dart';
import 'package:flutter_forget_pass_recover_with_verify/Widgets/Component/simpleText.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class DB_Transient_Company extends StatefulWidget {
  @override
  _DB_Transient_CompanyState createState() => _DB_Transient_CompanyState();
}

// ignore: camel_case_types
class _DB_Transient_CompanyState extends State<DB_Transient_Company> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0),
          //   child: SimpleText("Company"),
          // ),
          Consumer<TransientScheduleProvider>(
            builder: (context, pdata, child) {
              return Container(
                height: 35,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(35),
                    right: Radius.circular(35),
                  ),
                  border: Border.all(color: Colors.blue),
                ),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text('Choose Option'), // Not necessary for Option 1
                      value: pdata.selectedPilot,
                      onChanged: (newValue) {
                        Provider.of<TransientScheduleProvider>(context,
                                listen: false)
                            .selectedPilot = newValue;
                        Provider.of<TransientScheduleProvider>(context,
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
                              value["company_name"] == null
                                  ? ""
                                  : value["company_name"].toString(),
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
