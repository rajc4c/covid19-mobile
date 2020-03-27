import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openspaces/covid19/colors.dart';

import '../main.dart';

class ReportSubmissionThankYouScreen extends StatelessWidget {
  String result;

  ReportSubmissionThankYouScreen(this.result) {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('EEE d MMM').format(now);
    formattedTime = DateFormat('hh:mm a').format(now);
  }

  String formattedDate;
  String formattedTime;

  static String thankYouReportSubmissionGreenTick =
      "assets/images/thank_you_green_tick_icon.png";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset(
                    thankYouReportSubmissionGreenTick,
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  reportHasBeenSubmittedTextView(result),
                  dateAndTimeWidget(formattedDate, formattedTime),
                ],
              ),
              doneButton(context)
            ],
          )),
    );
  }

  dateAndTimeWidget(String date, String time) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: RichText(
          text: TextSpan(
              // set the default style for the children TextSpans
              style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: date,
                  style: TextStyle(color: Colors.blue),
                ),
                TextSpan(
                  text: ' at ',
                ),
                TextSpan(
                  text: time,
                  style: TextStyle(color: Colors.blue),
                ),
              ]),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  thankYouTextView() {
    return Container(
        margin: EdgeInsets.all(16.0),
        child: Text(
          "THANK YOU!",
          style: TextStyle(
            fontSize: 26.0,
            color: Colors.blue.shade800,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  reportHasBeenSubmittedTextView(String result) {
    return Container(
        margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: Text(
          "Report has been submitted. You have tested ",
          style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal),
        ));
  }

  doneButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        margin: EdgeInsets.only(bottom: 16.0),
        child: MaterialButton(
          height: 50.0,
          minWidth: double.infinity,
          color: OpenSpaceColors.headline_blue,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    HomePage()));
          },
          child: Text(
            "Done".toUpperCase(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
