import 'package:flutter/material.dart';
import 'package:openspaces/covid19/base_inherited_bloc_provider.dart';
import 'package:openspaces/covid19/bloc/home_bloc.dart';
import 'package:openspaces/covid19/modal/homestat.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = HomeBloc();
    return BaseInheritedBlockProvider(
      bloc: homeBloc,
      child: DashboardWidget(homeBloc: homeBloc,),
    );
  }
}

class DashboardWidget extends StatefulWidget {
  HomeBloc homeBloc;
  DashboardWidget({ this.homeBloc });
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  List<String> selectorItems = ["National", "Province No. 1",
    "Province No. 2",
    "Bagmati Pradesh",
    "Gandaki Pradesh",
    "Province No. 5",
    "Karnali Pradesh",
    "Sudurpashchim Pradesh"];
  String selectorItem = "National";
  @override
  void dispose() {
    if (widget.homeBloc != null) {
      widget.homeBloc.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    if (widget.homeBloc != null) {
      widget.homeBloc.getHomeData(province: "1");
    }
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
            "LATEST SITUATION REPORT",
            style: TextStyle(
                color: Colors.red, fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 16.0,
        ),
        Container(
          width: 120.0,
          decoration:
              BoxDecoration(border: Border.all(width: 1.0, color: Colors.grey)),
          child: Center(
            child: DropdownButton(
              items: selectorItems
                  .map<DropdownMenuItem>((string) => DropdownMenuItem<String>(
                        value: string,
                        child: Text(
                          string,
                          style: TextStyle(color: Colors.blue, fontSize: 14.0),
                        ),
                      ))
                  .toList(),
              value: selectorItem,
              onChanged: (value) {
                setState(() {
                  selectorItem = value;
                });
              },
            ),
          ),
        )
      ],
    );
  }

  _hotlineWidget(List<String> phones, String time) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Color.fromRGBO(233, 236, 255, 1)),
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          FlatButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.call,
                color: Colors.red,
              ),
              label: Text("COVID-19 Hotline")),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List<Widget>.generate(phones.length, (index) {
                return Text(phones[index],
                    style: TextStyle(
                        color: Color.fromRGBO(13, 73, 239, 1),
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold));
              })),
          SizedBox(
            height: 8.0,
          ),
          Text(time,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              )),
          SizedBox(
            height: 16.0,
          ),
          Text("1115",
              style: TextStyle(
                  color: Color.fromRGBO(13, 73, 239, 1),
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 8.0,
          ),
          Text(time,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: _headSelector(),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _statItems("Tested", homeStat.tested,
                              Color.fromRGBO(233, 236, 255, 1)),
                          _statItems(
                              "Negative",
                              homeStat.tested - homeStat.confirmed,
                              Color.fromRGBO(229, 247, 230, 1)),
                          _statItems("Positive", homeStat.confirmed,
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
                          _statItems("Isolated", homeStat.isolation,
                              Color.fromRGBO(233, 236, 255, 1)),
                          _statItems(
                              "Recovered",
                              homeStat.confirmed -
                                  homeStat.death -
                                  homeStat.isolation,
                              Color.fromRGBO(229, 247, 230, 1)),
                          _statItems("Deaths", homeStat.death,
                              Color.fromRGBO(255, 235, 236, 1))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: RichText(
                          text: TextSpan(
                              text: "Last Updated",
                              style:
                                  TextStyle(fontSize: 14.0, color: Colors.grey),
                              children: <TextSpan>[
                                TextSpan(
                                    text: " 23/03/2020",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0))
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(220, 220, 220, 1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "MEDICAL FACILITY STATUS",
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Card(
                            color: Colors.white,
                            child: ListTile(
                              title: Text(
                                "Medical Facilities",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.grey),
                              ),
                              subtitle: Text(
                                "120",
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
                          _dataProgressWidget(
                              "ICU in use", homeStat.occupiedIcu, homeStat.icu),
                          SizedBox(
                            height: 16.0,
                          ),
                          _dataProgressWidget("Ventilator in use",
                              homeStat.occupiedVentilator, homeStat.ventilator),
                          SizedBox(
                            height: 16.0,
                          ),
                          _dataProgressWidget("Isolation beds in use",
                              homeStat.occupiedVentilator, homeStat.isolation),
                        ],
                      ),
                    ),
                    _hotlineWidget(homeStat.phones, homeStat.time)
                  ],
                ),
              ),
            );
          }
        });
  }
}
