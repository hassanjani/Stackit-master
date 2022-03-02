// To parse this JSON data, do
//
//     final arrivals = arrivalsFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

Arrivals arrivalsFromMap(String str) => Arrivals.fromMap(json.decode(str));

String arrivalsToMap(Arrivals data) => json.encode(data.toMap());

class Arrivals {
  Arrivals({
    @required this.pendingArrivals,
    @required this.totalArrivals,
  });

  List<Arrival> pendingArrivals;
  List<Arrival1> totalArrivals;

  factory Arrivals.fromMap(Map<String, dynamic> json) => Arrivals(
        pendingArrivals: List<Arrival>.from(
            json["pending_arrivals"].map((x) => Arrival.fromMap(x))),
        totalArrivals: List<Arrival1>.from(
            json["total_arrivals"].map((x) => Arrival1.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "pending_arrivals":
            List<dynamic>.from(pendingArrivals.map((x) => x.toMap())),
        "total_arrivals":
            List<dynamic>.from(totalArrivals.map((x) => x.toMap())),
      };
}

class Arrival {
  Arrival({
    @required this.buildingName,
    @required this.totalActivity,
  });

  String buildingName;
  int totalActivity;

  factory Arrival.fromMap(Map<String, dynamic> json) => Arrival(
        buildingName: json["building_name"],
        totalActivity: json["total_activity"],
      );

  Map<String, dynamic> toMap() => {
        "building_name": buildingName,
        "total_activity": totalActivity,
      };
}

class Arrival1 {
  Arrival1({
    @required this.buildingName,
    @required this.totalActivity,
  });

  String buildingName;
  int totalActivity;

  factory Arrival1.fromMap(Map<String, dynamic> json) => Arrival1(
        buildingName: json["building_name"],
        totalActivity: json["total_activity"],
      );

  Map<String, dynamic> toMap() => {
        "building_name": buildingName,
        "total_activity": totalActivity,
      };
}
