class Country {
  String country;
  String abbreviation;

  Country({this.country, this.abbreviation});

  Country.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    abbreviation = json['abbreviation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['abbreviation'] = this.abbreviation;
    return data;
  }
}