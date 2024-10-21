import 'dart:convert';

List<DeviceList> deviceListFromJson(String str) =>
    List<DeviceList>.from(json.decode(str).map((x) => DeviceList.fromJson(x)));

String deviceListToJson(List<DeviceList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeviceList {
  int id;
  String name;
  String status;
  GroupCategory group;
  GroupCategory category;
  String roomLight;
  int organisation;
  int groupId;
  int categoryId;

  DeviceList({
    required this.id,
    required this.name,
    required this.status,
    required this.group,
    required this.category,
    required this.roomLight,
    required this.organisation,
    required this.groupId,
    required this.categoryId
  });

  factory DeviceList.fromJson(Map<String, dynamic> json) => DeviceList(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        group: GroupCategory.fromJson(json["group"]),
        category: GroupCategory.fromJson(json["category"]),
        roomLight: json["room_light"],
        organisation: json["organisation"],
        groupId: json["group"]['id'],
        categoryId: json["category"]['id']

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "group": group.toJson(),
        "category": category.toJson(),
        "room_light": roomLight,
        "organisation": organisation,
        "group_id": group.id,
        "category_id": category.id
      };
}

class GroupCategory {
  int id;
  String name;
  int organisation;

  GroupCategory({
    required this.id,
    required this.name,
    required this.organisation,
  });

  factory GroupCategory.fromJson(Map<String, dynamic> json) => GroupCategory(
        id: json["id"],
        name: json["name"],
        organisation: json["organisation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "organisation": organisation,
      };
}
