// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Fbo_Api {
//   ///////////////////////////////////////////////////////////////////////
//   Future Fbo_Update_User(
//     String first_name,
//     String last_name,
//     String email,
//     String address,
//     String address2,
//     String city,
//     String state,
//     String country,
//     String postal_code,
//     String phone,
//     String phone2,
//     String notes,
//   ) async {
//     final prefs = await SharedPreferences.getInstance();
//     String id = await prefs.getString('userid');
//     var fbo_userProfile = Uri.parse(
//         'http://wordpresswebsiteprogrammer.com/stackit/public/api/update-settings/tenant?id=$id');
//     print('working');
//     try {
//       print('inside try');
//       http.Response response = await http.post(fbo_userProfile, body: {
//         "first_name": first_name,
//         "last_name": last_name,
//         "email": email,
//         "address": address,
//         "address_2": address2,
//         "country": country,
//         "state": state,
//         "city": city,
//         "postal_code": postal_code,
//         "phone": phone,
//         "phone2": phone2,
//         "notes": notes,
//       });
//       print('done');
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         print('Success');
//         print(response.body);
//         return response.body;
//       }
//     } catch (e) {
//       return null;
//     }
//   }
// }
