import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:openspaces/covid19/api.dart';

class FormRepository {
  Future<String> uploadSymtomForm(formData) {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    print(jsonEncode(formData));
    return http
        .post(Uri.encodeFull(post_user_report),
            headers: headers, body: jsonEncode(formData))
        .then((response) {
      if (response.statusCode != 201) {
        throw Error();
      }
      return json.decode(utf8.decode(response.bodyBytes))['message'];
    });
  }

  Future<String> uploadSymptomFormC4C(_formData) async {
    String uriSymptom = 'https://covid19.mohp.gov.np/covid/api/symptomstore';

    Dio dio = Dio();
    try {
      Response response = await dio.post(uriSymptom, data: _formData);
      print(response);
      return response.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }

  Future<String> uploadSuspectFormC4C(_formData) async {
    print('inside upload suspect form c4c');
    print(_formData);
    print('inside upload suspect form c4c');
    String uriSuspect = 'https://covid-19.c4cprojects.com/api/suspectstore';
  
    Dio dio = Dio();
    try {
      Response response = await dio.post(uriSuspect, data: _formData);
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }
}

FormRepository formRepository = FormRepository();
