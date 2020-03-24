import 'package:flutter/material.dart';

import 'covid19/ui/home/dashboard_page.dart';
import 'hospitalmap/screens/map_hospital_screen.dart';

void main() => runApp(MyApp());

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
      physics:new NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        DashboardPage(),
        MapHospitalScreen(),
        Container()
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }
  _mDrawer() {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height*0.05,),
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
          Divider(height: 1.0, color: Colors.grey,),

          FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.file_upload, color: Colors.red,),
              label: Text(
                "Upload data",
                style: TextStyle(color: Colors.grey),
              )),

          FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.info, color: Colors.red,),
              label: Text(
                "About Us",
                style: TextStyle(color: Colors.grey),
              )),
          FlatButton.icon(
              onPressed: () {

              },
              icon: Icon(Icons.web, color: Colors.red,),
              label: Text(
                "WHO website",
                style: TextStyle(color: Colors.grey),
              ))
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: ListTile(
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
      ),
      body: buildPageView(),
      drawer: _mDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomNavigationIndex,
        onTap: (index) {
          setState(() {
            _selectedBottomNavigationIndex = index;
            pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
          });
        },
        selectedItemColor: Color.fromRGBO(239, 25, 25, 1),
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital), title: Text("Hospital")),
          BottomNavigationBarItem(icon: Icon(Icons.info), title: Text("info"))
        ],
      ),
    );
  }
}



