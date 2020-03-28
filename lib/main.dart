import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:openspaces/covid19/ui/home/info_page.dart';
import 'package:openspaces/covid19/ui/login/login_page.dart';
import 'package:openspaces/covid19/ui/home/page_comming_soon.dart';
import 'package:openspaces/covid19/ui/home/page_faq.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';
import 'package:openspaces/locale/app_localization.dart';

import 'covid19/ui/home/dashboard_page.dart';
import 'covid19/ui/page_about.dart';
import 'formdata/widgets/upload_data_screen.dart';
import 'hospitalmap/screens/map_hospital_screen.dart';

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
        DashboardPage(
          medicalFacilityClicked: () {
            print("[home][medical facilities clicked]");
            pageController.animateToPage(1,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          },
        ),
        MapHospitalScreen(),
        UploadDataScreen(),
        InfoPage()
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  _openCommingSoonPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CommingSoonPage()));
  }



  _mDrawer() {
    return Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.05,
              ),
              logo(),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 1.0,
                color: Colors.grey,
              ),
               FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.report,
                      color: Colors.red,
                    ),
                    label: Text(
                      "पछिल्लो तथ्यांक",
                      style: TextStyle(color: Colors.grey),
                    )),
          FlatButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MapHospitalScreen()));
                    },
                    icon: Icon(
                      Icons.local_hospital,
                      color: Colors.red,
                    ),
                    label: Text(
                      "स्वास्थ्य सेवाहरु",
                      style: TextStyle(color: Colors.grey),
                    )),

              FlatButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UploadDataScreen()));
                    },
                    icon: Icon(
                      Icons.help,
                      color: Colors.red,
                    ),
                    label: Text(
                      "लक्षण मुल्यांकन",
                      style: TextStyle(color: Colors.grey),
                    )),
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

             FlatButton.icon(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => FaqPage()));
                    },
                    icon: Icon(
                      Icons.question_answer,
                      color: Colors.red,
                    ),
                    label: Text(
                      "धेरे सोधिने प्रश्नहरु",
                      style: TextStyle(color: Colors.grey),
                    )),

              FlatButton.icon(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.red,
                  ),
                  label: Text(
                    "लग इन",
                    style: TextStyle(color: Colors.grey),
                  )),

             FlatButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()));
                    },
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.red,
                    ),
                    label: Text(
                      "एपको बारेमा",
                      style: TextStyle(color: Colors.grey),
                    )),

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
