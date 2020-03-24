import 'package:flutter/material.dart';

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
      home: DashboardPage(),
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
            SizedBox(width: 16.0,),
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
                    _statItems("Tested", 573, Color.fromRGBO(233, 236, 255, 1)),
                    _statItems(
                        "Negative", 573, Color.fromRGBO(229, 247, 230, 1)),
                    _statItems(
                        "Positive", 573, Color.fromRGBO(255, 235, 236, 1))
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
                    _statItems("Isolated", 1, Color.fromRGBO(233, 236, 255, 1)),
                    _statItems(
                        "Recovered", 0, Color.fromRGBO(229, 247, 230, 1)),
                    _statItems("Deaths", 0, Color.fromRGBO(255, 235, 236, 1))
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
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16.0),
                decoration:
                    BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1)),
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
                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
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
                    SizedBox(height: 16.0,),
                    _dataProgressWidget("ICU in use", 1, 2),
                    SizedBox(
                      height: 16.0,
                    ),
                    _dataProgressWidget("Ventilator in use", 200, 980),
                    SizedBox(
                      height: 16.0,
                    ),
                    _dataProgressWidget("Isolation beds in use", 300, 400)
                  ],
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
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital), title: Text("Hospital")),
          BottomNavigationBarItem(icon: Icon(Icons.info), title: Text("info"))
        ],
      ),
    );
  }
}
