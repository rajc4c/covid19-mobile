import 'package:flutter/material.dart';

import 'hospitalmap/screens/map_hospital_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid 19',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapHospitalScreen(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DashboardWidget();
  }
}

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  List<String> selectorItems = ["National", "Province"];
  String selectorItem = "National";
  int _selectedBottomNavigationIndex = 0;

  _mDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.file_upload),
              label: Text(
                "Upload data",
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      drawer: _mDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _headSelector(),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _statItems("Tested", 573, Color.fromRGBO(233, 236, 255, 1)),
                  _statItems("Negative", 573, Color.fromRGBO(229, 247, 230, 1)),
                  _statItems("Positive", 573, Color.fromRGBO(255, 235, 236, 1))
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _statItems("Isolated", 1, Color.fromRGBO(233, 236, 255, 1)),
                  _statItems("Recovered", 0, Color.fromRGBO(229, 247, 230, 1)),
                  _statItems("Deaths", 0, Color.fromRGBO(255, 235, 236, 1))
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: RichText(
                  text: TextSpan(
                      text: "Last Updated",
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      children: <TextSpan>[
                        TextSpan(
                            text: " 23/03/2020",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0))
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomNavigationIndex,
        onTap: (index) {
          setState(() {
            _selectedBottomNavigationIndex = index;
          });
        },
        selectedItemColor: Color.fromRGBO(239, 25, 25, 1),
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital), title: Text("Hospital")),
          BottomNavigationBarItem(icon: Icon(Icons.info), title: Text("info"))
        ],
      ),
    );
  }
}
