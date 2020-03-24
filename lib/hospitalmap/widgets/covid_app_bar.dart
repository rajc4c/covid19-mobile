import 'package:flutter/material.dart';

AppBar covidAppBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    centerTitle: true,
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
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
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
  );
}
