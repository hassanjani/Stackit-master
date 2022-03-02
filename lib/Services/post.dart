import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Get {
  //err

  Future<List> getAllPost() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String id = await prefs.getString('userid');
      var baseUrl1 =
          "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-reservations/pilot?id=$id";
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

  Future Add_Aircraft(BuildContext context, String reg, String type,
      String home, String pilotid) async {
    print('working');
    print("done");
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    var AddEdit_Aircraft = Uri.parse(
        'http://wordpresswebsiteprogrammer.com/stackit/public/api/store-aircraft?tenant_id=$id&pilot_id=$id');
    print('inside try');
    http.Response response = await http.post(AddEdit_Aircraft, body: {
      "id": id,
      "pilot_id": pilotid,
      "registry": reg,
      "type": type,
      "home_id": home,
    });
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

class DataModel {
  final int id;
  final String registry;
  final String type;
  final String home;
  DataModel({this.id, this.home, this.registry, this.type});
}
