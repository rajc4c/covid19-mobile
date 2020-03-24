import 'dart:math' show cos, sin, acos;

import 'package:latlong/latlong.dart';

var pi =
    3.141592653589793238462643383279502884197169399375105820974944592307816406286;

dynamic calcApproxDistance(LatLng pointA, LatLng pointB, {formatText = true}) {
  return _distance(
      pointA.latitude, pointA.longitude, pointB.latitude, pointB.longitude, "K",
      formatText: formatText);
}

// As taken from https://stackoverflow.com/a/57526185
dynamic _distance(
    double lat1, double lon1, double lat2, double lon2, String unit,
    {formatText}) {
  double theta = lon1 - lon2;
  double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
      cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
  dist = acos(dist);
  dist = rad2deg(dist);
  dist = dist * 60 * 1.1515;
  if (unit == 'K') {
    dist = dist * 1.609344;
  } else if (unit == 'N') {
    dist = dist * 0.8684;
  }
  if (unit == "K" && formatText) {
    return "approx ${dist.toStringAsFixed(2)} km";
  } else if (unit == "K" && !formatText) {
    return dist;
  }
  return dist.toStringAsFixed(2);
}

double deg2rad(double deg) {
  return (deg * pi / 180.0);
}

double rad2deg(double rad) {
  return (rad * 180.0 / pi);
}

LatLng computeCentroid(List<LatLng> points) {
  double latitude = 0;
  double longitude = 0;
  int n = points.length;

  for (LatLng point in points) {
    latitude += point.latitude;
    longitude += point.longitude;
  }

  return LatLng(latitude / n, longitude / n);
}
