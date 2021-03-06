//import 'package:connectivity/connectivity.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:openspaces/common/constants.dart';
import 'package:openspaces/covid19/preferences.dart';
import 'package:openspaces/covid19/ui/login/login_response.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';
import 'package:openspaces/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api.dart';
import '../../colors.dart';
import '../../common_widgets.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  bool isDataSending = false;
  final GlobalKey<FormBuilderState> _fbLoginKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var textLabelStyle = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: OpenSpaceColors.text_color);
    return Scaffold(
        appBar: covidAppBarText(),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  height: MediaQuery.of(context).size.height-150.0,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(height: 38.0,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/images/nepal_logo.png",
                                height: 48.0,
                                width: 48.0,
                              ),
                               SizedBox(width: 16.0,),
                               Text(
                                "हाम्रो स्वास्थ्य",
                                style: TextStyle(
                                    fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                            ],
                          ),

                          SizedBox(height: 38.0,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("स्वागतम्।", style: Theme.of(context).textTheme.title.copyWith(fontSize: 22.0, color: Colors.black87),),
                              Text("कृपया लग-इन गर्नुहोस्", style: Theme.of(context).textTheme.title.copyWith(fontSize: 13.0, color: OpenSpaceColors.red),),
                            ],
                          )
                        ],
                      ),

                      Container(
                        padding: EdgeInsets.only(bottom: 150.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FormBuilder(
                                key: _fbLoginKey,
                                initialValue: {},
                                autovalidate: false,
                                child: Column(
                                  children: <Widget>[
                                    FormBuilderTextField(
                                      autocorrect: false,
                                      attribute: "username",
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                          fillColor: OpenSpaceColors.red,
                                          labelStyle: textLabelStyle,
//                              labelText: "User Name",
                                          labelText: "नाम",
                                          hintText: ""),
                                      validators: [
                                        FormBuilderValidators.required()
                                      ],
                                    ),
                                    FormBuilderTextField(
                                      autocorrect: false,
                                      attribute: "password",
                                      maxLines: 1,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          fillColor: OpenSpaceColors.red,
                                          labelStyle: textLabelStyle,
//                              labelText: "Password",
                                          labelText: "पासवर्ड",
                                          hintText: ""),
                                      validators: [
                                        FormBuilderValidators.required()
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          if (_fbLoginKey.currentState.saveAndValidate()) {
                            postUserLoginCredential(
                                _fbLoginKey.currentState.value);
                          } else {
//                  showToastMessage(message: "Incorrect Username or Password");
                            showToastMessage(
                                message: "गलत युजरनेम अथवा पासवर्ड");
                          }
                        },
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.only(bottom: 16.0),
                          padding: EdgeInsets.all(20),
                          color: OpenSpaceColors.red,
                          child: Center(
                            child: isDataSending
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator())
                                : Text(
                                    "लग-इन",
                                    style: TextStyle(
                                        color: OpenSpaceColors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))));
  }

  void postUserLoginCredential(Map<String, dynamic> value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
//    var connectivityResult = await (Connectivity().checkConnectivity());
//    bool _isInternetConnected =  (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi)?true:false;
//    if (_isInternetConnected) {
//      print(_fbLoginKey.currentState.value);
    setState(() {
      isDataSending = true;
    });

    var response = await http.post(post_user_login_credential, body: value);
    if (response != null) {
//        print('Response body: ${response.body}');

      var map = jsonDecode(response.body);
      LoginResponse loginResponse = LoginResponse.fromJson(map);

      preferences.setString(
          SharedPrefsKey.userLoginResponse, jsonEncode(loginResponse));

      print("'Response body: " +
          preferences.get(SharedPrefsKey.userLoginResponse));
      setState(() {
        isDataSending = false;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MyApp()));
      });
    }

//    } else  {
//      showToastMessage(message: "कृपया अनलाइन आएर पुनः प्रयास गर्नुहोस्");
//
//    }
  }
}
