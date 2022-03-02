import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FBO_Api {
  ///////////////////////////////////////////////////////////////////////
  Future FBO_ADD_TENANT(
    BuildContext context,
    String fNamee,
    String LNamee,
    String address1,
    String address2,
    String selectedCountry,
    String selectedState,
    String city,
    String postal_code,
    String email,
    // String pass,
    String note,
    String phone,
    String phone2,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    var uriPost = Uri.parse(
        'http://wordpresswebsiteprogrammer.com/stackit/public/api/create-tenant?id=$id');
    print('working');
    print('inside try');
    http.Response response = await http.post(uriPost, body: {
      "first_name": fNamee,
      "last_name": LNamee,
      "address": address1,
      "address_2": address2,
      // "country": selectedCountry,
      "state": selectedState,
      "city": city,
      // "postal_code": postal_code,
      "email": email,
      // "password": pass,
      "phone": phone,
      "phone2": phone2,
      "notes": note,
    });
    print('done');
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
          behavior: SnackBarBehavior.floating,
          width: MediaQuery.of(context).size.width * 0.90,
          content: Text(data["message"])));
    }
    return response.body;
  }
}
