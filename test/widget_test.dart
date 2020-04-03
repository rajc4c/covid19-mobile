// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openspaces/covid19/api.dart';

import 'package:openspaces/main.dart';

void main() {
  test("url test", () {
    expect("https://covidapi.naxa.com.np/api/v1", base_url);
  });
}
