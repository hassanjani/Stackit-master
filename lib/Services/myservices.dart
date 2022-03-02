// import 'package:flutter_forget_pass_recover_with_verify/Services/countrymodel.dart';
// import 'package:flutter_forget_pass_recover_with_verify/Services/servicesmodel.dart';
// import 'package:flutter_forget_pass_recover_with_verify/Services/statesmodel.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class MyServices {
//   var tCountry = Uri.parse(
//       "http://wordpresswebsiteprogrammer.com/stackit/public/api/countries");
//
//   var tRes = Uri.parse(
//       "http://wordpresswebsiteprogrammer.com/stackit/public/api/save-reservation");
//
//   Future tenantReservation(
//       // int schedule_type,
//       // int tenant_id,
//       // int pilot_id,
//       // int aircraft_id,
//       // int building_id,
//       // DateTime arrival_date,
//       // DateTime arrival_time,
//       // int services,
//       // bool is_fuel,
//       ) async {
//     print('working');
//     try {
//       print('inside try');
//       http.Response response = await http.post(tRes, body: {
//         // "schedule_type": schedule_type,
//         // "tenant_id": tenant_id,
//         // "pilot_id": pilot_id,
//         // "aircraft_id": aircraft_id,
//         // "building_id": building_id,
//         // "arrival_date": arrival_date,
//         // "arrival_time": arrival_time,
//         // "services": services,
//         // "is_fuel": is_fuel.toString(),
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
//
//   Future getServices1(
//     int userId,
//     int userTypeId,
//     int scheduleType,
//     int reservationId,
//   ) async {
//     var tServices = Uri.parse(
//         "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-services?user_id=$userId");
//     print('working');
//     try {
//       print('inside try');
//       http.Response response = await http.post(tServices);
//       print('done');
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         print('Success');
//         final jsonData = json.decode(response.body);
//         var data = response.body;
//         List dataList = [];
//         for (var item in jsonData) {
//           ServicesModel model = ServicesModel(
//             id: item['id'],
//             price: item['price'],
//             name: item['name'],
//             checked: item['checked'],
//             mandatoryChecked: item['mandatory_checked'],
//           );
//           dataList.add(model);
//         }
//         return dataList;
//       }
//     } catch (e) {
//       return null;
//     }
//   }
//
//   Future getCountriesList() async {
//     var data = await http.get(tCountry);
//     if (data.statusCode == 200) {
//       final jsonData = json.decode(data.body);
//       final countries = [];
//       for (var item in jsonData) {
//         final country = CountryModel(
//           id: item['id'],
//           value: item['value'],
//         );
//         countries.add(country);
//       }
//       return countries;
//     } else {
//       print("Sorry we have an error");
//       print(data.statusCode);
//     }
//   }
// }
//
// Future getState(String country) async {
//   var tState = Uri.parse(
//       "http://wordpresswebsiteprogrammer.com/stackit/public/api/states");
//   var data = await http.get(tState);
//   if (data.statusCode == 200) {
//     final jsonData = json.decode(data.body);
//     final states = [];
//     for (var item in jsonData) {
//       final state = StatesModel(
//         id: item['id'],
//         value: item['value'],
//       );
//       states.add(state);
//     }
//     return states;
//   } else {
//     print("Sorry we have an error");
//     print(data.statusCode);
//   }
// }
