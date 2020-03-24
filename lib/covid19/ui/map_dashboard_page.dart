import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:openspaces/covid19/bloc/open_space_bloc.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:user_location/user_location.dart';

import '../../PlaceListItem.dart';
import '../../custom_line.dart';
import '../../general_assement_repository.dart';
import '../base_inherited_bloc_provider.dart';
import '../colors.dart';
import '../common_widgets.dart';
import 'package:latlong/latlong.dart';


class MapDashboard extends StatefulWidget {
  @override
  _MapDashboardState createState() => _MapDashboardState();
}

class _MapDashboardState extends State<MapDashboard> {
  var _mapBoxId;

  @override
  void initState() {
    super.initState();
    openSpaceBloc.fetchOpenSpacesV2();
    openSpaceBloc.getOpenSpace();

    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseInheritedBlockProvider(
        bloc: openSpaceBloc,
        child: Scaffold(
          key: _scaffoldKey,
          body: buildBodyWidgets(context),
        ));
  }

  SnappingSheetController sheetController = SnappingSheetController();

  Widget buildBodyWidgets(context) {
    return Stack(
      children: <Widget>[
        buildMapWithStream(),
        buildTopGradient(),
        buildNavMenu(context),
//        buildTabBar(false),
        SnappingSheet(
          snapPositions: const [
            SnapPosition(positionPixel: 0.0),
            SnapPosition(positionFactor: 0.3),
            SnapPosition(positionFactor: 0.8),
          ],
          snappingSheetController: sheetController,
          grabbingHeight: 20.0,
          sheetBelow: Card(child: openSpaceList(null)),
          sheetAbove: Align(
              alignment: Alignment(0.92, 0.95),
              child: Wrap(
                direction: Axis.vertical,
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.spaceAround,
                children: <Widget>[
                  InkWell(onTap: () async {}, child: buildLocationZoomWidget()),
                  buildLayerWidget(),
//                  buildFilterWidget(context),
                ],
              )),
          grabbing: Container(
            child: Center(
              child: CustomPaint(
                painter: DrawHorizontalLine(OpenSpaceColors.icon_color),
              ),
            ),
          ),
        )
      ],
    );
  }

  MapController _mapController;

  Widget buildMapWithStream() {
    return StreamBuilder(
        stream: openSpaceBloc.geoJsonLayer,
        builder: (BuildContext context, dataLayer) {
          var widget = buildProgressAndNoData(context, dataLayer);

          if (!dataLayer.hasData) {
            return widget;
          }

          return buildMapWithRoute(
              dataLayer.data.polygons,
              dataLayer.data.markers,
              dataLayer.data.bounds,
              _mapBoxId,
              _mapController,
              context,
              openSpaceBloc,
              null,
              locationZoomWidget: buildLocationZoomWidget(),
              poiMarkers: null,
              selectedRoute: null);
        });
  }

  Widget buildMapWithRoute(
      List<Polygon> polygonSnapshot,
      List<Marker> markersSnapshot,
      LatLngBounds bounds,
      mapboxId,
      MapController _mapController,
      context,
      _openSpaceBloc,
      List<Polyline> route,
      {locationZoomWidget,
      poiMarkers,
      selectedRoute}) {
    List<Marker> markers = [];

    // https://gis.stackexchange.com/questions/244788/map-ids-to-add-mapbox-basemaps-to-leaflet-or-openlayers/244797

    print(selectedRoute);
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        interactive: true,
        center:
            bounds != null ? bounds.northEast : LatLng(27.700769, 85.300140),
        zoom: 6,
        plugins: [
          MarkerClusterPlugin(),
          UserLocationPlugin()
        ],
      ),
      layers: [
        new TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        PolygonLayerOptions(
            polygonCulling: true,
            polygons: polygonSnapshot != null ? polygonSnapshot : List()),
        PolylineLayerOptions(polylines: route != null ? route : <Polyline>[]),
        PolylineLayerOptions(
            polylines: selectedRoute != null ? [selectedRoute] : <Polyline>[]),
        MarkerLayerOptions(markers: markers),
        MarkerClusterLayerOptions(
          maxClusterRadius: 120,
          size: Size(40, 40),
          fitBoundsOptions: FitBoundsOptions(
            padding: EdgeInsets.all(50),
          ),
          markers: markersSnapshot != null ? markersSnapshot : [],
          polygonOptions: PolygonOptions(
              borderColor: OpenSpaceColors.transparent,
              color: OpenSpaceColors.transparent,
              borderStrokeWidth: 1),
          builder: (context, markers) {
            return FloatingActionButton(
              child: Text(markers.length.toString()),
              onPressed: null,
              heroTag: null,
            );
          },
        ),
        MarkerClusterLayerOptions(
          maxClusterRadius: 120,
          size: Size(40, 40),
          fitBoundsOptions: FitBoundsOptions(
            padding: EdgeInsets.all(50),
          ),
          markers: poiMarkers != null ? poiMarkers : [],
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
          context: context,
          mapController: _mapController,
          markers: markers,
          showMoveToCurrentLocationFloatingActionButton: false,
          updateMapLocationOnPositionChange: false,
          moveToCurrentLocationFloatingActionButton: locationZoomWidget,
          zoomToCurrentLocationOnLoad: true,
          fabBottom: 150,
          fabRight: 16,
        ),
      ],
    );
  }

  Widget buildLayerWidget() {
    return PopupMenuButton(
      elevation: 2,
      child: buildMapUiIcon(Icon(
        Icons.layers,
        color: OpenSpaceColors.icon_color,
      )),
      itemBuilder: (_) => <PopupMenuItem<String>>[
        CheckedPopupMenuItem<String>(
            checked: _mapBoxId == 'mapbox.satellite',
            child: Text('Satellite'),
            value: 'mapbox.satellite'),
        CheckedPopupMenuItem<String>(
            checked: _mapBoxId == 'mapbox.outdoors',
            child: Text('Street'),
            value: 'mapbox.outdoors'),
        CheckedPopupMenuItem<String>(
            checked: _mapBoxId == 'mapbox.streets-satellite',
            child: Text('Hybrid'),
            value: 'mapbox.streets-satellite'),
      ],
      onSelected: (value) {
        _mapBoxId = value;
      },
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget openSpaceList(ScrollController scrollController) {
    return StreamBuilder(
      stream: openSpaceBloc.getOpenSpaceV2,
      builder: (context, snapshot) {
        var widget = buildProgressAndNoData(context, snapshot);
        if (widget != null) {
          return widget;
        }

        return buildOpenSpacesList(snapshot.data, scrollController, context);
      },
    );
  }

  Widget buildOpenSpacesList(List<OpenSpaceWithAssessment> openSpaces,
      ScrollController scrollController, context) {
    return CustomScrollView(
      primary: false,
      physics: const BouncingScrollPhysics(),
      controller: scrollController,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 10,
            ),
            buildHeaderText("Open spaces: ", context, items: openSpaces),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
          ]),
        ),
        SliverList(
          delegate: SliverChildListDelegate(buildOpenSpaceItem(openSpaces)),
        )
      ],
    );
  }

  List<Widget> buildOpenSpaceItem(List<OpenSpaceWithAssessment> openSpaces) {
    return [];
//    return openSpaces.map((openSpace) {
//      return InkWell(
//        onTap: () {},
//        child: PlaceListItem(openSpace, ),
//      );
//    }).toList();
  }

  Widget buildHeaderText(var title, context,
      {List<dynamic> items, showCount: true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.subhead,
        ),
        showCount
            ? Text(items != null ? "${items.length}" : "0",
                style: TextStyle(
                    color: OpenSpaceColors.headline_blue,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900))
            : Container()
      ],
    );
  }
}
