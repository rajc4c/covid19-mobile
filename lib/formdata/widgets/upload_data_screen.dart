import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:openspaces/common/utils.dart';
import 'package:openspaces/covid19/colors.dart';
import 'package:openspaces/covid19/common_widgets.dart';
import 'package:openspaces/formdata/form_repository.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';
import 'package:location/location.dart';
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
  LocationData currentLocation;
  String deviceId;

  @override
  void initState() {
    super.initState();
    cacheLocation();
    Utils.getDeviceDetails().then((deviceId) {
      this.deviceId = deviceId;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                        labelStyle: questionLabelStyle,
                        alignLabelWithHint: false,
                        hintText: "",
                        labelText: "तापक्रम:",
                      ),
                      attribute: "temperature",
                      validators: [FormBuilderValidators.required()],
                      options: [
                        FormBuilderFieldOption(
                          label: "सामान्य ",
                          value: 98,
                        ),
                        FormBuilderFieldOption(
                          value: 101,
                          label: "ज्वरो",
                        ),
                        FormBuilderFieldOption(
                          value: 102,
                          label: "उच्च ज्वरो",
                        ),
                      ],
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
                    FormBuilderSegmentedControl(
                      validators: [FormBuilderValidators.required()],
                      onChanged: (value) {
                        this.hasTravelHistory = value;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          labelStyle: questionLabelStyle,
                          hintMaxLines: 2,
                          hintText: "किगत ३ हप्तामा",
                          labelText:
                              "कुनै कोरोनाले ग्रस्त मुलुकबाट फर्कनुभएको हो? हो होइन ?"),
                      attribute: "has_travel_history",
                      options: [
                        FormBuilderFieldOption(
                          label: "हो",
                          value: true,
                        ),
                        FormBuilderFieldOption(
                          value: false,
                          label: "होइन",
                        ),
                      ],
                    ),
                    this.hasTravelHistory
                        ? FormBuilderTextField(
                            minLines: 1,
                            maxLines: 10,
                            attribute: "country_name",
                            decoration: InputDecoration(
                              fillColor: OpenSpaceColors.red,
                              labelStyle: questionLabelStyle,
                              labelText: "कुन देशबाट?",
                            ),
                          )
                        : Container(),
                    this.hasTravelHistory
                        ? FormBuilderTextField(
                            minLines: 1,
                            maxLines: 10,
                            attribute: "flight_name",
                            decoration: InputDecoration(
                              fillColor: OpenSpaceColors.red,
                              labelStyle: questionLabelStyle,
                              labelText: "कुन प्लाइटबाट?",
                            ),
                          )
                        : Container(),
                    this.hasTravelHistory
                        ? FormBuilderTextField(
                            minLines: 1,
                            maxLines: 10,
                            attribute: "transit_names",
                            decoration: InputDecoration(
                              fillColor: OpenSpaceColors.red,
                              labelStyle: questionLabelStyle,
                              labelText: "ट्रान्जिट कुनै थियो भने खुलाउनुहोस्?",
                            ),
                          )
                        : Container(),
                    this.hasTravelHistory
                        ? FormBuilderSegmentedControl(
                            validators: [FormBuilderValidators.required()],
                            onChanged: (value) {
                              this.hasHasCovidContact = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                labelStyle: questionLabelStyle,
                                alignLabelWithHint: false,
                                hintText: "३ हप्तामा कुनै पनि ",
                                labelText:
                                    "संक्रमणको आशंका भएको व्यक्तिको सम्पर्कमा आउनुभएकोछ?"),
                            attribute: "has_convid_contact",
                            options: [
                              FormBuilderFieldOption(
                                label: "छ ",
                                value: true,
                              ),
                              FormBuilderFieldOption(
                                value: false,
                                label: "छैन",
                              ),
                            ],
                          )
                        : Container(),
                    this.hasHasCovidContact
                        ? FormBuilderTextField(
                            minLines: 1,
                            maxLines: 10,
                            attribute: "covid_contact_names",
                            decoration: InputDecoration(
                              fillColor: OpenSpaceColors.red,
                              labelStyle: questionLabelStyle,
                              labelText: "छ भने, कहाँ?",
                            ),
                          )
                        : Container(),
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
                    uploadFormNAXA();
                    uploadFormCFC();
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

  bool hasTravelHistory = false;
  bool hasHasCovidContact = false;
  bool isUploadingForm = false;

  void uploadFormCFC() {
//    setState(() {
//      isUploadingForm = true;
//    });

    Map<String, dynamic> formData = {
      "device_id": deviceId,
      "fever": _fbKey.currentState.value["temperature"].toString(),
      "drycough": _fbKey.currentState.value["have_cough"] ? "1" : "0",
      "tiredness": _fbKey.currentState.value["have_fatigue"] ? "1" : "0",
      "breath": _fbKey.currentState.value["fast_breathe"] ? "1" : "0",
      "pain": _fbKey.currentState.value["body_pain"] ? "1" : "0",
      "sore_throat": _fbKey.currentState.value["have_throat_pain"] ? "1" : "0",
      "diarrhoea": _fbKey.currentState.value["diarrahoe"] ? "1" : "0",
      "runny_nose": _fbKey.currentState.value["runny_nose"] ? "1" : "0",
      "nausea": _fbKey.currentState.value["vomit"] ? "1" : "0",
      "name": _fbKey.currentState.value["name"].toString(),
      "age": _fbKey.currentState.value["age"].toString(),
      "gender": _fbKey.currentState.value["gender"].toString(),
      "phone": _fbKey.currentState.value["contact_no"].toString(),
      "lat": currentLocation != null ? currentLocation.latitude : "",
      "lng": currentLocation != null ? currentLocation.longitude : "",
    };

    print(formData);

    formRepository.uploadSymptomFormC4C(formData).then((String message) {
//      if (message != null && message.isNotEmpty) {
//        Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (context) => ReportSubmissionThankYouScreen(message)));
//      } else {
//        showToastMessage(message: "फारम बुझाउन असफल भयो");
//      }
//
//      setState(() {
//        isUploadingForm = false;
//      });
    }).catchError((error, stack) {
      print(stack);
//      showToastMessage(message: "फारम बुझाउन असफल भयो");
//      setState(() {
//        isUploadingForm = false;
//      });
    });
  }

  void uploadFormNAXA() {
    setState(() {
      isUploadingForm = true;
    });

    Map<String, dynamic> travelHistory = {
      "has_travel_history": _fbKey.currentState.value["has_travel_history"],
      "country_name": _fbKey.currentState.value["country_name"],
      "flight_name": _fbKey.currentState.value["flight_name"],
      "transit_names": _fbKey.currentState.value["transit_names"],
      "has_convid_contact": _fbKey.currentState.value["has_convid_contact"],
      "covid_contact_names": _fbKey.currentState.value["covid_contact_names"],
    };

    _fbKey.currentState.value.remove("has_travel_history");
    _fbKey.currentState.value.remove("country_name");
    _fbKey.currentState.value.remove("flight_name");
    _fbKey.currentState.value.remove("transit_names");
    _fbKey.currentState.value.remove("has_convid_contact");
    _fbKey.currentState.value.remove("covid_contact_names");

    Map<String, dynamic> formData = {
      "device_id": deviceId,
      "lat": currentLocation != null ? currentLocation.latitude : "",
      "long": currentLocation != null ? currentLocation.longitude : "",
      "travel_history": jsonEncode(travelHistory).toString(),
    };

    formData.addAll(_fbKey.currentState.value);

    print(formData);

    formRepository.uploadSymtomForm(formData).then((String message) {
      if (message != null && message.isNotEmpty) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ReportSubmissionThankYouScreen(message)));
      } else {
        showToastMessage(message: "फारम बुझाउन असफल भयो");
      }

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

  void cacheLocation() async {
    var _location = Location();
    await _location.requestPermission();
    await _location.requestService();
    _location.onLocationChanged().listen((LocationData currentLocation) {
      this.currentLocation = currentLocation;
    });
  }
}
