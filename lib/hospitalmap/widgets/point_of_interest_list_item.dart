import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openspaces/covid19/colors.dart';

class HeaderText extends StatelessWidget {
  final String title;

  HeaderText({@required this.title});

  Widget buildHeaderText(var title, context, {List<dynamic> items}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RichText(
            text: TextSpan(
                text: 'Medical Facilities',
                style: TextStyle(color: Colors.black, fontSize: 18))),
        DropdownButton<String>(
          items: <String>['National'].map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildHeaderText(title, context);
  }
}
