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
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on Exception {
      print('Failed to get platform version');
    }

    return identifier;
  }
}
