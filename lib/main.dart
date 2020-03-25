import 'package:flutter/material.dart';
import 'package:openspaces/covid19/ui/home/page_comming_soon.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:openspaces/covid19/ui/home/page_faq.dart';
import 'package:openspaces/covid19/ui/home/info_page.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';

import 'covid19/ui/home/dashboard_page.dart';
import 'formdata/widgets/upload_data_screen.dart';
import 'hospitalmap/screens/map_hospital_screen.dart';

void main() {
  Stetho.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        DashboardPage(medicalFacilityClicked: (){
          pageController.animateToPage(1,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        },),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/corona.png",
              height: 32.0,
              width: 32.0,
            ),
            title: Text(
              "COVID-19",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            subtitle: RichText(
              text: TextSpan(
                  text: "Case Mapping",
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  children: <TextSpan>[
                    TextSpan(
                        text: " NEPAL",
                        style: TextStyle(fontSize: 12.0, color: Colors.blue))
                  ]),
            ),
          ),
          Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          FlatButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.file_upload,
                color: Colors.red,
              ),
              label: Text(
                "Latest Situation",
                style: TextStyle(color: Colors.grey),
              )),
          FlatButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.info,
                color: Colors.red,
              ),
              label: Text(
                "Medical Facilities",
                style: TextStyle(color: Colors.grey),
              )),
          FlatButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.web,
                color: Colors.red,
              ),
              label: Text(
                "Report Symptoms",
                style: TextStyle(color: Colors.grey),
              )),
          FlatButton.icon(
              onPressed: () {
                _openCommingSoonPage();
              },
              icon: Icon(
                Icons.web,
                color: Colors.red,
              ),
              label: Text(
                "Track me",
                style: TextStyle(color: Colors.grey),
              )),
          FlatButton.icon(
              onPressed: () {
                _openCommingSoonPage();
              },
              icon: Icon(
                Icons.web,
                color: Colors.red,
              ),
              label: Text(
                "Emergency Contacts",
                style: TextStyle(color: Colors.grey),
              )),
          FlatButton.icon(
              onPressed: () {
                _openCommingSoonPage();
              },
              icon: Icon(
                Icons.web,
                color: Colors.red,
              ),
              label: Text(
                "Corona Symptoms",
                style: TextStyle(color: Colors.grey),
              )),
          FlatButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => FaqPage()));
              },
              icon: Icon(
                Icons.web,
                color: Colors.red,
              ),
              label: Text(
                "FAQ",
                style: TextStyle(color: Colors.grey),
              )),
          FlatButton.icon(
              onPressed: () {
                _openCommingSoonPage();
              },
              icon: Icon(
                Icons.web,
                color: Colors.red,
              ),
              label: Text(
                "About the app",
                style: TextStyle(color: Colors.grey),
              )),
          FlatButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.web,
                color: Colors.red,
              ),
              label: Text(
                "Login",
                style: TextStyle(color: Colors.grey),
              )),
          Spacer(
            flex: 1,
          ),
          Divider(height: 1, color: Colors.grey,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Associated With", style: TextStyle(color: Colors.grey, height: 1),),
          ),
          SizedBox(height: 8.0,),
          ListTile(
            leading: Image.asset(
              'assets/images/gov_logo.png',
              fit: BoxFit.cover,
              height: 48.0,
              width: 48.0,
            ),
            title: Text(
              "Government of Nepal",
              style: TextStyle(color: Colors.blue, fontSize: 14.0),
            ),
            subtitle: Text(
              "Ministry of Health and Population",
              style: TextStyle(color: Colors.red, fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16.0,),
        ],
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
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}
