import 'package:flutter/material.dart';
import 'package:openspaces/covid19/colors.dart';

dataProgressWidget(String title, {@required int count, @required int total}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 12.0, color: OpenSpaceColors.grey),
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
            SizedBox(
              width: 32.0,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 10,
                  child: LinearProgressIndicator(
                    backgroundColor: Color(0xffEEEEEE),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(OpenSpaceColors.red),
                    value: count == 0 || total == 0 ? 0 : count / total,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}
