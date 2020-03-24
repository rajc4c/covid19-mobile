import 'package:flutter_map/flutter_map.dart';

import '../../general_assement_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../base_inherited_bloc_provider.dart';
import '../open_space_repository.dart';
import 'open_space.dart';

class OpenSpaceBloc extends BaseBloc {
  final _openSpaceV2 = BehaviorSubject<List<OpenSpaceWithAssessment>>();

  Observable<List<OpenSpaceWithAssessment>> get getOpenSpaceV2 =>
      _openSpaceV2.stream;

  @override
  dispose() {
    _openSpaceV2.close();
    _openSpaceController.close();

    _geoJsonMarkerController.close();
    _geoJsonPolygonController.close();
  }

  final _geoJsonPolygonController = PublishSubject<List<Polygon>>();
  final _geoJsonMarkerController = PublishSubject<List<Marker>>();
  final _latLngBounds = PublishSubject<LatLngBounds>();

  Observable<List<Polygon>> get _geoJsonPolygon =>
      _geoJsonPolygonController.stream;

  Observable<LatLngBounds> get _getLatLngBounds => _latLngBounds.stream;

  Observable<List<Marker>> get _geoJsonMarker =>
      _geoJsonMarkerController.stream;

  Stream<DataLayer> get geoJsonLayer => Observable.combineLatest3(
          _geoJsonPolygon, _geoJsonMarker, _getLatLngBounds,
          (List<Polygon> foo, List<Marker> bar, LatLngBounds bounds) {
        return DataLayer(foo, bar, null, bounds);
      }).asBroadcastStream();

  Future<void> fetchOpenSpacesV2(
      {forceLoadFromCache = false, query = ""}) async {
    var data = await generalAssessmentRepository.fetchOpenSpaceWithAssessment(
      forceLoadFromCache: forceLoadFromCache,
      openSpaceQuery: query,
    );

    _openSpaceV2.sink.add(data);
  }

  @override
  void clearCache() {
    // TODO: implement clearCache
  }

  final _openSpaceController = PublishSubject<List<OpenSpace>>();

  dynamic getOpenSpace({forceLoadFromCache = false, zoomLevel = 0}) async {
    String filterString = "";

    await openSpaceRepository.fetchOpenSpaceGeoJSON(
        _geoJsonPolygonController,
        _geoJsonMarkerController,
        _openSpaceController,
        _latLngBounds,
        filterString,
        forceLoadFromCache,
        zoomLevel: zoomLevel,
        openSpaceIds: <int>[]);
  }
}

class DataLayer {
  DataLayer(this.polygons, this.markers, this.openSpaces, this.bounds);

  List<Polygon> polygons;
  List<Marker> markers;
  List<OpenSpaceWithAssessment> openSpaces;
  LatLngBounds bounds;
}

final openSpaceBloc = OpenSpaceBloc();
