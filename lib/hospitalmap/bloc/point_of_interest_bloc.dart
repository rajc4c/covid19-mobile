import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:openspaces/covid19/api.dart';
import 'package:openspaces/covid19/base_inherited_bloc_provider.dart';
import 'package:openspaces/covid19/common_widgets.dart';
import 'package:openspaces/hospitalmap/repo/point_of_interest.dart';
import 'package:openspaces/hospitalmap/repo/point_of_interest_repository.dart';
import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';

class PointOfInterestBloc extends BaseBloc {
  final  pointOfInterestController = BehaviorSubject<List<PointOfInterest>>();
  final pointOfInterestCountController = BehaviorSubject<int>();
  final _pointOfInterestMarkers = BehaviorSubject<List<Marker>>();

  Stream<List<PointOfInterest>> get pointOfInterests =>
      pointOfInterestController.stream;

  Stream<List<Marker>> get pointOfInterestMarkers =>
      _pointOfInterestMarkers.stream;

  Stream<int> get pointOfInterestsCount =>
      pointOfInterestCountController.stream;

  Function(int) get addPointOfInterestCount =>
      pointOfInterestCountController.sink.add;

  Function(List<Marker>) get addPointOfInterestMarkers =>
      _pointOfInterestMarkers.sink.add;

  Function(List<PointOfInterest>) get addPointOfInterest =>
      pointOfInterestController.sink.add;

  fetchHealthFacilities() async {
    List<PointOfInterest> candidateMatches = await pointOfInterestRepository
        .fetchHealthFacilities(get_health_facilities)
        .catchError((error, stacktrage) {
      print(stacktrage);
    });

    addPointOfInterest(candidateMatches);
    addPointOfInterestCount(candidateMatches.length);

    List<Marker> markers = candidateMatches.map((pointOfInterest) {
      var marker = Marker(
        point: LatLng(pointOfInterest.lat ?? 0, pointOfInterest.long ?? 0),
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        builder: (ctx) => buildMapMarker(pointOfInterest.id.toString()),
      );
      return marker;
    }).toList();

    addPointOfInterestMarkers(markers);
  }

  @override
  void clearCache() {
    addPointOfInterest(null);
  }

  @override
  void dispose() {
    pointOfInterestController.close();
    _pointOfInterestMarkers.close();
    pointOfInterestCountController.close();
  }
}

final pointOfInterestBloc = PointOfInterestBloc();
