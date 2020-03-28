  import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';

import '../../api.dart';
import '../../colors.dart';
  import 'package:location/location.dart';

import '../../common_widgets.dart';
  import 'package:http/http.dart' as http;


class UpdateHospitalData extends StatefulWidget{
  UpdateHospitalData(this.facilityId);
  int facilityId;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UpdateHospitalDataState();
  }

}

class UpdateHospitalDataState extends State<UpdateHospitalData> {

  final GlobalKey<FormBuilderState> _fbHospitalKey = GlobalKey<FormBuilderState>();
  var questionLabelStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: OpenSpaceColors.text_color);

  String errorLabel = "कृपया यसलाई खाली नछोड्नुहोस्";
  LocationData currentLocation;
  String deviceId;

  bool isUploadingForm = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: covidAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FormBuilder(
                key: _fbHospitalKey,
                initialValue: {},
                autovalidate: false,
                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      autocorrect: false,
                      attribute: "contact_person",
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "Contact person",
                          hintText: ""),
                      validators: [
                        FormBuilderValidators.required()
                      ],
                    ),
                    FormBuilderTextField(
                      autocorrect: false,
                      attribute: "contact_num",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "Contact Number",
                          hintText: ""),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.maxLength(10),
                        FormBuilderValidators.minLength(7),
                        FormBuilderValidators.required()
                      ],
                    ),
                    FormBuilderTextField(
                      autocorrect: false,
                      attribute: "num_of_bed",
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "Number Of Bed",
                          hintText: ""),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.required()
                      ],
                    ),
                    FormBuilderTextField(
                      autocorrect: false,
                      attribute: "num_of_icu_bed",
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "Number Of ICU Bed",
                          hintText: ""),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.required()
                      ],
                    ),
                    FormBuilderTextField(
                      autocorrect: false,
                      attribute: "occupied_icu_bed",
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "Number Of Occupied ICU Bed",
                          hintText: ""),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.required()
                      ],
                    ),
                    FormBuilderTextField(
                      autocorrect: false,
                      attribute: "num_of_ventilators",
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "Number Of Ventilators",
                          hintText: ""),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.required()
                      ],
                    ),
                    FormBuilderTextField(
                      autocorrect: false,
                      attribute: "occupied_ventilators",
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "Number Of Occupied Ventilators",
                          hintText: ""),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.required()
                      ],
                    ),
                    FormBuilderTextField(
                      autocorrect: false,
                      attribute: "num_of_isolation_bed",
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "Number Of Isolation Bed",
                          hintText: ""),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.required()
                      ],
                    ),
                    FormBuilderTextField(
                      autocorrect: false,
                      attribute: "occupied_isolation_bed",
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "Number Of Occupied Isolation Bed",
                          hintText: ""),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.required()
                      ],
                    ),
                    FormBuilderTextField(
                      autocorrect: false,
                      attribute: "total_tested",
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "Number Of Tested Patients",
                          hintText: ""),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.required()
                      ],
                    ),
                    FormBuilderTextField(
                      autocorrect: false,
                      attribute: "total_positive",
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "Number Of Posotive Patients",
                          hintText: ""),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.required()
                      ],
                    ),
                    FormBuilderTextField(
                      autocorrect: false,
                      attribute: "total_death",
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "Total Number Of Death",
                          hintText: ""),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.required()
                      ],
                    ),
                    FormBuilderTextField(
                      autocorrect: false,
                      attribute: "total_in_isolation",
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "Total Number Of Patient In Isolation",
                          hintText: ""),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.required()
                      ],
                    ),
                    FormBuilderTextField(
                      autocorrect: false,
                      attribute: "remarks",
                      initialValue: "",
                      decoration: InputDecoration(
                          fillColor: OpenSpaceColors.red,
                          labelStyle: questionLabelStyle,
                          labelText: "Remarks",
                          hintText: ""),
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  if (_fbHospitalKey.currentState.saveAndValidate()) {
                    setState(() {
                      isUploadingForm = true;
                    });
                    print("Form data" + _fbHospitalKey.currentState.value.toString());
                    uploadFormNAXA(_fbHospitalKey.currentState.value, );
//                    uploadFormCFC();
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

  void uploadFormNAXA(Map<String, dynamic> value) async {
    print('uploadFormNAXA: '+jsonEncode(value).toString());

    Map<String, dynamic> formData = {
      "device_id": deviceId,
      "fever": _fbHospitalKey.currentState.value["temperature"].toString(),
      "drycough": _fbHospitalKey.currentState.value["have_cough"] ? "1" : "0",
      "tiredness": _fbHospitalKey.currentState.value["have_fatigue"] ? "1" : "0",
      "breath": _fbHospitalKey.currentState.value["fast_breathe"] ? "1" : "0",
      "pain": _fbHospitalKey.currentState.value["body_pain"] ? "1" : "0",
      "sore_throat": _fbHospitalKey.currentState.value["have_throat_pain"] ? "1" : "0",
      "diarrhoea": _fbHospitalKey.currentState.value["diarrahoe"] ? "1" : "0",
      "runny_nose": _fbHospitalKey.currentState.value["runny_nose"] ? "1" : "0",
      "nausea": _fbHospitalKey.currentState.value["vomit"] ? "1" : "0",
      "name": _fbHospitalKey.currentState.value["name"].toString(),
      "age": _fbHospitalKey.currentState.value["age"].toString(),
      "gender": _fbHospitalKey.currentState.value["gender"].toString(),
      "phone": _fbHospitalKey.currentState.value["contact_no"].toString(),
      "lat": currentLocation != null ? currentLocation.latitude : "",
      "lng": currentLocation != null ? currentLocation.longitude : "",
    };

    var response = await http.put(get_health_facilities+widget.facilityId.toString()+"/", body: jsonEncode(value));
    setState(() {
      isUploadingForm = false;
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}