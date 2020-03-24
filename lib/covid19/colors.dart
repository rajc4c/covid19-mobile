import 'package:flutter/material.dart';
// https://stackoverflow.com/questions/50081213/how-do-i-use-hexadecimal-color-strings-in-flutter

class OpenSpaceColors {
  static final Color red = Color(0xffEF1919);
  static final Color blue = headline_blue;
  static final Color blue_transparent = headline_blue.withOpacity(0.3);

  static Color headline_blue = Color(0xff174BDD);
  static const Color transparent = Color(0x00000000);
  static const Color gradient_bottom = Color(0xFFFFFF);
  static var inactive_tab_text = Color(0xffBDBDBD);
  static var inactive_progress = inactive_tab_text;
  static var slider_pull_line = inactive_tab_text;

  static final Color grey = Colors.grey;
  static final Color green = Color(0xff5ACE52);
  static final Color light_green = Color(0xffE8F8E7);
  static final Color green_transparent = Color(0xff5ACE52).withOpacity(0.3);
  static final Color white = Colors.white;
  static final Color icon_color = Color(0xff7C7C7C);

  static final yellow = Colors.orangeAccent;

  static var searchFillColor = Color(0xffF5F5F5);
  static var searchBorderColor = Color(0xffDCDCDC);

  static var black = Color(0xff333333);

  static var listItemBackground = Color(0xffF5F5F5);

  static var selected_color = Color(0xffE9ECFF);
  static var icon_color_highligted = headline_blue;

  static var border_color = Color(0xffDCDCDC);

  static var button_red = Color(0xffFFEBEC);
}

class DimenConstants {
  static final EdgeInsetsGeometry mediumPadding = EdgeInsets.all(16);
}
