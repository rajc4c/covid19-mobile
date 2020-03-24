import 'dart:convert';

import 'covid19/api.dart';
import 'covid19/repository/base_repository.dart';



class GeneralAssessmentRepository extends BaseRepository {
  Future<List<OpenSpaceWithAssessment>> fetchOpenSpaceWithAssessment(
      {forceLoadFromCache = false, openSpaceQuery}) {
    return fetchItem(get_open_space, forceLoadFromCache: forceLoadFromCache)
        .then((response) {
      var json = jsonDecode(response);
      var openSpaces = mapJsonToOpenSpaceWithAssessment(json, openSpaceQuery);


      return openSpaces;
    });
  }

  Future<List<OpenSpaceWithAssessment>> fetchOpenSpaceWithAssessmentById(
      openSpaceId) {
    return fetchItem(get_open_space, forceLoadFromCache: true).then((response) {
      var json = jsonDecode(response);
      List<OpenSpaceWithAssessment> openSpaces =
          mapJsonToOpenSpaceWithAssessment(json, "");

      if (openSpaceId != null) {
        openSpaces = openSpaces.where((openSpace) {
          return openSpace.id.toString() == openSpaceId;
        }).toList();
      }

      return openSpaces;
    });
  }

  List<OpenSpaceWithAssessment> mapJsonToOpenSpaceWithAssessment(
      json, filterQuery) {
    List<OpenSpaceWithAssessment> open_spaces = (json as List).map((i) {
      return OpenSpaceWithAssessment.fromJson(i);
    }).where((openSpace) {
      return openSpace.title.toLowerCase().contains(filterQuery.toLowerCase());
    }).toList();
    return open_spaces;
  }
}

class OpenSpaceWithAssessment {
  int id;
  List<OpenSpaceSuggestedUse> suggestedUse;
  List<QuestionData> questionData;
  List<Services> services;
  String title;
  String currentLandUse;
  String ownership;
  String elevation;
  int district;
  String accessToSite;
  String specialFeature;
  String address;
  int province;
  int municipality;
  String ward;
  double capacity;
  double totalArea;
  String usableArea;
  String image;
  String description;
  List<double> centroid;
  String municipalityName;
  String provinceName;
  String districtName;
  String thumbnail;

  var distanceFromCurrentLocation;

  OpenSpaceWithAssessment(
      {this.id,
      this.suggestedUse,
      this.questionData,
      this.services,
      this.title,
      this.currentLandUse,
      this.ownership,
      this.elevation,
      this.district,
      this.accessToSite,
      this.specialFeature,
      this.address,
      this.province,
      this.municipality,
      this.ward,
      this.capacity,
      this.totalArea,
      this.usableArea,
      this.image,
      this.description,
      this.centroid,
      this.municipalityName,
      this.provinceName,
      this.districtName,
      this.thumbnail});

  OpenSpaceWithAssessment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['suggested_use'] != null) {
      suggestedUse = new List<OpenSpaceSuggestedUse>();
      json['suggested_use'].forEach((v) {
        suggestedUse.add(new OpenSpaceSuggestedUse.fromJson(v));
      });
    }
    if (json['question_data'] != null) {
      questionData = new List<QuestionData>();
      json['question_data'].forEach((v) {
        questionData.add(new QuestionData.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = new List<Services>();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
    title = json['title'];
    currentLandUse = json['current_land_use'];
    ownership = json['ownership'];
    elevation = json['elevation'];
    district = json['district'];
    accessToSite = json['access_to_site'];
    specialFeature = json['special_feature'];
    address = json['address'];
    province = json['province'];
    municipality = json['municipality'];
    ward = json['ward'];
    capacity = json['capacity'];
    totalArea = json['total_area'];
    usableArea = json['usable_area'];
    image = json['image'];
    description = json['description'];
    centroid = json['centroid'].cast<double>();
    municipalityName = json['municipality_name'];
    provinceName = json['province_name'];
    districtName = json['district_name'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.suggestedUse != null) {
      data['suggested_use'] = this.suggestedUse.map((v) => v.toJson()).toList();
    }
    if (this.questionData != null) {
      data['question_data'] = this.questionData.map((v) => v.toJson()).toList();
    }
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['current_land_use'] = this.currentLandUse;
    data['ownership'] = this.ownership;
    data['elevation'] = this.elevation;
    data['district'] = this.district;
    data['access_to_site'] = this.accessToSite;
    data['special_feature'] = this.specialFeature;
    data['address'] = this.address;
    data['province'] = this.province;
    data['municipality'] = this.municipality;
    data['ward'] = this.ward;
    data['capacity'] = this.capacity;
    data['total_area'] = this.totalArea;
    data['usable_area'] = this.usableArea;
    data['image'] = this.image;
    data['description'] = this.description;
    data['centroid'] = this.centroid;
    data['municipality_name'] = this.municipalityName;
    data['province_name'] = this.provinceName;
    data['district_name'] = this.districtName;
    data['thumbnail'] = this.thumbnail;
    return data;
  }

  @override
  String toString() {
    return 'OpenSpaceWithAssessment{title: $title, centroid: $centroid, distanceFromCurrentLocation: $distanceFromCurrentLocation}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OpenSpaceWithAssessment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          suggestedUse == other.suggestedUse &&
          questionData == other.questionData &&
          services == other.services &&
          title == other.title &&
          currentLandUse == other.currentLandUse &&
          ownership == other.ownership &&
          elevation == other.elevation &&
          district == other.district &&
          accessToSite == other.accessToSite &&
          specialFeature == other.specialFeature &&
          address == other.address &&
          province == other.province &&
          municipality == other.municipality &&
          ward == other.ward &&
          capacity == other.capacity &&
          totalArea == other.totalArea &&
          usableArea == other.usableArea &&
          image == other.image &&
          description == other.description &&
          centroid == other.centroid &&
          municipalityName == other.municipalityName &&
          provinceName == other.provinceName &&
          districtName == other.districtName &&
          thumbnail == other.thumbnail &&
          distanceFromCurrentLocation == other.distanceFromCurrentLocation;

  @override
  int get hashCode =>
      id.hashCode ^
      suggestedUse.hashCode ^
      questionData.hashCode ^
      services.hashCode ^
      title.hashCode ^
      currentLandUse.hashCode ^
      ownership.hashCode ^
      elevation.hashCode ^
      district.hashCode ^
      accessToSite.hashCode ^
      specialFeature.hashCode ^
      address.hashCode ^
      province.hashCode ^
      municipality.hashCode ^
      ward.hashCode ^
      capacity.hashCode ^
      totalArea.hashCode ^
      usableArea.hashCode ^
      image.hashCode ^
      description.hashCode ^
      centroid.hashCode ^
      municipalityName.hashCode ^
      provinceName.hashCode ^
      districtName.hashCode ^
      thumbnail.hashCode ^
      distanceFromCurrentLocation.hashCode;
}

class OpenSpaceSuggestedUse {
  int id;
  int openSpace;
  SuggestedUse suggestedUse;

  OpenSpaceSuggestedUse({this.id, this.openSpace, this.suggestedUse});

  OpenSpaceSuggestedUse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    openSpace = json['open_space'];
    suggestedUse = json['suggested_use'] != null
        ? SuggestedUse.fromJson(json['suggested_use'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['open_space'] = this.openSpace;
    if (this.suggestedUse != null) {
      data['suggested_use'] = this.suggestedUse.toJson();
    }
    return data;
  }
}

class SuggestedUse {
  int id;
  String name;
  String icon;

  SuggestedUse({this.id, this.name, this.icon});

  SuggestedUse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    return data;
  }
}

class QuestionData {
  int question;
  String ans;
  int openSpace;
  String que;

  QuestionData({this.question, this.ans, this.openSpace, this.que});

  QuestionData.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    ans = json['ans'];
    openSpace = json['open_space'];
    que = json['que'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['ans'] = this.ans;
    data['open_space'] = this.openSpace;
    data['que'] = this.que;
    return data;
  }
}

class Services {
  String description;
  int openSpace;
  SuggestedUse service;

  Services({this.description, this.openSpace, this.service});

  Services.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    openSpace = json['open_space'];
    service = json['service'] != null
        ? new SuggestedUse.fromJson(json['service'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['open_space'] = this.openSpace;
    if (this.service != null) {
      data['service'] = this.service.toJson();
    }
    return data;
  }
}

GeneralAssessmentRepository generalAssessmentRepository =
    GeneralAssessmentRepository();
