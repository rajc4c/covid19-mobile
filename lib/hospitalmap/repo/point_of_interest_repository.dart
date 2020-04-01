import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:openspaces/covid19/repository/base_repository.dart';
import 'package:openspaces/hospitalmap/repo/point_of_interest.dart';

class PointOfInterestRepository extends BaseRepository {
  Future<List<PointOfInterest>> fetchHealthFacilities(String url,
      {@required query}) {
    return fetchItem(url, shouldCache: true).then((response) {
      return mapResponseToPointOfInterest(response, query);
    });
  }

  List<PointOfInterest> mapResponseToPointOfInterest(response, String query) {
    return (json.decode(response) as List).map((result) {
      return PointOfInterest.fromJson(result);
    }).where((pointOfInterest) {
      if (query.isEmpty) {
        return true;
      }
      return pointOfInterest.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}

final pointOfInterestRepository = PointOfInterestRepository();
