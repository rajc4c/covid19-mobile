import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:openspaces/covid19/colors.dart';
import 'package:openspaces/hospitalmap/screens/map_hospital_screen.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';

class DashboardV2 extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}


class _DashboardState extends State<DashboardV2> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    MapHospitalScreen(),
    MapHospitalScreen(),
    MapHospitalScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  final List<String> _title = ['', '', ''];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: covidAppBar(),
      body: _children[_currentIndex],
      bottomNavigationBar:
          covidBottomBar(currentIndex: _currentIndex, onTap: onTabTapped),
    );
  }

  covidBottomBar({int currentIndex, void Function(int index) onTap}) {
    return BottomNavigationBar(
      elevation: 5.0,
      selectedItemColor: OpenSpaceColors.white,
      unselectedItemColor: OpenSpaceColors.red,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
            title: Text("React"), icon: Icon(Icons.thumbs_up_down)),
        BottomNavigationBarItem(title: Text("Inbox"), icon: Icon(Icons.inbox)),
        BottomNavigationBarItem(
            title: Text("Proile"), icon: Icon(Icons.person)),
      ],
      backgroundColor: OpenSpaceColors.white,
      currentIndex: currentIndex,
    );
  }
}
