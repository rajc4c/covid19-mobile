import 'package:latlong/latlong.dart';

class OpenSpace {
  var id;
  var title;
  var description;
  var currentLandUse;
  var catchmentArea;
  var ownership;
  var elevation;
  var accessToSite;
  var specialFeature;
  var address;
  var ward;
  var capacity;
  var totalArea;
  var usableArea;
  var image;
  var maps;
  var location;
  var polygons;
  int province;
  int district;
  int municipality;
  LatLng center;

  OpenSpace(
      {this.id,
      this.title,
      this.description,
      this.currentLandUse,
      this.catchmentArea,
      this.ownership,
      this.elevation,
      this.accessToSite,
      this.specialFeature,
      this.address,
      this.ward,
      this.capacity,
      this.totalArea,
      this.usableArea,
      this.image,
      this.maps,
      this.location,
      this.polygons,
      this.province,
      this.district,
      this.municipality});

  OpenSpace.fromJson(Map<String, dynamic> json) {
    id = json['pk'];

    if (id == null) {
      id = json['id'].toString();
    }

    title = json['title'];
    description = json['description'];
    currentLandUse = json['current_land_use'];
    catchmentArea = json['catchment_area'];
    ownership = json['ownership'];
    elevation = json['elevation'];
    accessToSite = json['access_to_site'];
    specialFeature = json['special_feature'];
    address = json['address'];
    ward = json['ward'];
    capacity = json['capacity'];
    totalArea = json['total_area'];
    usableArea = json['usable_area'];
    image = json['image'];
    maps = json['maps'];
    location = json['location'];
    polygons = json['polygons'];
    province = json['province'];
    district = json['district'];
    municipality = json['municipality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['current_land_use'] = this.currentLandUse;
    data['catchment_area'] = this.catchmentArea;
    data['ownership'] = this.ownership;
    data['elevation'] = this.elevation;
    data['access_to_site'] = this.accessToSite;
    data['special_feature'] = this.specialFeature;
    data['address'] = this.address;
    data['ward'] = this.ward;
    data['capacity'] = this.capacity;
    data['total_area'] = this.totalArea;
    data['usable_area'] = this.usableArea;
    data['image'] = this.image;
    data['maps'] = this.maps;
    data['location'] = this.location;
    data['polygons'] = this.polygons;
    data['province'] = this.province;
    data['district'] = this.district;
    data['municipality'] = this.municipality;
    return data;
  }

  @override
  String toString() {
    return 'OpenSpace{id: $id, title: $title, description: $description, currentLandUse: $currentLandUse, catchmentArea: $catchmentArea, ownership: $ownership, elevation: $elevation, accessToSite: $accessToSite, specialFeature: $specialFeature, address: $address, ward: $ward, capacity: $capacity, totalArea: $totalArea, usableArea: $usableArea, image: $image, maps: $maps, location: $location, polygons: $polygons, province: $province, district: $district, municipality: $municipality, center: $center}';
  }
}
