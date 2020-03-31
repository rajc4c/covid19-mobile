import 'package:flutter/material.dart';
import 'package:openspaces/covid19/colors.dart';

AppBar covidAppBar() {
  return AppBar(
    backgroundColor: OpenSpaceColors.white,
    centerTitle: true,
    elevation: 1,
    iconTheme: IconThemeData(color: Colors.black),
    title: Text(
      "प्राय सोधिने प्रश्नहरु",
      style: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
          color: Color(0xffee1919)),
    ),
  );
}
