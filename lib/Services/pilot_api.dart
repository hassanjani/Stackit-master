// import 'package:http/http.dart' as http;
//
// class PilotApi {
//   var uriAddPilot = Uri.parse(
//       'http://wordpresswebsiteprogrammer.com/stackit/public/api/store-pilot');
//   var uriAddAircrafts = Uri.parse(
//       'http://wordpresswebsiteprogrammer.com/stackit/public/api/store-aircraft');
//
//   ///////////////////////////////////////////////////////////////////////
//   Future AddPilot(String firstName, String lastName, String Email, String Notes,
//       String phone_one, String phone_two) async {
//     print('working');
//     try {
//       print('inside try');
//       http.Response response = await http.post(uriAddPilot, body: {
//         "firstname": firstName,
//         "lastname": lastName,
//         "email": Email,
//         "phone": Notes,
//         "phone2": phone_one,
//         "Note": phone_two,
//       });
//       print(response);
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
//
//   /////////////////////
//   Future AddAircrafts(String pilotID, String homeID) async {
//     print('working');
//     try {
//       print('inside try');
//       http.Response response = await http.post(uriAddAircrafts, body: {
//         "pilot_id": pilotID,
//         "home_id": homeID,
//       });
//       print(response);
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
