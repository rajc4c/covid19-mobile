import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:openspaces/common/utils.dart';

class FlutterNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  FlutterNotification() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _configLocalNotification();
  }

  void _configLocalNotification() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/launcher_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }


  void showNotification({@required title, @required message, url}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'np.com.naxa.covid19',
      'News & Notices',
      'Notification for news & notices',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, message, platformChannelSpecifics,
        payload: json.encode(message));
  }
}
