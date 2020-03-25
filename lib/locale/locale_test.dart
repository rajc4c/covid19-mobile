
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openspaces/common/constants.dart';
import 'package:openspaces/locale/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleChangeTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LocaleChangeTestState();
  }
}

class LocaleChangeTestState extends State<LocaleChangeTest> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Language "),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Wrap(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
                spacing: 16.0,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      AppLocalization.load(Locale('en', 'US'));
                      setState(() {
                        updateSelectedLanguage("en");
                      });
                    },
                    child: Text("English"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      AppLocalization.load(Locale('np', 'NP'));
                      setState(() {
                        updateSelectedLanguage("np");
                      });
                    },
                    child: Text("Nepali"),
                  ),
//                  RaisedButton(
//                    onPressed: () {
//                      AppLocalization.load(Locale('ar', 'AE'));
//                      setState(() {
//                        updateSelectedLanguage("ar");
//                      });
//                    },
//                    child: Text("Arabic"),
//                  ),
//                  RaisedButton(
//                    onPressed: () {
//                      AppLocalization.load(Locale('en', 'US'));
//                      setState(() {
//                        updateSelectedLanguage("");
//                      });
//                    },
//                    child: Text("Default"),
//                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(50.0),
                child: Text(AppLocalization.of(context).heyWorld),
              )
            ],
          ),
        ),
      ),
    );
  }

  updateSelectedLanguage(String languageCode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        SharedPrefsKey.selectedLanguageCode, languageCode);
  }
}
