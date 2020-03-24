import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import 'covid19/colors.dart';
import 'covid19/common_widgets.dart';
import 'covid19/geo.dart';
import 'general_assement_repository.dart';

class PlaceListItem extends StatelessWidget {
  PlaceListItem(this.openSpace, this.scaffoldKey);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final OpenSpaceWithAssessment openSpace;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
      height: 70.0,
      child: Row(
        children: <Widget>[
          leftSection(),
          middleSection(context),
          rightSection(),
        ],
      ),
    );
  }

  Widget leftSection() {
    return buildNetworkCacheImageWidget(openSpace.thumbnail, 70.0, 70.0);
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
        getSafeString(openSpace.title),
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
                    getSafeString(openSpace.address),
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

                        if (snapshot.hasData) {
                          text = calcApproxDistance(
                              snapshot.data,
                              LatLng(openSpace.centroid[1],
                                  openSpace.centroid[0]));

                          openSpace.distanceFromCurrentLocation = text;
                        }

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
