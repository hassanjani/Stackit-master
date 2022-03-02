import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class tenant_home_Get {
  String id = "";
  List data;
  // String baseUrl1 =
  //     "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-reservations/tenant?id=";
  // var queryParameters = {
  //   'param1': 'one',
  //   'param2': 'two',
  // };
  Future<List> getAllPost() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String id = await prefs.getString('userid');
      var baseUrl1 =
          "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-reservations/tenant?id=$id";
      print(id);
      // baseUrl1=baseUrl1+id;
      var response = await http.get(Uri.parse(baseUrl1));
      print("Ok 2");
      print(response);
      print("Ok 3");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (SocketException) {
      return Future.error("Error Fetching Data");
    }
  }

  var AddEdit_Aircraft = Uri.parse(
      'http://wordpresswebsiteprogrammer.com/stackit/public/api/store-aircraft?tenant_id=13&pilot_id=40');
  Future Add_Aircraft(String reg, String type, String home) async {
    print('working');
    try {
      print('inside try');
      http.Response response = await http.post(AddEdit_Aircraft, body: {
        "registry": reg,
        "type": type,
        "home_id": home,
      });
      print('done');
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Success');
        print(response.body);
        return response.body;
      }
    } catch (e) {
      return null;
    }
  }
}
