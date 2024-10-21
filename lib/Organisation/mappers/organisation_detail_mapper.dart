// To parse this JSON data, do
//
//     final organisation = organisationFromJson(jsonString);

import 'dart:convert';

OrganisationDetail organisationFromJson(String str) => OrganisationDetail.fromJson(json.decode(str));

String organisationToJson(OrganisationDetail data) => json.encode(data.toJson());

class OrganisationDetail {
    int id;
    String name;
    String streetAddress;
    int pincode;
    String city;
    String state;

    OrganisationDetail({
        required this.id,
        required this.name,
        required this.streetAddress,
        required this.pincode,
        required this.city,
        required this.state,
    });

    factory OrganisationDetail.fromJson(Map<String, dynamic> json) => OrganisationDetail(
        id: json["id"],
        name: json["name"],
        streetAddress: json["street_address"],
        pincode: json["pincode"],
        city: json["city"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "street_address": streetAddress,
        "pincode": pincode,
        "city": city,
        "state": state,
    };
}