import 'package:http/http.dart' as http;

import '../../base_repo.dart';
import '../form_data.dart';

class BaseNetworkProvider extends Source {
  @override
  Future<String> getData(String url) {
    return http.get(url).then((response) {
      if (response.statusCode != 200) {
//        print("[BaseNetworkProvider] returned ${response.statusCode}");
        return null;
      }

      return response.body;
    }).catchError((onError) {
//      print("[BaseNetworkProvider] had an error ${onError.toString()}");
//      print(onError);
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
        file.abs_path,
      ));
    }

    var response = await postRequest.send();
    print("POST on $url returned ${response.statusCode.toString()}");
    print("Had Uploaded ${openSpaceFormData.formFields.toString()}");
    return response.statusCode.toString();
  }
}

BaseNetworkProvider baseNetworkProvider = BaseNetworkProvider();
