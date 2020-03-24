import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:openspaces/covid19/api.dart';
import 'package:openspaces/covid19/base_inherited_bloc_provider.dart';
import 'package:openspaces/covid19/colors.dart';
import 'package:openspaces/covid19/common_widgets.dart';
import 'package:openspaces/hospitalmap/bloc/point_of_interest_bloc.dart';
import 'package:openspaces/hospitalmap/repo/point_of_interest.dart';
import 'package:openspaces/hospitalmap/repo/point_of_interest_repository.dart';
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
  SnappingSheetController _snappingSheetController;
  List<Marker> locationMarkers = [];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _snappingSheetController = SnappingSheetController();
    pointOfInterestBloc.fetchHealthFacilities();

    sheetPositionObserver();
  }

  void sheetPositionObserver() {
    pointOfInterestBloc.getBottomSheetSnapPosition.where((sheetPosition) {
      return sheetPosition != null;
    }).listen((sheetPosition) {
      _snappingSheetController.snapToPosition(sheetPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseInheritedBlockProvider(
      bloc: pointOfInterestBloc,
      child: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: pointOfInterestBloc.pointOfInterestMarkers,
            builder: ((context, AsyncSnapshot<List<Marker>> snapshot) {
              Widget progressNoData = buildProgressAndNoData(context, snapshot);
              if (progressNoData != null) {
                return progressNoData;
              }
              return buildMap(snapshot.data);
            }),
          ),
          SnappingSheet(
            snappingSheetController: _snappingSheetController,
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
                      sliver: StreamBuilder(
                        stream: pointOfInterestBloc.pointOfInterests,
                        builder: ((BuildContext buildContext,
                            AsyncSnapshot<List<PointOfInterest>> snapshot) {
                          Widget noDataLayout =
                              buildProgressAndNoData(context, snapshot);

                          if (noDataLayout != null) {
                            return SliverToBoxAdapter(
                              child: noDataLayout,
                            );
                          }

                          return SliverList(
                            delegate: SliverChildListDelegate(
                                buildHospitalListItem(snapshot.data)),
                          );
                        }),
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
//      ),
      ),
    );
  }

  List<Widget> buildHospitalListItem(
      List<PointOfInterest> pointOfInterestItems) {
    return pointOfInterestItems.map((pointOfInterestItem) {
      return InkWell(
        onTap: () {
          pointOfInterestBloc.updateBottomSheetSnapPosition(

            SnapPosition(positionFactor: 1),
          );
        },
        child: PlaceListItem(pointOfInterestItem),
      );
    }).toList();
  }

  Widget searchField() {
    return TextFormField(
      onTap: () {
        pointOfInterestBloc
            .updateBottomSheetSnapPosition(SnapPosition(positionFactor: 1));
      },
      onChanged: ((text) {
        pointOfInterestBloc.addUserSearchText(text);
      }),
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

  Widget buildLocationZoomWidget() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
      child: Icon(
        Icons.location_searching,
        color: OpenSpaceColors.icon_color,
      ),
      decoration:
          BoxDecoration(color: Colors.white, boxShadow: [defaultBoxShadow()]),
    );
  }

  Widget buildMap(List<Marker> markers) {
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
        MarkerClusterLayerOptions(
          maxClusterRadius: 120,
          size: Size(40, 40),
          fitBoundsOptions: FitBoundsOptions(
            padding: EdgeInsets.all(50),
          ),
          markers: markers != null ? markers : [],
          polygonOptions: PolygonOptions(
              borderColor: OpenSpaceColors.transparent,
              color: OpenSpaceColors.transparent,
              borderStrokeWidth: 1),
          builder: (context, markers) {
            return FloatingActionButton(
              backgroundColor: OpenSpaceColors.green,
              child: Text(markers.length.toString()),
              onPressed: null,
              heroTag: null,
            );
          },
        ),
        UserLocationOptions(
          moveToCurrentLocationFloatingActionButton: buildLocationZoomWidget(),
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
