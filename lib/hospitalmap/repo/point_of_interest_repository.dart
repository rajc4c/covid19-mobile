import 'dart:convert';

import 'package:openspaces/covid19/repository/base_repository.dart';
import 'package:openspaces/hospitalmap/repo/point_of_interest.dart';

class PointOfInterestRepository extends BaseRepository {
  Future<List<PointOfInterest>> fetchHealthFacilities(String url) {
    return fetchItem(url, shouldCache: true).then((response) {
      return mapResponseToPointOfInterest(response);
    });
  }

  List<PointOfInterest> mapResponseToPointOfInterest(response) {
    return (json.decode(response) as List).map((result) {
      return PointOfInterest.fromJson(result);
    }).toList();
  }
}

final pointOfInterestRepository = PointOfInterestRepository();
