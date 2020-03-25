import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:openspaces/auth/repos/login_repository.dart';
import 'package:openspaces/covid19/colors.dart';

class AuthPage extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKeyLogin = GlobalKey<FormBuilderState>();
  var questionLabelStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: OpenSpaceColors.text_color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OpenSpaceColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: OpenSpaceColors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Image.asset(
              "assets/images/app_bar_logo.png",
              scale: 2,
            ),
            SizedBox(
              height: 100,
            ),
            FormBuilder(
              key: _fbKeyLogin,
              autovalidate: true,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: OpenSpaceColors.listItemBackground,
                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      attribute: "email",
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          labelText: "Email",
                          hintText: "example@mail.com"),
                      validators: [],
                    ),
                    FormBuilderTextField(
                      attribute: "password",
                      decoration: InputDecoration(
                          hasFloatingPlaceholder: true,
                          labelStyle: questionLabelStyle,
                          labelText: "Password",
                          hintText: "example@mail.com"),
                      validators: [],
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: InkWell(
                  onTap: () {
                    if (_fbKeyLogin.currentState.saveAndValidate()) {
                      print(_fbKeyLogin.currentState.value);
                      loginRepository.login(_fbKeyLogin.currentState.value);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    color: OpenSpaceColors.red,
                    child: Center(
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(
                            color: OpenSpaceColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
