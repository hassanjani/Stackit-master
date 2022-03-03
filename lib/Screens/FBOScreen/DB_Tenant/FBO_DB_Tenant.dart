import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/FBOScreen/FBO_Tenant_Schedule_tab.dart';
import 'package:provider/provider.dart';

class FBO_DB_Tenant extends StatefulWidget {
  @override
  _FBO_DB_TenantState createState() => _FBO_DB_TenantState();
}

class _FBO_DB_TenantState extends State<FBO_DB_Tenant> {
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
                      value: pdata.Tid,
                      onChanged: (newValue) {
                        Provider.of<FBO_TenantScheduleProvider>(context,
                                listen: false)
                            .selectedTenant = newValue;
                        Provider.of<FBO_TenantScheduleProvider>(context,
                                listen: false)
                            .onchange("Tid", newValue);

                        print(newValue);
                        print("changed");
                      },
                      items: pdata.TenantssData.map((value) {
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

//   String selectedName;
//   List data = List();
//
//   @override
//   void initState() {
//     super.initState();
//     getAllName();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             height: 35,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.rectangle,
//               borderRadius: BorderRadius.horizontal(
//                 left: Radius.circular(10),
//                 right: Radius.circular(10),
//               ),
//               border: Border.all(color: Colors.blue),
//             ),
//             child: DropdownButtonHideUnderline(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10.0),
//                 child: DropdownButton(
//                   isExpanded: true,
//                   icon: Container(
//                     height: 35,
//                     width: 32,
//                     decoration: BoxDecoration(
//                         color: Colors.blue,
//                         borderRadius: BorderRadius.circular(5)),
//                     child: Icon(
//                       Icons.arrow_drop_down,
//                       color: Colors.white,
//                     ),
//                   ),
//                   hint: Text('Choose Option'), // Not necessary for Option 1
//                   value: selectedName,
//                   onChanged: (newValue) {
//                     setState(() {
//                       selectedName = newValue;
//                       Provider.of<FBO_TenantScheduleProvider>(context,
//                               listen: false)
//                           .onchange("Tid", newValue);
//                     });
//                   },
//                   items: data.map((value) {
//                     return DropdownMenuItem(
//                       value: value["id"] == null ? "" : value["id"].toString(),
//                       child: Text(
//                           value["company_name"] == null
//                               ? ""
//                               : value["company_name"].toString(),
//                           style: TextStyle(fontSize: 12)),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ),
//           ///////////
//         ],
//       ),
//     );
//   }
//
//   Future getAllName() async {
//     var response = await http.get(
//         "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-tenants-list",
//         headers: {"Accept": "application/json"});
//     var jsonBody = response.body;
//     var jsonData = json.decode(jsonBody);
//     print(response.statusCode);
//     print("DBTenant");
//
//     print(response.body.toString());
//
//     setState(() {
//       data = jsonData;
//     });
//
//     print(jsonData);
//     return "success";
//   }
// }
