import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:map_launcher/map_launcher.dart';
import 'package:openspaces/hospitalmap/bloc/point_of_interest_bloc.dart';

import '../../covid19/colors.dart';
import '../../covid19/common_widgets.dart';
import '../repo/point_of_interest.dart';

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
                Text(
                  pointOfInterest.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                showCloseButton
                    ? InkWell(
                        onTap: () {
                          pointOfInterestBloc
                              .updateSelectedPointOfInterest(null);
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
                    : Text(
                        "440 M",
                        style: TextStyle(
                          color: OpenSpaceColors.icon_color,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  pointOfInterest.location ?? "Location Not Avaliable",
                  style: TextStyle(
                      color: OpenSpaceColors.icon_color, fontSize: 14),
                )),
            SizedBox(
              height: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                      text: pointOfInterest.ownershipDisplay,
                      style: TextStyle(color: OpenSpaceColors.icon_color)),
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
}
