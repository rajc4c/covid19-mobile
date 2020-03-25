import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CovidAuth {
  final storage = new FlutterSecureStorage();
  final key = "token";

  saveToken(String value) async {
    await storage.write(key: key, value: value);
  }

  deleteAll() async {
    await storage.deleteAll();
  }

  loadToken() async {
    String value = await storage.read(key: key);
    return value;
  }
}

final CovidAuth covidAuth = CovidAuth();
