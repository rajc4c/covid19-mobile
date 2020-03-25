import 'package:http/http.dart' as http;
import 'package:openspaces/covid19/api.dart';
import 'package:openspaces/covid19/repository/base_api_provider.dart';

class LoginRepository extends BaseNetworkProvider {
  Future<bool> login(formData) async {
    var uri = Uri.parse(get_auth_token);
    http.Response response = await http.post(
      uri,
      body: formData,
    );

    return response.statusCode != 200;
  }
}

final LoginRepository loginRepository = LoginRepository();
