import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:openspaces/covid19/api.dart';
import 'package:openspaces/covid19/base_inherited_bloc_provider.dart';
import 'package:openspaces/covid19/bloc/home_bloc.dart';
import 'package:openspaces/covid19/common_widgets.dart';
import 'package:openspaces/covid19/modal/global_stat.dart';
import 'package:openspaces/covid19/modal/homestat.dart';
import 'package:openspaces/covid19/ui/home/info_page.dart';
import 'package:openspaces/formdata/widgets/upload_data_screen.dart';
import 'package:openspaces/hospitalmap/screens/map_hospital_screen.dart';

class DashBoardPageV2 extends StatefulWidget {
  @override
  _DashBoardPageV2State createState() => _DashBoardPageV2State();
}

class _DashBoardPageV2State extends State<DashBoardPageV2> {
  _DashBoardPageV2State() {
    homeBloc.globalData();
    homeBloc.getHomeData(province: "");
  }

  @override
  Widget build(BuildContext context) {
    return BaseInheritedBlockProvider(
      bloc: homeBloc,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: '',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: 'कोभिड-१९ ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22)),
                        TextSpan(
                            text: 'तथ्याङ्क', style: TextStyle(fontSize: 22)),
                      ],
                    ),
                  ),
                ),
              ),
              worldStats(),
              localStats(),
              Container(
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xffeeeeee),
                ),
                padding: EdgeInsets.all(20),
                constraints:
                    BoxConstraints.expand(width: double.infinity, height: 282),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(
                            top: 15, bottom: 15),
                        child: ListTile(
                          title: Text(
                            "कोभिड-१९ को लक्षणहरु आफै मुल्यांकन गर्नुहोस्",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: Image(
                            image:
                            AssetImage('assets/images/Mask Group 17.png'),
                            width: 52,
                            height: 52,
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right,
                              color: Colors.black),
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UploadDataScreen()));
                          },
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapHospitalScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.only(
                              left: 18, top: 15, right: 10, bottom: 15),
                          constraints: BoxConstraints.expand(
                              width: double.infinity, height: 70),
                          child: Row(children: <Widget>[
                            Image(
                              image:
                                  AssetImage('assets/images/Mask Group 18.png'),
                              width: 52,
                              height: 52,
                            ),
                            Text(
                              "नक्सा हेर्नुहोस्",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_right,
                                color: Colors.black)
                          ]),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoPage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.only(
                              left: 18, top: 15, right: 10, bottom: 15),
                          constraints: BoxConstraints.expand(
                              width: double.infinity, height: 70),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Image(
                                  image: AssetImage(
                                      'assets/images/Mask Group 19.png'),
                                  width: 52,
                                  height: 52,
                                ),
                                Text(
                                  "उपयोगी जानकारी",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Icon(Icons.keyboard_arrow_right,
                                    color: Colors.black),
                              ]),
                        ),
                      )
                    ]),
              ),
              Container(
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xffe9ecff),
                ),
                padding: EdgeInsets.all(20),
                constraints:
                    BoxConstraints.expand(width: double.infinity, height: 213),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        launchURL(viber);
                      },
                      child: Image(
                        image: AssetImage('assets/images/Viber.png'),
                        width: 61.17,
                        height: 28.71,
                      ),
                    ),
                    Text("MOHP Nepal COVID-19",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                    SizedBox(
                      height: 26,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.call, color: Colors.red),
                          Text(
                            "कोभिड-१९ हटलाईन",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                    RichText(
                      text: TextSpan(
                        text: '',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: '9851-255-834',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => launchCaller("9851255834"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.blue)),
                          TextSpan(
                              text: ' | ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12)),
                          TextSpan(
                              text: '9851-255-837',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => launchCaller("9851255837"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.blue)),
                          TextSpan(
                              text: ' | ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12)),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => launchCaller("9851255839"),
                              text: '9851-255-839',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.blue)),
                        ],
                      ),
                    ),
                    Text("(8am-8pm)"),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        launchCaller("1115");
                      },
                      child: Text("1115",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.blue)),
                    ),
                    Text("(6am-10pm)")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget worldStats() {
    return StreamBuilder(
        stream: homeBloc.globalStatStream,
        builder: (context, snapshot) {
          Widget noDataWidget = buildProgressAndNoData(context, snapshot);
          if (noDataWidget != null) {
            return Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(height: 20, width: 20, child: noDataWidget));
          }

          GlobalStat gs = snapshot.data;
          return Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Icon(
                    Icons.language,
                    color: Colors.black,
                  ),
                  Text(" विश्वभरीमा",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontWeight: FontWeight.bold))
                ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${gs.totalConfirmed}",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff0d49ef))),
                            Text(
                              "संक्रमित",
                              style: TextStyle(fontSize: 11),
                              textAlign: TextAlign.left,
                            )
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${gs.totalRecovered}",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff00ad13))),
                            Text(
                              "निको भएको",
                              style: TextStyle(fontSize: 11),
                              textAlign: TextAlign.left,
                            )
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${gs.totalDeaths}",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffef1919))),
                            Text(
                              "मृत्यु भएको",
                              style: TextStyle(fontSize: 11),
                              textAlign: TextAlign.left,
                            )
                          ]),
                    ]),
              ],
            ),
          );
        });
  }

  Widget localStats() {
    return StreamBuilder(
        stream: homeBloc.homeStream,
        builder: (context, snapshot) {
          Widget noDataWidget = buildProgressAndNoData(context, snapshot);
          if (noDataWidget != null) {
            return Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Container(height: 20, width: 20, child: noDataWidget));
          }

          HomeStat homeStat = snapshot.data;
          return Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("नेपालको पछिल्लो तथ्याङ्क",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xffe9ecff),
                          ),
                          padding: EdgeInsets.only(left: 15, top: 6),
                          constraints:
                              BoxConstraints.expand(width: 105.0, height: 60.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("${homeStat.tested}",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.black)),
                              Text(
                                "परीक्षण गरीएको",
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.left,
                              )
                            ],
                          )),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xffe5f7e6),
                          ),
                          padding: EdgeInsets.only(left: 15, top: 6),
                          constraints:
                              BoxConstraints.expand(width: 105.0, height: 60.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("${homeStat.tested - homeStat.confirmed}",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.black)),
                              Text(
                                "संक्रमण नदेखिएको",
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.left,
                              )
                            ],
                          )),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xffffebec),
                          ),
                          padding: EdgeInsets.only(left: 15, top: 6),
                          constraints:
                              BoxConstraints.expand(width: 105.0, height: 60.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  "${homeStat.confirmed - homeStat.death - homeStat.isolation}",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.black)),
                              Text(
                                "संक्रमण देखिएको",
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xffe9ecff),
                        ),
                        padding: EdgeInsets.only(left: 15, top: 6),
                        constraints:
                            BoxConstraints.expand(width: 105.0, height: 60.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${homeStat.isolation}",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.black)),
                            Text(
                              "आइसोलेसनमा",
                              style: TextStyle(fontSize: 11),
                              textAlign: TextAlign.left,
                            )
                          ],
                        )),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xffe5f7e6),
                        ),
                        padding: EdgeInsets.only(left: 15, top: 6),
                        constraints:
                            BoxConstraints.expand(width: 105.0, height: 60.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "${homeStat.confirmed - homeStat.death - homeStat.isolation}",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.black)),
                            Text(
                              "निको भएको",
                              style: TextStyle(fontSize: 11),
                              textAlign: TextAlign.left,
                            )
                          ],
                        )),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xffffebec),
                        ),
                        padding: EdgeInsets.only(left: 15, top: 6),
                        constraints:
                            BoxConstraints.expand(width: 105.0, height: 60.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${homeStat.death}",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.black)),
                            Text(
                              "मृत्यु भएको",
                              style: TextStyle(fontSize: 11),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ))
                  ],
                ),
              ],
            ),
          );
        });
  }
}
