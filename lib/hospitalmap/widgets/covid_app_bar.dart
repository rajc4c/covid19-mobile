import 'package:flutter/material.dart';
import 'package:openspaces/covid19/colors.dart';

AppBar covidAppBarOld() {
  return AppBar(
    backgroundColor: OpenSpaceColors.white,
    centerTitle: true,
    elevation: 1,
    iconTheme: IconThemeData(color: Colors.black),
    title: Image.asset(
      "assets/images/nepal_logo.png",
      height: 50.0,
      width: 50.0,
    ),
  );
}

AppBar covidAppBar() {
  return AppBar(
      backgroundColor: OpenSpaceColors.white,
      centerTitle: true,
      elevation: 1,
      iconTheme: IconThemeData(color: Colors.black),
      title: logo());
}

Widget logo() {
  return ListTile(
    leading: Image.asset(
      "assets/images/nepal_logo.png",
      height: 38.0,
      width: 38.0,
    ),
    title: Text(
      "हाम्रो स्वास्थ्य",
      style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
    ),
  );
}
