import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  var uriPost = Uri.parse(
      'http://wordpresswebsiteprogrammer.com/stackit/public/api/send-otp');
  var uriPostLatLong = Uri.parse(
      'http://wordpresswebsiteprogrammer.com/stackit/public/api/send-otp');
  var otpPost = Uri.parse(
      'http://wordpresswebsiteprogrammer.com/stackit/public/api/verify-otp');
  var uriAllTenantPost = Uri.parse(
      "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-tenants-list");

  ///////////////////////////////////////////////////////////////////////
  Future verificationOTP(
      BuildContext context, String userTypeId, String phone) async {
    print('working');
    print('inside try');
    http.Response response = await http.post(uriPost, body: {
      "user_type_id": userTypeId,
      "phone": phone,
    });
    print(response.statusCode);
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data["success"]);
    String success = data["success"].toString();
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text(response.body.toString())));
    if (success == "1") {
      print(response.statusCode);
      print('done');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          width: MediaQuery.of(context).size.width * 0.90,
          content: Text(data["message"])));
    } else {
      print("Sorry we have an error");
      print(response.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          width: MediaQuery.of(context).size.width * 0.90,
          content: Text(data["message"])));
    }
    return response.body;
  }
}

// Future<ApiResponse> registration(LoginModel register) async {
//   //   try {
//   //     print("Ok 10");
//   //     Response response = await dioClient.post(
//   //       'AppConstants.REGISTRATION_URI',
//   //       data: register.toJson(),
//   //     );
//   //     print("Ok 11");
//   //     return ApiResponse.withSuccess(response);
//   //   } catch (e) {
//   //     print("Ok 12");
//   //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//   //   }
//   // }

// Future enterOTP(BuildContext context, String userTypeId, String otp) async {
//   print('working');
//   try {
//     print('inside try');
//     http.Response response = await http.post(otpPost, body: {
//       "user_type_id": userTypeId,
//       "otp": otp,
//     });
//     print('done');
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       backgroundColor: Colors.lightGreen,
//       behavior: SnackBarBehavior.floating,
//       width: MediaQuery.of(context).size.width * 0.90,
//       content: Text(response.body.toString()),
//     ));
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print('Success here');
//       Map<String, dynamic> responseJson = json.decode(response.body);
//       print(responseJson["id"]);
//       print(response.body);
//       Saveuserid(responseJson["id"].toString());
//       return response.body;
//     }
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       backgroundColor: Colors.lightGreen,
//       behavior: SnackBarBehavior.floating,
//       width: MediaQuery.of(context).size.width * 0.90,
//       content: Text(e.body.toString()),
//     ));
//     return null;
//   }
// }

Saveuserid(String id) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('userid', id);
}

// Future enterLatLong(String lat, String long) async {
//   var uriPostLatLong = Uri.parse(
//       'https://alhafizcloth.com/100min/api/v1/products/latest/1/$lat/$long?limit=10&&offset=');
//   print('working');
//   try {
//     print('inside try');
//     http.Response response = await http.get(uriPostLatLong);
//     print('done');
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print('Success');
//       print(response.body);
//       return response.body;
//     }
//   } catch (e) {
//     return null;
//   }
// }

// Future GetAllTenant(String userTypeId, String phone) async {
//   print('working');
//   try {
//     print('inside try');
//     http.Response response = await http.post(uriAllTenantPost, body: {
//       "id": userTypeId,
//       "company_name": phone,
//     });
//     print('done');
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print('Success');
//       print(response.body);
//       return response.body;
//     }
//   } catch (e) {
//     return null;
//   }
// }

// Future User_Settting_Api(String fName, String lName, String email,
//     String Pass, String note) async {
//   final prefs = await SharedPreferences.getInstance();
//   String id = await prefs.getString('userid');
//   var userSettingPost = Uri.parse(
//       "http://wordpresswebsiteprogrammer.com/stackit/public/api/update-settings/pilot?id=$id");
//   print('working');
//   try {
//     print('inside try');
//     http.Response response = await http.post(userSettingPost, body: {
//       "firstname": fName,
//       "lastname": lName,
//       "email": email,
//       "password": Pass,
//       "note": note,
//     });
//     print('done');
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print('Success');
//       print(response.body);
//       return response.body;
//     }
//   } catch (e) {
//     return null;
//   }
// }
