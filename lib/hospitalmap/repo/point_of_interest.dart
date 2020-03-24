class PointOfInterest {
  int id;
  String ownershipDisplay;
  String name;
  String ownership;
  dynamic contactPerson;
  String contactNum;
  bool usedForCoronaResponse;
  int numOfBed;
  int numOfIcuBed;
  int occupiedIcuBed;
  int numOfVentilators;
  int occupiedVentilators;
  int numOfIsolationBed;
  int occupiedIsolationBed;
  int totalTested;
  int totalPositive;
  int totalDeath;
  int totalInIsolation;
  dynamic hlcitCode;
  String remarks;
  dynamic location;
  double lat;
  double long;
  dynamic province;
  dynamic district;
  dynamic municipality;
  dynamic category;
  int type;

  PointOfInterest(
      {this.id,
      this.ownershipDisplay,
      this.name,
      this.ownership,
      this.contactPerson,
      this.contactNum,
      this.usedForCoronaResponse,
      this.numOfBed,
      this.numOfIcuBed,
      this.occupiedIcuBed,
      this.numOfVentilators,
      this.occupiedVentilators,
      this.numOfIsolationBed,
      this.occupiedIsolationBed,
      this.totalTested,
      this.totalPositive,
      this.totalDeath,
      this.totalInIsolation,
      this.hlcitCode,
      this.remarks,
      this.location,
      this.lat,
      this.long,
      this.province,
      this.district,
      this.municipality,
      this.category,
      this.type});

  PointOfInterest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownershipDisplay = json['ownership_display'];
    name = json['name'];
    ownership = json['ownership'];
    contactPerson = json['contact_person'];
    contactNum = json['contact_num'];
    usedForCoronaResponse = json['used_for_corona_response'];
    numOfBed = json['num_of_bed'];
    numOfIcuBed = json['num_of_icu_bed'];
    occupiedIcuBed = json['occupied_icu_bed'];
    numOfVentilators = json['num_of_ventilators'];
    occupiedVentilators = json['occupied_ventilators'];
    numOfIsolationBed = json['num_of_isolation_bed'];
    occupiedIsolationBed = json['occupied_isolation_bed'];
    totalTested = json['total_tested'];
    totalPositive = json['total_positive'];
    totalDeath = json['total_death'];
    totalInIsolation = json['total_in_isolation'];
    hlcitCode = json['hlcit_code'];
    remarks = json['remarks'];
    location = json['location'];
    lat = json['lat'];
    long = json['long'];
    province = json['province'];
    district = json['district'];
    municipality = json['municipality'];
    category = json['category'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ownership_display'] = this.ownershipDisplay;
    data['name'] = this.name;
    data['ownership'] = this.ownership;
    data['contact_person'] = this.contactPerson;
    data['contact_num'] = this.contactNum;
    data['used_for_corona_response'] = this.usedForCoronaResponse;
    data['num_of_bed'] = this.numOfBed;
    data['num_of_icu_bed'] = this.numOfIcuBed;
    data['occupied_icu_bed'] = this.occupiedIcuBed;
    data['num_of_ventilators'] = this.numOfVentilators;
    data['occupied_ventilators'] = this.occupiedVentilators;
    data['num_of_isolation_bed'] = this.numOfIsolationBed;
    data['occupied_isolation_bed'] = this.occupiedIsolationBed;
    data['total_tested'] = this.totalTested;
    data['total_positive'] = this.totalPositive;
    data['total_death'] = this.totalDeath;
    data['total_in_isolation'] = this.totalInIsolation;
    data['hlcit_code'] = this.hlcitCode;
    data['remarks'] = this.remarks;
    data['location'] = this.location;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['province'] = this.province;
    data['district'] = this.district;
    data['municipality'] = this.municipality;
    data['category'] = this.category;
    data['type'] = this.type;
    return data;
  }
}
