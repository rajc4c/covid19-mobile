import 'dart:collection';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:openspaces/covid19/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static showToastMessage(
      {@required message, Color backgroundColor, Color textColor}) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: backgroundColor ?? OpenSpaceColors.white,
        textColor: textColor ?? OpenSpaceColors.text_color);
  }

  static launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToastMessage(message: "Could not lauch $url");
      throw 'Could not launch $url';
    }
  }

  static Future<String> getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    var identifier = "";
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        print('this is ios');
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on Exception {
      print('Failed to get platform version');
    }

    return identifier;
  }

  static String numberMap(String number) {
    String mappedNumber = "";
    Map map = {"0": "०", "1": '१', "2": '२', "3": '३', "4": '४', "5": '५', "6": '६', "7": '७', "8": '८', "9": '९'};

    for(int i=0; i< number.length; i++){
      String no = map[number[i]];
      mappedNumber = mappedNumber+no;
    }
    return mappedNumber;
  }
}
