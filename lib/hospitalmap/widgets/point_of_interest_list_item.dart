import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openspaces/covid19/colors.dart';
import 'package:openspaces/covid19/common_widgets.dart';
import 'package:openspaces/hospitalmap/bloc/point_of_interest_bloc.dart';

class HeaderText extends StatefulWidget {
  final String title;

  HeaderText({@required this.title});

  @override
  _HeaderTextState createState() => _HeaderTextState();
}

class _HeaderTextState extends State<HeaderText> {
  String _selectedValue;

  Widget buildHeaderText(var title, context, {List<dynamic> items}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        StreamBuilder(
          stream: pointOfInterestBloc.pointOfInterestsCount,
          builder: ((context, AsyncSnapshot<int> snapshot) {
            Widget noDataLayout = buildProgressAndNoData(context, snapshot);
            if (noDataLayout != null) {
              return Container(height: 20, width: 20, child: noDataLayout);
            }
            return RichText(
                text: TextSpan(
                    text: 'Medical Facilities'.toUpperCase(),
                    children: [
                      TextSpan(text: '  '),
                      TextSpan(
                          text: snapshot.data.toString(),
                          style: TextStyle(
                              color: OpenSpaceColors.black, fontSize: 18)),
                    ],
                    style: TextStyle(
                        color: OpenSpaceColors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)));
          }),
        ),
        DropdownButton<String>(
          items: <String>['National'].map((String value) {
            return DropdownMenuItem<String>(
              value: _selectedValue,
              child: Text(
                value,
                style: TextStyle(color: OpenSpaceColors.blue),
              ),
            );
          }).toList(),
          onChanged: (selectedValue) {
            _selectedValue = selectedValue;
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildHeaderText(widget.title, context);
  }
}
