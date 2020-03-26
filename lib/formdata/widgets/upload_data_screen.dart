import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:openspaces/covid19/colors.dart';

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
                          labelText: "नामः",
                          hintText: ""),
                      validators: [FormBuilderValidators.required()],
                    ),
                    FormBuilderTextField(
                      attribute: "age",
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "उमेरः",
                          hintText: ""),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(100),
                        FormBuilderValidators.required()
                      ],
                    ),
                    FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                        labelStyle: questionLabelStyle,
                        labelText: "प्रयोगकर्ताको लिङ्ग: "
                      ),
                      attribute: "movie_rating",
                      options: [
                        FormBuilderFieldOption(value: "पुरुष"),
                        FormBuilderFieldOption(
                          value: "महिला",
                        ),
                        FormBuilderFieldOption(
                          value: "अन्य",
                        )
                      ],
                    ),
                    FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText: "तापक्रमः"),
                      attribute: "movie_rating",
                      options: [
                        FormBuilderFieldOption(value: "सामान्य(96°F-98.6°F)"),
                        FormBuilderFieldOption(
                          value: "ज्वरो(98.6°F-102.5°F)",
                        ),
                        FormBuilderFieldOption(
                          value: "उच्च ज्वरो(>102°F)",
                        ),
                        FormBuilderFieldOption(
                          value: "नभएको",
                        )
                      ],
                    ),
                    FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText:
                              "के तपाईँ सेल्फ क्वारेन्टाइनमा बस्नुभएको छ?"),
                      attribute: "movie_rating",
                      options: [
                        FormBuilderFieldOption(
                          value: "छ",
                        ),
                        FormBuilderFieldOption(
                          value: "छैन",
                        ),
                      ],
                    ),
                    FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText: "सुख्खा तथा लहरे खोकीः "),
                      attribute: "movie_rating",
                      options: [
                        FormBuilderFieldOption(
                          value: "छ",
                        ),
                        FormBuilderFieldOption(
                          value: "छैन",
                        ),
                      ],
                    ),
                                        FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText: "थकाई लाग्नेः "),
                      attribute: "movie_rating",
                      options: [
                        FormBuilderFieldOption(
                          value: "छ",
                        ),
                        FormBuilderFieldOption(
                          value: "छैन",
                        ),
                      ],
                    ),
                                        FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText: "घाँटी बस्नेः "),
                      attribute: "movie_rating",
                      options: [
                        FormBuilderFieldOption(
                          value: "छ",
                        ),
                        FormBuilderFieldOption(
                          value: "छैन",
                        ),
                      ],
                    ),
                                        FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText: "आराम गर्दा पनि सास छोटो भएजस्तो लाग्नेः "),
                      attribute: "movie_rating",
                      options: [
                        FormBuilderFieldOption(
                          value: "छ",
                        ),
                        FormBuilderFieldOption(
                          value: "छैन",
                        ),
                      ],
                    ),
                                        FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText: "जीउ दुखाईः "),
                      attribute: "movie_rating",
                      options: [
                        FormBuilderFieldOption(
                          value: "छ",
                        ),
                        FormBuilderFieldOption(
                          value: "छैन",
                        ),
                      ],
                    ),
                                        FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText: "पखालाः "),
                      attribute: "movie_rating",
                      options: [
                        FormBuilderFieldOption(
                          value: "छ",
                        ),
                        FormBuilderFieldOption(
                          value: "छैन",
                        ),
                      ],
                    ),
                                        FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText: "सिँगान बग्नेः "),
                      attribute: "movie_rating",
                      options: [
                        FormBuilderFieldOption(
                          value: "छ",
                        ),
                        FormBuilderFieldOption(
                          value: "छैन",
                        ),
                      ],
                    ),
                                        FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                     
                          labelText: "वाकवाकीः "),
                      attribute: "movie_rating",
                      options: [
                        FormBuilderFieldOption(
                          value: "छ",
                        ),
                        FormBuilderFieldOption(
                          value: "छैन",
                        ),
                      ],
                    ),
                                        FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText: "सुख्खा तथा लहरे खोकीः "),
                      attribute: "movie_rating",
                      options: [
                        FormBuilderFieldOption(
                          value: "छ",
                        ),
                        FormBuilderFieldOption(
                          value: "छैन",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text("Submit"),
                    onPressed: () {
                      if (_fbKey.currentState.saveAndValidate()) {
                        print(_fbKey.currentState.value);
                      }
                    },
                  ),
                  MaterialButton(
                    child: Text("Reset"),
                    onPressed: () {
                      _fbKey.currentState.reset();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
