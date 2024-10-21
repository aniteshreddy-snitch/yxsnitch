// To parse this JSON data, do
//
//     final activityList = activityListFromJson(jsonString);

import 'dart:convert';

List<ActivityList> activityListFromJson(String str) => List<ActivityList>.from(json.decode(str).map((x) => ActivityList.fromJson(x)));

String activityListToJson(List<ActivityList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityList {
    int id;
    int device;
    String deviceName;
    String location;
    DateTime createdDate;
    String activity;

    ActivityList({
        required this.id,
        required this.device,
        required this.deviceName,
        required this.location,
        required this.createdDate,
        required this.activity,
    });

    factory ActivityList.fromJson(Map<String, dynamic> json) => ActivityList(
        id: json["id"],
        device: json["device"],
        deviceName: json["device_name"],
        location: json["location"],
        createdDate: DateTime.parse(json["created_date"]),
        activity: json["activity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "device": device,
        "device_name": deviceName,
        "location": location,
        "created_date": createdDate.toIso8601String(),
        "activity": activity,
    };
}
