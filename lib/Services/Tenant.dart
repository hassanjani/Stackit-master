// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// class TenantServices {
//   var url = Uri.parse(
//       "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-tenant-detail?tenant_id=13");
//   //for fetching a list of notes from server
//   Future getData() async {
//     var data = await http.get(url);
//     if (data.statusCode == 200) {
//       final jsonData = json.decode(data.body);
//       List usersList = [];
//       for (var user in jsonData) {
//         DataModel model = DataModel(
//             id: user['id'],
//             home: user['first_name'].toString(),
//             registry: user['last_name'].toString(),
//             type: user['email'].toString());
//         usersList.add(model);
//       }
//       print(usersList.length);
//       return usersList;
//     } else {
//       print("Sorry we have an error");
//       print(data.statusCode);
//       return null;
//     }
//   }
// }
//
// class DataModel {
//   final int id;
//   final String registry;
//   final String type;
//   final String home;
//   DataModel({this.id, this.home, this.registry, this.type});
// }
