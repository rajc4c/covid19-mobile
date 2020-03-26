
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:openspaces/covid19/colors.dart';
import 'package:openspaces/covid19/geo.dart';
import 'package:openspaces/hospitalmap/bloc/point_of_interest_bloc.dart';
import 'package:snapping_sheet/snapping_sheet.dart';


import '../repo/point_of_interest.dart';
import 'package:latlong/latlong.dart';

class PlaceListItem extends StatelessWidget {
  PlaceListItem(this.pointOfInterest, {this.showCloseButton: false});

  final PointOfInterest pointOfInterest;
  final showCloseButton;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        color: OpenSpaceColors.listItemBackground,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    pointOfInterest.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
                showCloseButton
                    ? InkWell(
                        onTap: () {
                          pointOfInterestBloc
                              .updateSelectedPointOfInterest(null);
                          pointOfInterestBloc.updateBottomSheetSnapPosition(
                              SnapPosition(positionFactor: 0.8));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: Icon(
                            Icons.clear,
                            size: 32,
                            color: OpenSpaceColors.icon_color,
                          ),
                        ),
                      )
                    : StreamBuilder(
                        stream: pointOfInterestBloc.getCurrentUserLocationCache,
                        builder: ((context, AsyncSnapshot<LatLng> snapshot) {
                          var textFormatted = "Not Available";

                          if (snapshot.hasData) {
                            double distance = calcApproxDistance(
                                snapshot.data,
                                LatLng(
                                  pointOfInterest.lat,
                                  pointOfInterest.long,
                                ),
                                formatText: false);

                            textFormatted = calcApproxDistance(
                                snapshot.data,
                                LatLng(
                                    pointOfInterest.lat, pointOfInterest.long));

                            pointOfInterest.distanceFromCurrentLocation =
                                distance;
                          }

                          return Text(
                            textFormatted,
                            style: TextStyle(
                              color: OpenSpaceColors.icon_color,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          );
                        }),
                      ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  pointOfInterest.categoryName,
                  style: TextStyle(
                      color: OpenSpaceColors.icon_color, fontSize: 14),
                )),
            SizedBox(
              height: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: RichText(
                    maxLines: 3,
                    text: TextSpan(
                        text: pointOfInterest.municipalityName,
                        children: [
                          TextSpan(text: ", "),
                          TextSpan(text: pointOfInterest.districtName),
                          TextSpan(text: ", "),
                          TextSpan(text: pointOfInterest.provinceName)
                        ],
                        style: TextStyle(color: OpenSpaceColors.icon_color)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    launchInMaps(pointOfInterest);
                  },
                  child: Icon(
                    Icons.directions,
                    size: 32,
                    color: OpenSpaceColors.icon_color,
                  ),
                )
              ],
            ),
          ],
        ));
  }

  void launchInMaps(PointOfInterest pointOfInterest) async {
    final availableMaps = await MapLauncher.installedMaps;
    availableMaps.first.showMarker(
      description: "",
      coords: Coords(pointOfInterest.lat, pointOfInterest.long),
      title: pointOfInterest.name,
    );
  }



  Widget rightSection() {
    return FloatingActionButton(
        heroTag: null,
        mini: true,
        elevation: 0.0,
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.directions,
              size: 16.0,
            ),
            Text(
              "GO",
              style: TextStyle(fontSize: 10),
            )
          ],
        ));
  }
}
