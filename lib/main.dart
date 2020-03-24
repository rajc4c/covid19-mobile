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
    return Container();
  }
}

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  List<String> selectorItems = ["National", "Province"];
  String selectorItem = "National";

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
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      color: color,
      child: Column(
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
    );
  }

  _headSelector() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            "LATEST SITUATION REPORT",
            style: TextStyle(color: Colors.red, fontSize: 16.0),
          ),
        ),
        SizedBox(
          width: 24.0,
        ),
        DropdownButton(
          items: selectorItems
              .map<DropdownMenuItem>((string) => DropdownMenuItem<String>(
                    value: string,
                    child: Text(string),
                  ))
              .toList(),
          value: selectorItem,
          onChanged: (value) {
            setState(() {
              selectorItem = value;
            });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                text: "Case Mapping", style: TextStyle(fontSize: 14.0, color: Colors.grey), children: <TextSpan>[
                  TextSpan( text: "NEPAL", style: TextStyle( fontSize: 14.0, color: Colors.blue))
            ]),
          ),
        ),
      ),
    );
  }
}
