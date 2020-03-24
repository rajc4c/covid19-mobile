import 'package:http/http.dart' as http;

import 'base_repo.dart';
import 'data/form_data.dart';

class BaseNetworkProvider extends Source {
  @override
  Future<String> getData(String url, {Map<String, String> headers}) {
    return http.get(url, headers: headers).then((response) {
      if (response.statusCode != 200) {
        return null;
      }

      return response.body;
    }).catchError((onError) {
      print(onError);
      return null;
    });
  }

  @override
  Future<String> post({String url, OpenSpaceFormData openSpaceFormData}) async {
    var uri = Uri.parse(url);
    var postRequest = http.MultipartRequest("POST", uri);

    for (var key in openSpaceFormData.formFields.keys) {
      postRequest.fields[key] = openSpaceFormData.formFields[key];
    }

    for (var file in openSpaceFormData.files) {
      postRequest.files.add(await http.MultipartFile.fromPath(
        file.key,
        file.absPath,
      ));
    }

    var response = await postRequest.send();
    print("POST on $url returned ${response.statusCode.toString()}");
    return response.statusCode.toString();
  }
}

BaseNetworkProvider baseNetworkProvider = BaseNetworkProvider();
