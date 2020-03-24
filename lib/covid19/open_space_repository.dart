import 'dart:async';
import 'dart:convert';

import 'package:flutter_map/flutter_map.dart';
import 'package:geojson/geojson.dart';
import 'package:openspaces/covid19/repository/base_repository.dart';
import 'package:rxdart/rxdart.dart';

import 'api.dart';
import 'bloc/open_space.dart';
import 'bloc/open_space_bloc.dart';
import 'colors.dart';
import 'common_widgets.dart';
import 'geo.dart';
import 'package:latlong/latlong.dart';

class OpenSpaceRepository extends BaseRepository {
  bool doesNotContain = false;

  Future<List<OpenSpace>> fetchOpenSpace({forceLoadFromCache = true}) {
    return fetchItem(get_open_space, forceLoadFromCache: forceLoadFromCache)
        .then((response) {
      var json = jsonDecode(response);
      List<OpenSpace> openSpaces = mapJsonToOpenSpace(json);

      return openSpaces;
    });
  }

  Future<List<Polygon>> fetchOpenSpaceGeoJSON(
      PublishSubject<List<Polygon>> geoJsonController,
      PublishSubject<List<Marker>> geoJsonMarkerController,
      PublishSubject<List<OpenSpace>> openSpaceController,
      PublishSubject<LatLngBounds> latLngBounds,
      String filterQuery,
      forceLoadFromCache,
      {zoomLevel = 0,
      openSpaceIds}) {
    return fetchItem(get_open_space_geo_json,
            forceLoadFromCache: forceLoadFromCache)
        .then((geoJSON) {
      if (geoJSON.isEmpty) {
        geoJsonController.sink.addError("Can't parse geojson");
        geoJsonMarkerController.sink.addError("Can't parse geojson");
        openSpaceController.sink.addError("Can't parse geojson");
        latLngBounds.sink.addError("Can't parse geojson");
      }

      var result = parseAndDrawAssetsOnMap(
          geoJSON,
          geoJsonController,
          geoJsonMarkerController,
          openSpaceController,
          latLngBounds,
          filterQuery,
          zoomLevel: zoomLevel,
          openSpaceIds: openSpaceIds);

      return result;
    });
  }

  Future<List<OpenSpace>> searchOpenSpace() {
    return fetchItem(get_open_space, forceLoadFromCache: true).then((response) {
      var json = jsonDecode(response);
      return mapJsonToOpenSpace(json);
    });
  }

  Future<List<Polygon>> parseAndDrawAssetsOnMap(
      String geojson,
      PublishSubject<List<Polygon>> geoJsonController,
      PublishSubject<List<Marker>> geoJsonMarkerController,
      PublishSubject<List<OpenSpace>> openSpaceController,
      PublishSubject<LatLngBounds> latLngBounds,
      String filterQuery,
      {zoomLevel,
      List<int> openSpaceIds}) async {
    final features = await featuresFromGeoJson(geojson, verbose: false);

    final List<Polygon> polygonsPoints = [];
    final List<Marker> markerPoints = [];
    List<OpenSpace> openSpaces = [];
    LatLngBounds bounds = LatLngBounds();

    latLngBounds.sink.add(null);
    openSpaceController.sink.add(null);
    geoJsonMarkerController.sink.add(null);
    geoJsonController.sink.add(null);
    bool shouldBuildPolygon;

    if (zoomLevel == null) {
      shouldBuildPolygon = false;
    } else {
      shouldBuildPolygon = zoomLevel >= 14;
    }

    Set<int> openSpaceIdsToIgnore = Set();
    List<int> politicalFilteredOpenSpaces = [];
    for (final feature in features.collection) {
      final geom = feature.geometry as GeoJsonMultiPolygon;
      OpenSpace openSpace = OpenSpace.fromJson(feature.properties);

      bool doestNotMatch =
          !openSpace.title.toLowerCase().contains(filterQuery.toLowerCase());

      if (doestNotMatch) {
        continue;
      }

      if (openSpaceIds != null &&
          openSpaceIds.isNotEmpty &&
          !openSpaceIds.contains(int.parse(openSpace.id))) {
        continue;
      }

      for (final geoJsonPolygon in geom.polygons) {
        List<List<LatLng>> points = geoJsonPolygon.geoSeries.map((geo) {
          return geo.toLatLng();
        }).toList();

        List<LatLng> polygonLatLng = [];
        for (List<LatLng> list in points) {
          polygonLatLng.addAll(list);
        }

        bool markerDoesNotExist =
            !openSpaceIdsToIgnore.contains(int.parse(openSpace.id));

        if (markerDoesNotExist) {
          openSpace.center = computeCentroid(polygonLatLng);
          var marker = Marker(
            point: openSpace.center,
            anchorPos: AnchorPos.align(AnchorAlign.center),
            height: 30,
            width: 30,
            builder: (ctx) => buildMapMarker(openSpace.id),
          );
          markerPoints.add(marker);
          openSpaceIdsToIgnore.add(int.parse(openSpace.id));
        }

        var polygon = Polygon(
            points: polygonLatLng,
            color: OpenSpaceColors.green_transparent,
            borderColor: OpenSpaceColors.green,
            borderStrokeWidth: 2.0);

        if (shouldBuildPolygon) {
          polygonsPoints.add(polygon);
        }

        politicalFilteredOpenSpaces.add(int.parse(openSpace.id));
        openSpaces.add(openSpace);
      }

      for (Marker marker in markerPoints) {
        bounds.extend(marker.point);
      }

      latLngBounds.sink.add(bounds);
      openSpaceController.sink.add(openSpaces);
      geoJsonMarkerController.sink.add(markerPoints);
      geoJsonController.sink.add(polygonsPoints);
    }

    await openSpaceBloc.fetchOpenSpacesV2(
        );
  }

  List<OpenSpace> mapJsonToOpenSpace(json) {
    List<OpenSpace> open_spaces = (json as List).map((i) {
      return OpenSpace.fromJson(i);
    }).toList();
    return open_spaces;
  }
}

OpenSpaceRepository openSpaceRepository = OpenSpaceRepository();
