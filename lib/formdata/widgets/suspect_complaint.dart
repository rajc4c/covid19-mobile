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
import 'countries.dart';

class SuspectComplaint extends StatefulWidget {
  @override
  _SuspectComplaintState createState() => _SuspectComplaintState();
}

class _SuspectComplaintState extends State<SuspectComplaint> {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

//                        border: OutlineInputBorder(
//                        borderSide: BorderSide(color: Colors.grey)),
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "संकास्पद व्यक्तिको नाम:",
                          hintText: ""),
                      validators: [FormBuilderValidators.required()],
                    ),
                    spaceBetn(),
                    FormBuilderTextField(
                      autocorrect: false,
                      attribute: "age",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "उमेर (अन्दाजी):",
                          hintText: ""),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(100),
                        FormBuilderValidators.required()
                      ],
                    ),
                    spaceBetn(),
                    FormBuilderTextField(
                      attribute: "address",
                      decoration: InputDecoration(
                        fillColor: OpenSpaceColors.red,
                        labelStyle: questionLabelStyle,
                        labelText: "ठेगाना:",
                      ),
                      validators: [FormBuilderValidators.required()],
                    ),
                    spaceBetn(),
                    FormBuilderTextField(
                      attribute: "contact_no",
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText:
                              "संकास्पद व्यक्तिको सम्पर्क नम्बर (सम्भव भएसम्म):",
                          hintText: ""),
                      validators: [
                        // FormBuilderValidators.required(),
                        FormBuilderValidators.numeric()
                      ],
                    ),
                    spaceBetn(),

                    FormBuilderDropdown(
                      decoration: InputDecoration(
                        labelText: "कुन देशबाट नेपाल फर्किएको ?",
                      ),
                      attribute: 'country',
                      items: countries
                          .map((country) {
                        return country["country"];
                      })
                          .map((country) => DropdownMenuItem(
                          value: country, child: Text("$country")))
                          .toList(),
                    ),
                  
                    spaceBetn(),
                    FormBuilderTextField(
                      attribute: "transit",
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "कुन देशमा ट्रान्सिट परेको? (सम्भव भएसम्म)",
                          hintText: ""),
                      validators: [
                        // FormBuilderValidators.required()
                      ],
                    ),
                  ],
                ),
              ),

//              SizedBox(
//                height: 10,
//              ),

              InkWell(
                onTap: () {
                  if (_fbKey.currentState.saveAndValidate()) {
                    uploadSuspectForm();
                    uploadFormNAXA();
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
                                fontSize: 14,
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

  void uploadSuspectForm() {
    Map<String, dynamic> formData = {
      "device_id": deviceId,
      "suspect_name": _fbKey.currentState.value["name"].toString(),
      "suspect_address": _fbKey.currentState.value["address"].toString(),
      "suspect_age": _fbKey.currentState.value["age"].toString(),
      "suspect_phone": _fbKey.currentState.value["contact_no"].toString(),
      "suspect_country": _fbKey.currentState.value["country"].toString(),
      "suspect_transit": _fbKey.currentState.value["transit"].toString(),
      "lat": currentLocation != null ? currentLocation.latitude : "",
      "lng": currentLocation != null ? currentLocation.longitude : "",
    };

    print(jsonEncode(formData));

    formRepository.uploadSuspectFormC4C(formData).then((String message) {
    if (message != null && message.isNotEmpty) {
//        Navigator.pushReplacement(
//            context,
//            MaterialPageRoute(
//                builder: (context) => ReportSubmissionThankYouScreen(message)));
      } else {
//        showToastMessage(message: "फारम बुझाउन असफल भयो");
      }

      setState(() {
        isUploadingForm = false;
      });
    }).catchError((error, stack) {
      print(stack);
//      showToastMessage(message: "फारम बुझाउन असफल भयो");
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

  Widget spaceBetn(){
    return SizedBox(
      height: 12.0,
    );
  }

  void uploadFormNAXA() {
    setState(() {
      isUploadingForm = true;
    });

    Map<String, dynamic> formData = {
      "id": deviceId,
      "name": _fbKey.currentState.value["name"].toString(),
      "address": _fbKey.currentState.value["address"].toString(),
      "age": _fbKey.currentState.value["age"].toString(),
      "phone": _fbKey.currentState.value["contact_no"].toString(),
      "country": _fbKey.currentState.value["country"].toString(),
      "transit": _fbKey.currentState.value["transit"].toString(),
      "lat": currentLocation != null ? currentLocation.latitude : "",
      "lng": currentLocation != null ? currentLocation.longitude : "",
    };

    print(formData);

    formRepository.uploadSuspectForm(formData).then((String message) {
      if (message == "201" && message.isNotEmpty) {
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


}
