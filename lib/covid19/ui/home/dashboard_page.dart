import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:openspaces/covid19/base_inherited_bloc_provider.dart';
import 'package:openspaces/covid19/bloc/home_bloc.dart';
import 'package:openspaces/covid19/colors.dart';
import 'package:openspaces/covid19/modal/homestat.dart';
import 'package:openspaces/covid19/ui/home/page_faq.dart';
import 'package:openspaces/formdata/widgets/upload_data_screen.dart';
import 'package:openspaces/hospitalmap/screens/map_hospital_screen.dart';

import '../../api.dart';
import '../../common_widgets.dart';
import 'info_page.dart';

class DashboardPage extends StatelessWidget {
  Function medicalFacilityClicked;

  DashboardPage({this.medicalFacilityClicked});

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = HomeBloc();
    return BaseInheritedBlockProvider(
      bloc: homeBloc,
      child: DashboardWidget(
        homeBloc: homeBloc,
        medicalFacilityClicked: medicalFacilityClicked,
      ),
    );
  }
}

class DashboardWidget extends StatefulWidget {
  HomeBloc homeBloc;

  DashboardWidget({this.homeBloc, this.medicalFacilityClicked});

  Function medicalFacilityClicked;

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  List<String> selectorItems = [
    "National",
    "Province No. 1",
    "Province No. 2",
    "Bagmati Pradesh",
    "Gandaki Pradesh",
    "Province No. 5",
    "Karnali Pradesh",
    "Sudurpashchim Pradesh"
  ];
  String selectorItem = "National";

  @override
  void dispose() {
    if (widget.homeBloc != null) {
      widget.homeBloc.dispose();
    }
    super.dispose();
  }

  _getData() {
    if (widget.homeBloc != null) {
      int pos = selectorItems.indexOf(selectorItem);
      print("[dashboard_page][selectedIndex] ========>> $pos");
      widget.homeBloc.getHomeData(province: pos == 0 ? "" : "$pos");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  _statItems(String title, int count, Color color) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.28,
      child: Card(
        elevation: 2.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "$count",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 14.0),
            )
          ],
        ),
      ),
    );
  }

  _dataProgressWidget(String title, int count, int total) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 12.0, color: Colors.grey),
        ),
        SizedBox(
          height: 4.0,
        ),
        Row(
          children: <Widget>[
            RichText(
              text: TextSpan(
                  text: "$count",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                        text: "/$total",
                        style: TextStyle(color: Colors.grey, fontSize: 12.0))
                  ]),
            ),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: LinearProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                value: count == 0 || total == 0 ? 0 : count / total,
              ),
            )
          ],
        )
      ],
    );
  }

  _headSelector() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            "पछिल्लो तथ्यांक",
            style: TextStyle(
                color: Colors.red, fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 16.0,
        ),
      ],
    );
  }

  Widget buildPoliticalFilterDropDown() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      decoration:
          BoxDecoration(border: Border.all(width: 1.0, color: Colors.grey)),
      child: Center(
        child: DropdownButton(
          items: selectorItems
              .map<DropdownMenuItem>((string) => DropdownMenuItem<String>(
                    value: string,
                    child: Text(
                      string,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 14.0),
                    ),
                  ))
              .toList(),
          value: selectorItem,
          onChanged: (value) {
            setState(() {
              selectorItem = value;
              _getData();
            });
          },
        ),
      ),
    );
  }

  _hotlineWidget(String phones, String time, String hotline) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Color.fromRGBO(233, 236, 255, 1)),
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          FlatButton.icon(
              onPressed: () {
              },
              icon: Icon(
                Icons.call,
                color: Colors.red,
              ),
              label: Text("COVID-19 हटलाइन")),
//          Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: List<Widget>.generate(phones.length, (index) {
//                return Text(phones[index],
//                    style: TextStyle(
//                        color: Color.fromRGBO(13, 73, 239, 1),
//                        fontSize: 12.0,
//                        fontWeight: FontWeight.bold));
//              })),
//          SizedBox(
//            height: 8.0,
//          ),
//          Text(time,
//              style: TextStyle(
//                color: Colors.grey,
//                fontSize: 12.0,
//              )),
//          SizedBox(
//            height: 16.0,
//          ),
//          Text("1115",
//              style: TextStyle(
//                  color: Color.fromRGBO(13, 73, 239, 1),
//                  fontSize: 12.0,
//                  fontWeight: FontWeight.bold)),
//          SizedBox(
//            height: 8.0,
//          ),
//          Text(time,
//              style: TextStyle(
//                color: Colors.grey,
//                fontSize: 12.0,
//              )),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(hotline,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(13, 73, 239, 1),
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _getData();
    return StreamBuilder<HomeStat>(
        stream: widget.homeBloc.homeStream,
        builder: (context, snapshot) {
          if (snapshot == null || snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(fontSize: 16.0, color: Colors.red),
              ),
            );
          } else {
            HomeStat homeStat = snapshot.data;
            return Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: _headSelector(),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _statItems("परिक्षण भएको", homeStat.tested,
                              Color.fromRGBO(233, 236, 255, 1)),
                          _statItems(
                              "संक्रमण नदेखिएको",
                              homeStat.tested - homeStat.confirmed,
                              Color.fromRGBO(229, 247, 230, 1)),
                          _statItems("संक्रमण देखिएको", homeStat.confirmed,
                              Color.fromRGBO(255, 235, 236, 1))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _statItems("आइसोलेसनमा", homeStat.isolation,
                              Color.fromRGBO(233, 236, 255, 1)),
                          _statItems(
                              "निको भएको",
                              homeStat.confirmed -
                                  homeStat.death -
                                  homeStat.isolation,
                              Color.fromRGBO(229, 247, 230, 1)),
                          _statItems("मृत्यु भएको", homeStat.death,
                              Color.fromRGBO(255, 235, 236, 1))
                        ],
                      ),
                    ),
//                    SizedBox(
//                      height: 8.0,
//                    ),
//                    Align(
//                      alignment: Alignment.bottomRight,
//                      child: Padding(
//                        padding: const EdgeInsets.only(right: 16.0),
//                        child: RichText(
//                          text: TextSpan(
//                              text: "Last Updated",
//                              style:
//                                  TextStyle(fontSize: 14.0, color: Colors.grey),
//                              children: <TextSpan>[
//                                TextSpan(
//                                    text: " 23/03/2020",
//                                    style: TextStyle(
//                                        color: Colors.black,
//                                        fontWeight: FontWeight.bold,
//                                        fontSize: 12.0))
//                              ]),
//                        ),
//                      ),
//                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    navigationItemSelfAssement(),
                    navigationItemSelfMAP(),
                    navigationItemSelfFAQ(),
                    navigationItemViber(),
                    Divider(
                      height: 1,
                    ),
                    _hotlineWidget(homeStat.hotline, "", homeStat.hotline)
                  ],
                ),
              ),
            );
          }
        });
  }

  Widget navigationItemViber() {
    return GestureDetector(
      onTap: () {
        launchURL(viber);
      },
      child: Container(
        width: double.infinity,
        height: 60.0,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 5.0, color: Color(0x335169ed))],
            color: Color.fromRGBO(233, 236, 255, 1)),
        child: Container(
            padding: EdgeInsets.all(16),
            child: SvgPicture.asset("assets/images/viber_logo.svg")),
      ),
    );
  }

  Widget navigationItems() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[],
            ),
          ),
        ],
      ),
    );
  }

  Widget navigationItemSelfFAQ() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InfoPage()));
      },
      child: Container(
        width: double.infinity,
        height: 180.0,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 5.0, color: Color(0x335169ed))],
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Container(
                height: 60.0,
                width: 60.0,
                child: Image.asset('assets/images/prevention.png')),
            Spacer(),
            Text(
              'उपयोगी जानकारी',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 18.0),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget navigationItemSelfMAP() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MapHospitalScreen()));
      },
      child: Container(
        width: double.infinity,
        height: 180.0,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 5.0, color: Color(0x335169ed))],
            borderRadius: BorderRadius.circular(10.0),
            color: Color.fromRGBO(229, 247, 230, 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Container(
                height: 60.0,
                width: 60.0,
                child: Image.asset('assets/images/map.png')),
            Spacer(),
            Text(
              'नक्शा',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 18.0),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget navigationItemSelfAssement() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UploadDataScreen()));
      },
      child: Container(
        width: double.infinity,
        height: 180.0,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 5.0, color: Color(0x335169ed))],
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Container(
                height: 60.0,
                width: 60.0,
                child: Image.asset('assets/images/assessment.png')),
            Spacer(),
            Text(
              'कोभिड-१९ को लक्षणहरू आफै मूल्यांकन गर्नुहोस्',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 18.0),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget medicalFacilitiesStatus(homeStat) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "MEDICAL FACILITY STATUS",
            style: TextStyle(
                fontSize: 12.0, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8.0,
          ),
          Card(
            color: Colors.white,
            child: ListTile(
              onTap: () {
                if (widget.medicalFacilityClicked != null) {
                  print("[dashboard][medical clicked]");
                  widget.medicalFacilityClicked();
                }
              },
              title: Text(
                "Medical Facilities",
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
              subtitle: Text(
                "${homeStat.facilityCount}",
                style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.navigate_next),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          _dataProgressWidget("ICU in use", homeStat.occupiedIcu, homeStat.icu),
          SizedBox(
            height: 16.0,
          ),
          _dataProgressWidget("Ventilator in use", homeStat.occupiedVentilator,
              homeStat.ventilator),
          SizedBox(
            height: 16.0,
          ),
          _dataProgressWidget("Isolation beds in use",
              homeStat.occupiedVentilator, homeStat.isolation),
        ],
      ),
    );
  }
}
