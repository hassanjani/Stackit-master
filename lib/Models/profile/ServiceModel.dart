import 'dart:convert';

import 'package:meta/meta.dart';

List<ServicesModel> servicesModelFromMap(String str) =>
    List<ServicesModel>.from(
        json.decode(str).map((x) => ServicesModel.fromMap(x)));

String servicesModelToMap(List<ServicesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ServicesModel {
  ServicesModel({
    @required this.id,
    @required this.price,
    @required this.name,
    @required this.mandatoryChecked,
    @required this.checked,
  });

  int id;
  String price;
  String name;
  int mandatoryChecked;
  int checked;

  factory ServicesModel.fromMap(Map<String, dynamic> json) => ServicesModel(
        id: json["id"],
        price: json["price"],
        name: json["name"],
        mandatoryChecked: json["mandatory_checked"],
        checked: json["checked"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "price": price,
        "name": name,
        "mandatory_checked": mandatoryChecked,
        "checked": checked,
      };
}
