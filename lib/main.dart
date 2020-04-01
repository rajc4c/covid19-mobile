import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:openspaces/common/constants.dart';
import 'package:openspaces/covid19/colors.dart';
import 'package:openspaces/covid19/ui/home/info_page.dart';
import 'package:openspaces/covid19/ui/login/login_page.dart';
import 'package:openspaces/covid19/ui/home/page_comming_soon.dart';
import 'package:openspaces/covid19/ui/home/page_faq.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';
import 'package:openspaces/locale/app_localization.dart';
import 'package:package_info/package_info.dart';

import 'common/utils.dart';
import 'covid19/api.dart';
import 'covid19/common_widgets.dart';
import 'covid19/ui/home/dashboard_page.dart';
import 'covid19/ui/page_about.dart';
import 'dashboard/dashboard_page_v2.dart';
import 'formdata/widgets/upload_data_screen.dart';
import 'hospitalmap/screens/map_hospital_screen.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AppLocalizationDelegate _localeOverrideDelegate =
      AppLocalizationDelegate(Locale('en', 'US'));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        _localeOverrideDelegate
      ],
      supportedLocales: [const Locale('en', 'US'), const Locale('np', 'NP')],
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedBottomNavigationIndex = 0;

  int navDrawerId = 0;

  Future<void> checkForAppUpdate() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    http.get(get_mobile_version).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> config =
            jsonDecode(utf8.decode(response.bodyBytes));
        print(config.toString());

        int currentVersion = int.parse(info.version.replaceAll(".", ""));
        int latestVersion = int.parse(config["version_name"]);
        if (latestVersion > currentVersion) {
          updateDialog(context,
              title: config["app_name"],
              message: config["version_info"],
              actions: [
                FlatButton(
                  child: Text('Update now'),
                  onPressed: () {
                    Utils.launchURL(config["alert_link"]);
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        }
      }
    });
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void pageChanged(int index) {
    setState(() {
      _selectedBottomNavigationIndex = index;
    });
  }

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      physics: new NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
//        DashboardPage(
//          medicalFacilityClicked: () {
//            print("[home][medical facilities clicked]");
//            pageController.animateToPage(1,
//                duration: Duration(milliseconds: 300), curve: Curves.ease);
//          },
//        ),
        DashBoardPageV2(),
        MapHospitalScreen(),
        SymtomsForm(),
        InfoPage()
      ],
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   //checkForAppUpdate();
  // }

  _openCommingSoonPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CommingSoonPage()));
  }

  _mDrawer() {
    return Drawer(
      child: Container(
        color: OpenSpaceColors.white,
        height: MediaQuery.of(context).size.height,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                logo(),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1.0,
                  color: Colors.grey,
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: navDrawerId == NavDrawerIds.latestUpdateId?OpenSpaceColors.blue_transparent:OpenSpaceColors.white,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child:
                      ListTile(
                        dense: true,
                        leading:  Icon(
                          Icons.report,
                          color: navDrawerId == NavDrawerIds.latestUpdateId?OpenSpaceColors.blue:Colors.grey,
                        ),
                        title:  Text(
                          "पछिल्लो तथ्यांक",
                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                        ),
                        onTap: (){
                          navDrawerId = NavDrawerIds.latestUpdateId;
                          setState(() {
                          });
                        },

                      )
                      ),

                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: navDrawerId == NavDrawerIds.healthFacilitiesId?OpenSpaceColors.blue_transparent:OpenSpaceColors.white,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child:
                      ListTile(
                        dense: true,
                        leading:  Icon(
                          Icons.local_hospital,
                          color: navDrawerId == NavDrawerIds.healthFacilitiesId?OpenSpaceColors.blue:Colors.grey,
                        ),
                        title:  Text(
                          "स्वास्थ्य सेवाहरु",
                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                        ),
                        onTap: (){
                          setState(() {
                            navDrawerId = NavDrawerIds.healthFacilitiesId;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapHospitalScreen()));
                          });
                        },

                      )
                      ),

                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: navDrawerId == NavDrawerIds.selfTestId?OpenSpaceColors.blue_transparent:OpenSpaceColors.white,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child:
                      ListTile(
                        dense: true,
                        leading:  Icon(
                          Icons.help,
                          color: navDrawerId == NavDrawerIds.selfTestId?OpenSpaceColors.blue:Colors.grey,
                        ),
                        title:  Text(
                          "लक्षण मुल्यांकन",
                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                        ),
                        onTap: (){
                          setState(() {
                            navDrawerId = NavDrawerIds.selfTestId;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SymtomsForm()));
                          });
                        },

                      )
                      ),

                    ],
                  ),
                ),


//
//             FlatButton.icon(
//                    onPressed: () {
//                      _openCommingSoonPage();
//                    },
//                    icon: Icon(
//                      Icons.web,
//                      color: Colors.red,
//                    ),
//                    label: Text(
//                      "Track me",
//                      style: TextStyle(color: Colors.grey),
//                    )),
//             FlatButton.icon(
//                    onPressed: () {
//                      _openCommingSoonPage();
//                    },
//                    icon: Icon(
//                      Icons.web,
//                      color: Colors.red,
//                    ),
//                    label: Text(
//                      "Emergency Contacts",
//                      style: TextStyle(color: Colors.grey),
//                    )),

//              FlatButton.icon(
//                    onPressed: () {
//                      _openCommingSoonPage();
//                    },
//                    icon: Icon(
//                      Icons.info,
//                      color: Colors.red,
//                    ),
//                    label: Text(
//                      "कोरोनाका लक्षणहरु",
//                      style: TextStyle(color: Colors.grey),
//                    )),

              Container(
                color: Colors.grey.shade400,
                height: 1.0,
              ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: navDrawerId == NavDrawerIds.faqId?OpenSpaceColors.blue_transparent:OpenSpaceColors.white,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child:
                      ListTile(
                        dense: true,
                        leading:  Icon(
                          Icons.question_answer,
                          color: navDrawerId == NavDrawerIds.faqId?OpenSpaceColors.blue:Colors.grey,
                        ),
                        title:  Text(
                          "धेरे सोधिने प्रश्नहरु",
                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                        ),
                        onTap: (){
                          setState(() {
                            navDrawerId = NavDrawerIds.faqId;
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) => FaqPage()));
                          });
                        },

                      )
                      ),

                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: navDrawerId == NavDrawerIds.aboutAppId?OpenSpaceColors.blue_transparent:OpenSpaceColors.white,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child:
                      ListTile(
                        dense: true,
                        leading:  Icon(
                          Icons.info_outline,
                          color: navDrawerId == NavDrawerIds.aboutAppId?OpenSpaceColors.blue:Colors.grey,
                        ),
                        title:  Text(
                          "एपको बारेमा",
                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                        ),
                        onTap: (){
                          setState(() {
                            navDrawerId = NavDrawerIds.aboutAppId;
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => AboutUsPage()));
                          });
                        },

                      )
                      ),

                    ],
                  ),
                ),







//             FlatButton.icon(
//                    onPressed: () {},
//                    icon: Icon(
//                      Icons.web,
//                      color: Colors.red,
//                    ),
//                    label: Text(
//                      "Login",
//                      style: TextStyle(color: Colors.grey),
//                    )),

//               FlatButton.icon(
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => LocaleChangeTest()),
//                      );
//                    },
//                    icon: Icon(
//                      Icons.language,
//                      color: Colors.red,
//                    ),
//                    label: Text(
//                      "Language Change",
//                      style: TextStyle(color: Colors.grey),
//                    )),

//            Spacer(flex: 1,),
//              Divider(
//                height: 1,
//                color: Colors.grey,
//              ),
//
//              ListTile(
//                leading: Image.asset(
//                  'assets/images/gov_logo.png',
//                  fit: BoxFit.cover,
//                  height: 48.0,
//                  width: 48.0,
//                ),
//                title: Text(
//                  "Government of Nepal",
//                  style: TextStyle(color: Colors.blue, fontSize: 14.0),
//                ),
//                subtitle: Text(
//                  "Ministry of Health and Population",
//                  style: TextStyle(
//                      color: Colors.red,
//                      fontSize: 16.0,
//                      fontWeight: FontWeight.bold),
//                ),
//              ),
//              SizedBox(
//                height: 16.0,
//              )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: OpenSpaceColors.red,
              ),
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 48.0),
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(child:
                  FlatButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      icon: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                      ),
                      label: Text(
                        "लग इन",
                        style: TextStyle(color: Colors.white),
                      )),
                  ),

                ],
              ),
            ),
          ],
        )


      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: covidAppBar(),
      body: buildPageView(),
      drawer: _mDrawer(),
    );
  }

  buildBottomBar() {
    return BottomNavigationBar(
      currentIndex: _selectedBottomNavigationIndex,
      onTap: (index) {
        setState(() {
          _selectedBottomNavigationIndex = index;
          pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        });
      },
      selectedItemColor: Color.fromRGBO(239, 25, 25, 1),
      unselectedItemColor: Colors.grey,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital), title: Text("Facilities")),
        BottomNavigationBarItem(
            icon: Icon(Icons.report), title: Text("Report")),
        BottomNavigationBarItem(icon: Icon(Icons.info), title: Text("Info"))
      ],
    );
  }
}
