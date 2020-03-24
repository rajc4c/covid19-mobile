import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:openspaces/covid19/base_inherited_bloc_provider.dart';
import 'package:openspaces/covid19/colors.dart';
import 'package:openspaces/covid19/common_widgets.dart';
import 'package:openspaces/hospitalmap/bloc/point_of_interest_bloc.dart';
import 'package:openspaces/hospitalmap/repo/point_of_interest.dart';
import 'package:openspaces/hospitalmap/widgets/data_progress_list_item.dart';
import 'package:openspaces/hospitalmap/widgets/point_of_interest_list_item.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:user_location/user_location.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import '../widgets/PlaceListItem.dart';
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
      print(sheetPosition.toString());
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
            sheetAbove: Align(
              alignment: Alignment(-0.90, 0.90),
              child: InkWell(
                  onTap: () async {
                    var destZoom = 15.0;
                    var _location = Location();
                    await _location.requestPermission();
                    await _location.requestService();

                    var destLocation = await pointOfInterestBloc
                        .getCurrentUserLocationCache.first
                        .catchError((error, stacktrace) {
                      print(stacktrace);
                    });

                    animatedMapMove(
                        destLocation, destZoom, _mapController, this);
                  },
                  child: buildLocationZoomWidget()),
            ),
            grabbingHeight: 25.0,
            sheetBelow: Container(
                color: OpenSpaceColors.white,
                child: StreamBuilder(
                  stream: pointOfInterestBloc.getSelectedPointOfInterest,
                  builder: ((context, AsyncSnapshot<PointOfInterest> snapshot) {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      child: snapshot.hasData
                          ? buildDetail(snapshot.data)
                          : buildListWithSearch(),
                    );
                  }),
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
          pointOfInterestBloc
              .updateSelectedPointOfInterest(pointOfInterestItem);
        },
        child: PlaceListItem(pointOfInterestItem),
      );
    }).toList();
  }

  Widget searchField() {
    final TextEditingController _controller = new TextEditingController();

    return TextFormField(
      controller: _controller,
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
        suffixIcon: InkWell(
          child: Icon(Icons.close),
          onTap: () {
            _controller.clear();
            pointOfInterestBloc.addUserSearchText("");
          },
        ),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget buildLocationZoomWidget() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
      child: Icon(
        Icons.my_location,
        color: OpenSpaceColors.icon_color_highligted,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        border: Border.all(color: OpenSpaceColors.border_color),
        color: OpenSpaceColors.selected_color,
      ),
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
        TileLayerOptions(
          urlTemplate: "https://api.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token=pk.eyJ1Ijoibml5byIsImEiOiJjazEwNnh4YTcwMmtpM2N0ODVqNm0xcWg1In0.afnQfiPu4aHjy21HTjR5mA",
          additionalOptions: {
            'accessToken':
                'pk.eyJ1Ijoibml5byIsImEiOiJjazg2MXQ3dDcwYnV5M2hvMDczZngzYnp1In0.NyqS4tYUyY57XL478VOHqw',
            'id': 'mapbox.outdoors',
          },
        ),
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
          onLocationUpdate: (LatLng currentLocation) {
            pointOfInterestBloc.updateCurrentLocationCache(currentLocation);
          },
          context: context,
          mapController: _mapController,
          markers: locationMarkers,
          showMoveToCurrentLocationFloatingActionButton: false,
          updateMapLocationOnPositionChange: false,
          zoomToCurrentLocationOnLoad: true,
          fabBottom: 20,
          fabRight: 16,
        ),
      ],
    );
  }

  void animatedMapMove(
      LatLng destLocation, double destZoom, _mapController, vsync) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final _latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: vsync);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  Widget buildListWithSearch() {
    return CustomScrollView(
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
              Widget noDataLayout = buildProgressAndNoData(context, snapshot);

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
    );
  }

  Widget buildDetail(PointOfInterest data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          PlaceListItem(
            data,
            showCloseButton: true,
          ),
          dataProgressWidget("ICU in use",
              count: data.numOfIcuBed, total: data.occupiedIcuBed),
          dataProgressWidget("Ventilators in use",
              count: data.numOfVentilators, total: data.occupiedVentilators),
          dataProgressWidget("Isolation beds in use",
              count: data.occupiedIsolationBed, total: data.numOfIsolationBed),
          Padding(
            padding: EdgeInsets.all(16),
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(16),
                color: OpenSpaceColors.button_red,
                child: Center(
                  child: Text(
                    "EDIT DATA",
                    style: TextStyle(
                        color: OpenSpaceColors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
