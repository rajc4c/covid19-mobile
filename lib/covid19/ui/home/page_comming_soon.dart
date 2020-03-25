import 'package:flutter/material.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';

class CommingSoonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: covidAppBar(),
        body: Center(
            child: Container(
      child: Text(
        "Under development, will be available soon",
        textAlign: TextAlign.center,
      ),
    )));
  }
}
