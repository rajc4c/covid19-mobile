import 'package:openspaces/covid19/api.dart';
import 'package:openspaces/covid19/form_data.dart';
import 'package:openspaces/covid19/repository/base_api_provider.dart';

class LoginRepository extends BaseNetworkProvider {
  void login(formData) {
    var openSpaceFormData = OpenSpaceFormData(formFields: formData, files: []);
    post(url: get_auth_token, openSpaceFormData: openSpaceFormData)
        .then((value) {
      print(value);
    });
  }
}

final LoginRepository loginRepository = LoginRepository();
