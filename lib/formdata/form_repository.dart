import 'dart:convert';

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
      return response.body;
    });
  }
}

FormRepository formRepository = FormRepository();
