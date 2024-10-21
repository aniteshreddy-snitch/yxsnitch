// To parse this JSON data, do
//
//     final userList = userListFromJson(jsonString);

import 'dart:convert';

List<UserList> userListFromJson(String str) =>
    List<UserList>.from(json.decode(str).map((x) => UserList.fromJson(x)));

UserList userDetailFromJson(String str) => UserList.fromJson(json.decode(str));

String userListToJson(List<UserList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String userObjecttoJson(UserList data) => json.encode(data.toJson());

class UserList {
  int id;
  String email;
  String? phoneNumber;
  bool isOwner;
  String password;

  UserList(
      {required this.id,
      required this.email,
      required this.phoneNumber,
      required this.isOwner,
      this.password = ''});

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        id: json["id"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        isOwner: json["is_owner"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "id": id,
      "email": email,
      "phone_number": phoneNumber,
      "is_owner": isOwner,
    };

    if (password != '') {
      json["password"] = password;
    }

    return json;
  }
}
