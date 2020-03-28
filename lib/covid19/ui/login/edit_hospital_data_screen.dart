  import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:openspaces/hospitalmap/repo/point_of_interest.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';

import '../../../main.dart';
import '../../api.dart';
import '../../colors.dart';
  import 'package:location/location.dart';

import '../../common_widgets.dart';
  import 'package:http/http.dart' as http;


class UpdateHospitalData extends StatefulWidget{
  UpdateHospitalData( this.pointOfInterest, this.token );
  PointOfInterest pointOfInterest;
  String  token;

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
                      initialValue: widget.pointOfInterest.contactPerson??"",
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
                      initialValue: widget.pointOfInterest.contactNum??"",
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
                      initialValue: widget.pointOfInterest.numOfBed.toString(),
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
                      initialValue: widget.pointOfInterest.numOfIcuBed.toString(),
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
                      initialValue: widget.pointOfInterest.occupiedIcuBed.toString(),
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
                      initialValue:widget.pointOfInterest.numOfVentilators.toString(),
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
                      initialValue: widget.pointOfInterest.occupiedVentilators.toString(),
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
                      initialValue: widget.pointOfInterest.numOfIsolationBed.toString(),
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
                      initialValue: widget.pointOfInterest.occupiedIsolationBed.toString(),
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
                      initialValue: widget.pointOfInterest.totalTested.toString(),
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
                      initialValue: widget.pointOfInterest.totalPositive.toString(),
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
                      initialValue: widget.pointOfInterest.totalDeath.toString(),
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
                      initialValue: widget.pointOfInterest.totalInIsolation.toString(),
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
                      initialValue: widget.pointOfInterest.remarks??"",
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

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token '+widget.token,
    };

    print("headers"+ headers.toString());

    Map<String, dynamic> formData = {
      "contact_person": _fbHospitalKey.currentState.value.containsKey("contact_person")? _fbHospitalKey.currentState.value["contact_person"].toString():"",
      "contact_num": _fbHospitalKey.currentState.value.containsKey("contact_num")? _fbHospitalKey.currentState.value["contact_num"] .toString(): "",
      "num_of_bed": _fbHospitalKey.currentState.value.containsKey("num_of_bed") ? int.parse(_fbHospitalKey.currentState.value["num_of_bed"]) : 0,
      "num_of_icu_bed": _fbHospitalKey.currentState.value.containsKey("num_of_icu_bed") ? int.parse(_fbHospitalKey.currentState.value["num_of_icu_bed"]) : 0,
      "occupied_icu_bed": _fbHospitalKey.currentState.value.containsKey("occupied_icu_bed") ? int.parse(_fbHospitalKey.currentState.value["occupied_icu_bed"]) : 0,
      "num_of_ventilators": _fbHospitalKey.currentState.value.containsKey("num_of_ventilators") ? int.parse(_fbHospitalKey.currentState.value["num_of_ventilators"]) : 0,
      "occupied_ventilators": _fbHospitalKey.currentState.value.containsKey("occupied_ventilators")? int.parse(_fbHospitalKey.currentState.value["occupied_ventilators"]) : 0,
      "num_of_isolation_bed": _fbHospitalKey.currentState.value.containsKey("num_of_isolation_bed") ? int.parse(_fbHospitalKey.currentState.value["num_of_isolation_bed"]) : 0,
      "occupied_isolation_bed": _fbHospitalKey.currentState.value.containsKey("occupied_isolation_bed")? int.parse(_fbHospitalKey.currentState.value["occupied_isolation_bed"]) : 0,
      "total_tested": _fbHospitalKey.currentState.value.containsKey("total_tested")? int.parse(_fbHospitalKey.currentState.value["total_tested"]) : 0,
      "total_positive": _fbHospitalKey.currentState.value.containsKey("total_positive")? int.parse(_fbHospitalKey.currentState.value["total_positive"]) : 0,
      "total_death": _fbHospitalKey.currentState.value.containsKey("total_death") ? int.parse(_fbHospitalKey.currentState.value["total_death"]) : 0,
      "total_in_isolation": _fbHospitalKey.currentState.value.containsKey("total_in_isolation") ? int.parse(_fbHospitalKey.currentState.value["total_in_isolation"]) : 0,
      "remarks": _fbHospitalKey.currentState.value.containsKey("remarks") ? _fbHospitalKey.currentState.value["remarks"].toString() : "",
      "type": widget.pointOfInterest.type,
    };

    print('uploadFormNAXA: '+jsonEncode(formData).toString());


    var response = await http.put(get_health_facilities+widget.pointOfInterest.id.toString()+"/",
        headers: headers,
        body: jsonEncode(formData));
    setState(() {
      isUploadingForm = false;
    });
    if(response.statusCode == 200){
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MyApp()));
    }
  }
}