import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openspaces/covid19/geo.dart';
import 'package:openspaces/hospitalmap/bloc/point_of_interest_bloc.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../../covid19/colors.dart';
import '../../covid19/common_widgets.dart';
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
                              SnapPosition(positionFactor: 1));
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
                Icon(
                  Icons.directions,
                  size: 32,
                  color: OpenSpaceColors.icon_color,
                )
              ],
            ),
          ],
        ));
  }

  Widget leftSection() {
    return buildNetworkCacheImageWidget("openSpace.thumbnail", 70.0, 70.0);
  }

  Widget middleSection(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        // color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            middleUpperSection(context),
            Expanded(
              child: Container(
                height: 10.0,
              ),
            ),
            middleLowerSection(context),
          ],
        ),
      ),
    ));
  }

  Widget middleUpperSection(BuildContext context) {
    return Container(
      // color: Colors.blue,
      child: Text(
        getSafeString(pointOfInterest.name),
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget middleLowerSection(BuildContext buildContext) {
    return Container(
      // color: Colors.amber,
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 20.0,
                    color: OpenSpaceColors.grey,
                  ),
                  Text(
                    getSafeString("openSpace.address"),
                    style: Theme.of(buildContext).textTheme.body1,
                  )
                ],
              ),

              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 20.0,
                    color: OpenSpaceColors.grey,
                  ),
                  StreamBuilder(
                      stream: null,
                      builder: (context, snapshot) {
                        var text = "Not Available";

//                        if (snapshot.hasData) {
//                          text = calcApproxDistance(
//                              snapshot.data,
//                              LatLng(openSpace.centroid[1],
//                                  openSpace.centroid[0]));
//
//                          openSpace.distanceFromCurrentLocation = text;
//                        }

                        return Text(
                          text,
                          style: Theme.of(buildContext).textTheme.body1,
                        );
                      })
                ],
              ),
//              Row(
//                children: <Widget>[
//                  Icon(
//                    Icons.map,
//                    size: 20.0,
//                  ),
//                  Text(
//                    "200m",
//                    style: TextStyle(fontSize: 13.0, color: OspColors.grey),
//                  )
//                ],
//              )
            ],
          )
        ],
      ),
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
