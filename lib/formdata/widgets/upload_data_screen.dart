import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:openspaces/covid19/colors.dart';
import 'package:openspaces/covid19/common_widgets.dart';
import 'package:openspaces/formdata/form_repository.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';

import '../ReportSubmissionThankYouScreen.dart';

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

  String errorLabel = "कृपया यसलाई खाली नछोड्नुहोस्";

  @override
  Widget build(BuildContext context) {
    setState(() {
      isUploadingForm = false;
    });
    return Scaffold(
      appBar: covidAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                initialValue: {},
                autovalidate: false,
                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      autocorrect: false,
                      attribute: "name",
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "नामः",
                          hintText: ""),
                      validators: [FormBuilderValidators.required()],
                    ),
                    FormBuilderTextField(
                      autocorrect: false,
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
                          labelText: "प्रयोगकर्ताको लिङ्ग: "),
                      attribute: "gender",
                      validators: [],
                      options: [
                        FormBuilderFieldOption(
                          label: "पुरुष",
                          value: "Male",
                        ),
                        FormBuilderFieldOption(
                          label: "महिला",
                          value: "Female",
                        ),
                        FormBuilderFieldOption(
                          label: "अन्य",
                          value: "Other",
                        )
                      ],
                    ),
                    FormBuilderSlider(
                      attribute: "temperature",
                      min: 90,
                      max: 106,
                      initialValue: 90,
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "तापक्रम:",
                          hintText: ""),
                    ),
                    FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText:
                              "के तपाईँ सेल्फ क्वारेन्टाइनमा बस्नुभएको छ?"),
                      attribute: "in_self_quarrantine",
                      validators: [FormBuilderValidators.required()],
                      options: [
                        FormBuilderFieldOption(
                          label: "छ",
                          value: true,
                        ),
                        FormBuilderFieldOption(
                          value: false,
                          label: "छैन",
                        ),
                      ],
                    ),
                    FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText: "सुख्खा तथा लहरे खोकीः "),
                      attribute: "have_cough",
                      validators: [FormBuilderValidators.required()],
                      options: [
                        FormBuilderFieldOption(
                          label: "छ",
                          value: true,
                        ),
                        FormBuilderFieldOption(
                          value: false,
                          label: "छैन",
                        ),
                      ],
                    ),
                    FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText: "थकाई लाग्नेः "),
                      attribute: "have_fatigue",
                      validators: [FormBuilderValidators.required()],
                      options: [
                        FormBuilderFieldOption(
                          label: "छ",
                          value: true,
                        ),
                        FormBuilderFieldOption(
                          value: false,
                          label: "छैन",
                        ),
                      ],
                    ),
                    FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText: "घाँटी बस्नेः "),
                      attribute: "have_throat_pain",
                      validators: [FormBuilderValidators.required()],
                      options: [
                        FormBuilderFieldOption(
                          label: "छ",
                          value: true,
                        ),
                        FormBuilderFieldOption(
                          value: false,
                          label: "छैन",
                        ),
                      ],
                    ),
                    FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText:
                              "आराम गर्दा पनि सास छोटो भएजस्तो लाग्नेः "),
                      attribute: "fast_breathe",
                      validators: [FormBuilderValidators.required()],
                      options: [
                        FormBuilderFieldOption(
                          label: "छ",
                          value: true,
                        ),
                        FormBuilderFieldOption(
                          value: false,
                          label: "छैन",
                        ),
                      ],
                    ),
                    FormBuilderSegmentedControl(
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText: "जीउ दुखाईः "),
                      attribute: "body_pain",
                      options: [
                        FormBuilderFieldOption(
                          label: "छ",
                          value: true,
                        ),
                        FormBuilderFieldOption(
                          value: false,
                          label: "छैन",
                        ),
                      ],
                    ),
                    FormBuilderSegmentedControl(
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText: "पखालाः "),
                      attribute: "diarrahoe",
                      options: [
                        FormBuilderFieldOption(
                          label: "छ",
                          value: true,
                        ),
                        FormBuilderFieldOption(
                          value: false,
                          label: "छैन",
                        ),
                      ],
                    ),
                    FormBuilderSegmentedControl(
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          hintText: "",
                          labelText: "सिँगान बग्नेः "),
                      attribute: "runny_nose",
                      options: [
                        FormBuilderFieldOption(
                          label: "छ",
                          value: true,
                        ),
                        FormBuilderFieldOption(
                          value: false,
                          label: "छैन",
                        ),
                      ],
                    ),
                    FormBuilderSegmentedControl(
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          alignLabelWithHint: false,
                          labelText: "वाकवाकीः "),
                      attribute: "vomit",
                      options: [
                        FormBuilderFieldOption(
                          label: "छ",
                          value: true,
                        ),
                        FormBuilderFieldOption(
                          value: false,
                          label: "छैन",
                        ),
                      ],
                    ),
                    FormBuilderTextField(
                      minLines: 1,
                      maxLines: 10,
                      attribute: "symptoms",
                      decoration: InputDecoration(
                        fillColor: OpenSpaceColors.red,
                        labelStyle: questionLabelStyle,
                        labelText:
                            "के तपाइँसँग कुनै अन्य स्वास्थ्य समस्याहरू छन्?",
                      ),
                      validators: [FormBuilderValidators.required()],
                    ),
                    FormBuilderTextField(
                      minLines: 1,
                      maxLines: 10,
                      attribute: "travel_history",
                      decoration: InputDecoration(
                        fillColor: OpenSpaceColors.red,
                        labelStyle: questionLabelStyle,
                        labelText: "के तपाईंले गएको महिना कतै यात्रा गर्नुभयो?",
                      ),
                      validators: [FormBuilderValidators.required()],
                    ),
                    FormBuilderTextField(
                      attribute: "contact_no",
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "सम्पर्क नम्बर:",
                          hintText: ""),
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric()
                      ],
                    ),
                    FormBuilderTextField(
                      attribute: "address",
                      decoration: InputDecoration(
                        fillColor: OpenSpaceColors.red,
                        labelStyle: questionLabelStyle,
                        labelText: "ठेगाना:",
                      ),
                      validators: [FormBuilderValidators.required()],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  if (_fbKey.currentState.saveAndValidate()) {
                    uploadForm();
                  } else {
                    showToastMessage(message: "फारममा त्रुटिहरू छन्");
                  }
                },
                child: Container(
                  height: 60,
                  padding: EdgeInsets.all(16),
                  color: OpenSpaceColors.button_red,
                  child: Center(
                    child: isUploadingForm
                        ? Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator())
                        : Text(
                            "फारम बुझाउनुहोस्",
                            style: TextStyle(
                                color: OpenSpaceColors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isUploadingForm = false;

  void uploadForm() {
    setState(() {
      isUploadingForm = true;
    });

    print(_fbKey.currentState.value["contact_no"]);

    print(_fbKey.currentState.value);
    Map<String, dynamic> formData = {
      "device_id": _fbKey.currentState.value["contact_no"].toString()
    };

    formData.addAll(_fbKey.currentState.value);

    print(formData);

    formRepository.uploadSymtomForm(formData).then((String message) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReportSubmissionThankYouScreen(message)));

      setState(() {
        isUploadingForm = false;
      });
    }).catchError((error, stack) {
      print(stack);
      showToastMessage(message: "फारम बुझाउन असफल भयो");
      setState(() {
        isUploadingForm = false;
      });
    });
  }
}
