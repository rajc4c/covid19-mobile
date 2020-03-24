import 'package:flutter/material.dart';
import 'package:openspaces/covid19/colors.dart';

AppBar covidAppBar() {
  return AppBar(
    backgroundColor: OpenSpaceColors.white,
    centerTitle: true,
    elevation: 1,
    iconTheme: IconThemeData(color: Colors.black),
    title: Image.asset(
      "assets/images/app_bar_logo.png",
      height: 50.0,
      width: 200.0,
    ),
  );
}
