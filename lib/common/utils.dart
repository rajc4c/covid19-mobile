import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:openspaces/covid19/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static showToastMessage({@required message, Color backgroundColor, Color textColor}) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: backgroundColor??OpenSpaceColors.white,
        textColor: textColor??OpenSpaceColors.text_color);
  }

  static launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToastMessage(message: "Could not lauch $url");
      throw 'Could not launch $url';
    }
  }

}