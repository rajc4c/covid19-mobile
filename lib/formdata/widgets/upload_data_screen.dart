import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:openspaces/covid19/colors.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';

class UploadDataScreen extends StatefulWidget {
  @override
  _UploadDataScreenState createState() => _UploadDataScreenState();
}

class _UploadDataScreenState extends State<UploadDataScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  var questionLabelStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: OpenSpaceColors.text_color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                initialValue: {
                  'date': DateTime.now(),
                },
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      attribute: "age",
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "How old are you?",
                          hintText: "Your age in years"),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(70),
                      ],
                    ),
                    FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          labelText: "Are you caring for someone ill?"),
                      attribute: "gender",
                      options: [
                        FormBuilderFieldOption(value: "Male"),
                        FormBuilderFieldOption(
                          value: "Female",
                        ),
                        FormBuilderFieldOption(
                          value: "Not Applicable",
                        )
                      ],
                    ),
                    FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "Normal body temperature is 98.6°F",
                          labelText:
                              "Current body temperature in degree Fahrenheit "),
                      attribute: "temperature",
                      options: [
                        FormBuilderFieldOption(value: "Normal"),
                        FormBuilderFieldOption(
                          value: "Fever",
                        ),
                        FormBuilderFieldOption(
                          value: "High Fever",
                        ),
                        FormBuilderFieldOption(
                          value: "Don't Know",
                        )
                      ],
                    ),
                    FormBuilderCheckboxList(
                      decoration: InputDecoration(
                          helperText: "mark all those applicable",
                          labelStyle: questionLabelStyle,
                          labelText:
                              "Are you experiencing any of the symptoms "),
                      attribute: "symptoms",
                      initialValue: ["Dry Cough"],
                      options: [
                        FormBuilderFieldOption(value: "Dry Cough"),
                        FormBuilderFieldOption(value: "Sneezing"),
                        FormBuilderFieldOption(value: "Sore Throat"),
                        FormBuilderFieldOption(value: "Weakness"),
                        FormBuilderFieldOption(
                            value: "Difficulty in Breathing"),
                        FormBuilderFieldOption(value: "None of these"),
                      ],
                    ),
                    FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          labelText:
                              "Please select your travel and exposure details "),
                      attribute: "travel",
                      options: [
                        FormBuilderFieldOption(
                          value: "No Travel History",
                          child: Text(
                            "No Travel History",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        FormBuilderFieldOption(
                          child: Text(
                            "No Contact With Anyone With Symptom",
                            textAlign: TextAlign.center,
                          ),
                          value: "No Contact With Anyone With Symptom",
                        ),
                        FormBuilderFieldOption(
                          child: Text(
                            "History of travel or meeting in affected geographical area in last 14 days",
                            textAlign: TextAlign.center,
                          ),
                          value: "",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: InkWell(
                  onTap: () {
                    if (_fbKey.currentState.saveAndValidate()) {
                      print(_fbKey.currentState.value);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    color: OpenSpaceColors.button_red,
                    child: Center(
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(
                            color: OpenSpaceColors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
