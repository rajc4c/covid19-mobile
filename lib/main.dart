import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:openspaces/covid19/ui/home/info_page.dart';
import 'package:openspaces/covid19/ui/login/login_page.dart';
import 'package:openspaces/covid19/ui/home/page_comming_soon.dart';
import 'package:openspaces/covid19/ui/home/page_faq.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';
import 'package:openspaces/locale/app_localization.dart';
import 'package:package_info/package_info.dart';

import 'common/utils.dart';
import 'covid19/api.dart';
import 'covid19/common_widgets.dart';
import 'covid19/ui/home/dashboard_page.dart';
import 'covid19/ui/page_about.dart';
import 'formdata/widgets/upload_data_screen.dart';
import 'hospitalmap/screens/map_hospital_screen.dart';
import 'package:http/http.dart' as http;

Future<dynamic> firebaseBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
    print("[firebaseBackgroundMessageHandler] ${data.toString()}");
    showNotification("from data");

  }

  if (message.containsKey('notification')) {
    final dynamic notification = message['notification'];
    print("[firebaseBackgroundMessageHandler] ${notification.toString()}");
    showNotification("from notification");
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configLocalNotification();
  runApp(MyApp());
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void configLocalNotification() {
  var initializationSettingsAndroid =
      AndroidInitializationSettings('mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

void showNotification(message) async {
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
  await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
      message['body'].toString(), platformChannelSpecifics,
      payload: json.encode(message));
}

class MyApp extends StatelessWidget {
  final AppLocalizationDelegate _localeOverrideDelegate =
      AppLocalizationDelegate(Locale('en', 'US'));

  MyApp() {
    configureFirebaseMessaging();
  }

  void configureFirebaseMessaging() {
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showNotification(message);
      },
      onBackgroundMessage: firebaseBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    uploadFirebaseToken(_firebaseMessaging);
  }

  void uploadFirebaseToken(_firebaseMessaging) async {
    String deviceId = await Utils.getDeviceDetails();
    String token = await _firebaseMessaging.getToken();
    http.post(post_fcm_reg_key,
        body: {"device_id": deviceId, "registration_id": token}).then((value) {
      print(value);
    }).catchError((error, stack) {
      print(stack);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        _localeOverrideDelegate
      ],
      supportedLocales: [const Locale('en', 'US'), const Locale('np', 'NP')],
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedBottomNavigationIndex = 0;

  Future<void> checkForAppUpdate() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    http.get(get_mobile_version).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> config =
            jsonDecode(utf8.decode(response.bodyBytes));
        print(config.toString());

        int currentVersion = int.parse(info.version.replaceAll(".", ""));
        int latestVersion = int.parse(config["version_name"]);
        if (latestVersion > currentVersion) {
          updateDialog(context,
              title: config["app_name"],
              message: config["version_info"],
              actions: [
                FlatButton(
                  child: Text('Update now'),
                  onPressed: () {
                    Utils.launchURL(config["alert_link"]);
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        }
      }
    });
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void pageChanged(int index) {
    setState(() {
      _selectedBottomNavigationIndex = index;
    });
  }

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      physics: new NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        DashboardPage(
          medicalFacilityClicked: () {
            print("[home][medical facilities clicked]");
            pageController.animateToPage(1,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          },
        ),
        MapHospitalScreen(),
        UploadDataScreen(),
        InfoPage()
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    checkForAppUpdate();
  }

  _openCommingSoonPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CommingSoonPage()));
  }

  _mDrawer() {
    return Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            logo(),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 1.0,
              color: Colors.grey,
            ),
            FlatButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.report,
                  color: Colors.red,
                ),
                label: Text(
                  "पछिल्लो तथ्यांक",
                  style: TextStyle(color: Colors.grey),
                )),
            FlatButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MapHospitalScreen()));
                },
                icon: Icon(
                  Icons.local_hospital,
                  color: Colors.red,
                ),
                label: Text(
                  "स्वास्थ्य सेवाहरु",
                  style: TextStyle(color: Colors.grey),
                )),

            FlatButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadDataScreen()));
                },
                icon: Icon(
                  Icons.help,
                  color: Colors.red,
                ),
                label: Text(
                  "लक्षण मुल्यांकन",
                  style: TextStyle(color: Colors.grey),
                )),
//
//             FlatButton.icon(
//                    onPressed: () {
//                      _openCommingSoonPage();
//                    },
//                    icon: Icon(
//                      Icons.web,
//                      color: Colors.red,
//                    ),
//                    label: Text(
//                      "Track me",
//                      style: TextStyle(color: Colors.grey),
//                    )),
//             FlatButton.icon(
//                    onPressed: () {
//                      _openCommingSoonPage();
//                    },
//                    icon: Icon(
//                      Icons.web,
//                      color: Colors.red,
//                    ),
//                    label: Text(
//                      "Emergency Contacts",
//                      style: TextStyle(color: Colors.grey),
//                    )),

//              FlatButton.icon(
//                    onPressed: () {
//                      _openCommingSoonPage();
//                    },
//                    icon: Icon(
//                      Icons.info,
//                      color: Colors.red,
//                    ),
//                    label: Text(
//                      "कोरोनाका लक्षणहरु",
//                      style: TextStyle(color: Colors.grey),
//                    )),

            FlatButton.icon(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => FaqPage()));
                },
                icon: Icon(
                  Icons.question_answer,
                  color: Colors.red,
                ),
                label: Text(
                  "धेरे सोधिने प्रश्नहरु",
                  style: TextStyle(color: Colors.grey),
                )),

            FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.red,
                ),
                label: Text(
                  "लग इन",
                  style: TextStyle(color: Colors.grey),
                )),

            FlatButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUsPage()));
                },
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.red,
                ),
                label: Text(
                  "एपको बारेमा",
                  style: TextStyle(color: Colors.grey),
                )),

//             FlatButton.icon(
//                    onPressed: () {},
//                    icon: Icon(
//                      Icons.web,
//                      color: Colors.red,
//                    ),
//                    label: Text(
//                      "Login",
//                      style: TextStyle(color: Colors.grey),
//                    )),

//               FlatButton.icon(
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => LocaleChangeTest()),
//                      );
//                    },
//                    icon: Icon(
//                      Icons.language,
//                      color: Colors.red,
//                    ),
//                    label: Text(
//                      "Language Change",
//                      style: TextStyle(color: Colors.grey),
//                    )),

//            Spacer(flex: 1,),
//              Divider(
//                height: 1,
//                color: Colors.grey,
//              ),
//
//              ListTile(
//                leading: Image.asset(
//                  'assets/images/gov_logo.png',
//                  fit: BoxFit.cover,
//                  height: 48.0,
//                  width: 48.0,
//                ),
//                title: Text(
//                  "Government of Nepal",
//                  style: TextStyle(color: Colors.blue, fontSize: 14.0),
//                ),
//                subtitle: Text(
//                  "Ministry of Health and Population",
//                  style: TextStyle(
//                      color: Colors.red,
//                      fontSize: 16.0,
//                      fontWeight: FontWeight.bold),
//                ),
//              ),
//              SizedBox(
//                height: 16.0,
//              )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: covidAppBar(),
      body: buildPageView(),
      drawer: _mDrawer(),
    );
  }

  buildBottomBar() {
    return BottomNavigationBar(
      currentIndex: _selectedBottomNavigationIndex,
      onTap: (index) {
        setState(() {
          _selectedBottomNavigationIndex = index;
          pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        });
      },
      selectedItemColor: Color.fromRGBO(239, 25, 25, 1),
      unselectedItemColor: Colors.grey,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital), title: Text("Facilities")),
        BottomNavigationBarItem(
            icon: Icon(Icons.report), title: Text("Report")),
        BottomNavigationBarItem(icon: Icon(Icons.info), title: Text("Info"))
      ],
    );
  }
}
