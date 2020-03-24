import 'dart:convert';


import 'package:openspaces/covid19/repository/base_repository.dart';

import 'amenities.dart';
import 'api.dart';

class AmenitiesRepository extends BaseRepository {
  // returns either Map<dynamic, List<Amenities>>
  // or List<Amenities>
  Future<dynamic> fetchAmenitiesById(
      {openSpaceId, distance = 1, calculateDist = true}) {
    var url = get_amenities +
        "?id=" +
        openSpaceId.toString() +
        "&distance=" +
        distance.toString();
    return fetchItem(url).then((response) {
      var json = jsonDecode(response);

      List<Amenities> amemities =
          mapJsonToAmenities(json["facility"]).where((amenity) {
        return !"place of worship".contains(amenity.type.toLowerCase());
      }).toList();

      if (!calculateDist) {
        return amemities;
      }

      Map<dynamic, List<Amenities>> map_amenities = Map();

      List<String> typeOfAmenities = [];

      for (Amenities a in amemities) {
        typeOfAmenities.add(a.type);
      }

      //Remove duplicates
      var setTypeOfAmenities = typeOfAmenities.toSet();
      typeOfAmenities = setTypeOfAmenities.toList();

      for (String type in typeOfAmenities) {
        List<Amenities> tempAmenities = [];

        for (Amenities a in amemities) {
          if (a.type == type) {
            tempAmenities.add(a);
          }
        }

        map_amenities[type] = tempAmenities;
      }

//      map_amenities.putIfAbsent("", typeOfAmenities);
      map_amenities.putIfAbsent("education facility", () => []);
      map_amenities.putIfAbsent("health facility", () => []);
      map_amenities.putIfAbsent("helipad", () => []);
      map_amenities.putIfAbsent("security force", () => []);
      return map_amenities;
    });
  }

  List<Amenities> mapJsonToAmenities(json) {
    List<Amenities> amenities = (json as List).map((i) {
      return Amenities.fromJson(i);
    }).toList();
    return amenities;
  }
}

AmenitiesRepository amenitiesRepository = AmenitiesRepository();
