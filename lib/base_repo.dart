
import 'covid19/form_data.dart';

abstract class Source {
  Future<String> getData(String url);

  Future<String> post({String url, OpenSpaceFormData openSpaceFormData});
}

abstract class Cache {
  Future<String> getData(String url);

  Future<bool> saveToCache(String key, String value);

  Future<bool> clearCache(String key);

  Future<bool> shouldForceLoadFromCache(String key);
}
