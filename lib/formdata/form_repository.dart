import 'package:http/http.dart' as http;
import 'package:openspaces/covid19/api.dart';

class FormRepository {
  Future<int> uploadSymtomForm(formData) {
    return http
        .post(Uri.encodeFull(post_user_report), body: formData)
        .then((response) {
      return response.statusCode;
    });
  }
}

FormRepository formRepository = FormRepository();
