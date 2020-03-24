import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:openspaces/covid19/colors.dart';
import 'package:openspaces/hospitalmap/repo/point_of_interest.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';
import 'package:openspaces/hospitalmap/widgets/point_of_interest_list_item.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:user_location/user_location.dart';
import 'package:latlong/latlong.dart';

import '../../PlaceListItem.dart';
import '../../custom_line.dart';

class MapHospitalScreen extends StatefulWidget {
  @override
  _MapHospitalScreenState createState() => _MapHospitalScreenState();
}

class _MapHospitalScreenState extends State<MapHospitalScreen> {
  MapController _mapController;
  List<Marker> locationMarkers = [];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: covidAppBar(),
      body: Stack(
        children: <Widget>[
          buildMap(),
          SnappingSheet(
            snapPositions: const [
              SnapPosition(positionPixel: 0.0),
              SnapPosition(positionFactor: 0.3),
              SnapPosition(positionFactor: 1),
            ],
            grabbingHeight: 25.0,
            sheetBelow: Container(
                color: OpenSpaceColors.white,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverPadding(
                      padding: EdgeInsets.all(16.0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          HeaderText(
                            title: "Medical Facilities",
                          ),
                          searchField(),
                        ]),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.all(16.0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                            buildHospitalListItem([PointOfInterest("XYZ")])),
                      ),
                    )
                  ],
                )),
            grabbing: Container(
              color: OpenSpaceColors.white,
              child: Center(
                child: CustomPaint(
                  painter: DrawHorizontalLine(OpenSpaceColors.icon_color),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildHospitalListItem(
      List<PointOfInterest> pointOfInterestItems) {
    return pointOfInterestItems.map((pointOfInterestItem) {
      return InkWell(
        onTap: () {},
        child: PlaceListItem(pointOfInterestItem),
      );
    }).toList();
  }

  Widget searchField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: OpenSpaceColors.searchFillColor,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(4.0),
          borderSide: new BorderSide(),
        ),
        labelText: 'Search',
        suffixIcon: Icon(Icons.close),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget buildMap() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        interactive: true,
        center: LatLng(27.700769, 85.300140),
        zoom: 6,
        plugins: [MarkerClusterPlugin(), UserLocationPlugin()],
      ),
      layers: [
        new TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        UserLocationOptions(
          context: context,
          mapController: _mapController,
          markers: locationMarkers,
          showMoveToCurrentLocationFloatingActionButton: false,
          updateMapLocationOnPositionChange: false,
          zoomToCurrentLocationOnLoad: true,
          fabBottom: 150,
          fabRight: 16,
        ),
      ],
    );
  }
}
