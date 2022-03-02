// To parse this JSON data, do
//
//     final arrivals = arrivalsFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

Activities activitiesFromMap(String str) =>
    Activities.fromMap(json.decode(str));

String activitiesToMap(Activities data) => json.encode(data.toMap());

class Activities {
  Activities({
    @required this.pendingActivities,
    @required this.totalActivities,
  });

  List<PendingActivity> pendingActivities;
  List<TotalActivity> totalActivities;

  factory Activities.fromMap(Map<String, dynamic> json) => Activities(
        pendingActivities: List<PendingActivity>.from(
            json["pending_activities"].map((x) => PendingActivity.fromMap(x))),
        totalActivities: List<TotalActivity>.from(
            json["total_activities"].map((x) => TotalActivity.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "pending_activities":
            List<dynamic>.from(pendingActivities.map((x) => x.toMap())),
        "total_activities":
            List<dynamic>.from(totalActivities.map((x) => x.toMap())),
      };
}

class PendingActivity {
  PendingActivity({
    @required this.buildingName,
    @required this.pendingActivity,
  });

  String buildingName;
  int pendingActivity;

  factory PendingActivity.fromMap(Map<String, dynamic> json) => PendingActivity(
        buildingName: json["building_name"],
        pendingActivity: json["pending_activity"],
      );

  Map<String, dynamic> toMap() => {
        "building_name": buildingName,
        "pending_activity": pendingActivity,
      };
}

class TotalActivity {
  TotalActivity({
    @required this.buildingName,
    @required this.totalActivity,
  });

  String buildingName;
  int totalActivity;

  factory TotalActivity.fromMap(Map<String, dynamic> json) => TotalActivity(
        buildingName: json["building_name"],
        totalActivity: json["total_activity"],
      );

  Map<String, dynamic> toMap() => {
        "building_name": buildingName,
        "total_activity": totalActivity,
      };
}
