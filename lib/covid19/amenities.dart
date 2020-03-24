import 'dart:convert';

class Amenities {
  String type;
  dynamic healthType;
  String location;
  dynamic operatorType;
  dynamic icon;
  dynamic address;
  dynamic bankNetwork;
  dynamic educationType;
  String email;
  dynamic province;
  dynamic financialType;
  double latitude;
  String openingHours;
  String comments;
  dynamic municipality;
  dynamic bankType;
  String phoneNumber;
  dynamic district;
  double longitude;
  int id;
  String name;
  dynamic website;

  Amenities({
    this.type,
    this.healthType,
    this.location,
    this.operatorType,
    this.icon,
    this.address,
    this.bankNetwork,
    this.educationType,
    this.email,
    this.province,
    this.financialType,
    this.latitude,
    this.openingHours,
    this.comments,
    this.municipality,
    this.bankType,
    this.phoneNumber,
    this.district,
    this.longitude,
    this.id,
    this.name,
    this.website,
  });

  factory Amenities.fromRawJson(String str) =>
      Amenities.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Amenities.fromJson(Map<String, dynamic> json) => Amenities(
        type: json["type"],
        healthType: json["health_type"],
        location: json["location"],
        operatorType: json["operator_type"],
        icon: json["icon"],
        address: json["address"],
        bankNetwork: json["bank_network"],
        educationType: json["education_type"],
        email: json["email"],
        province: json["province"],
        financialType: json["financial_type"],
        latitude: json["latitude"].toDouble(),
        openingHours: json["opening_hours"],
        comments: json["comments"],
        municipality: json["municipality"],
        bankType: json["bank_type"],
        phoneNumber: json["phone_number"],
        district: json["district"],
        longitude: json["longitude"].toDouble(),
        id: json["id"],
        name: json["name"],
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "health_type": healthType,
        "location": location,
        "operator_type": operatorType,
        "icon": icon,
        "address": address,
        "bank_network": bankNetwork,
        "education_type": educationType,
        "email": email,
        "province": province,
        "financial_type": financialType,
        "latitude": latitude,
        "opening_hours": openingHours,
        "comments": comments,
        "municipality": municipality,
        "bank_type": bankType,
        "phone_number": phoneNumber,
        "district": district,
        "longitude": longitude,
        "id": id,
        "name": name,
        "website": website,
      };
}
