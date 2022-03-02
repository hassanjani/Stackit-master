import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BannerModel22 {
  final int price;
  final int discount;
  final int id;
  final String photo;
  final String url;
  BannerModel22({
    this.price,
    this.discount,
    this.url,
    this.id,
    this.photo,
  });
}

class ViewAircrafts_Services {
  //for fetching a list of notes from server
  Future getData() async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    var url = Uri.parse(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/get-aircrafts/tenant?id=$id");
    var data = await http.get(url);
    if (data.statusCode == 200) {
      final jsonData = json.decode(data.body);
      List usersList = [];
      for (var user in jsonData) {
        DataModel model = DataModel(
            id: user['id'],
            home: user['home'],
            registry: user['registry'],
            type: user['type']);
        usersList.add(model);
      }
      print(usersList.length);
      return usersList;
    } else {
      print("Sorry we have an error");
      print(data.statusCode);
      return null;
    }
  }
}

class DataModel {
  final int id;
  final String registry;
  final String type;
  final String home;
  DataModel({this.id, this.home, this.registry, this.type});
}
