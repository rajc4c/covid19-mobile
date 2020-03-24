import 'base_api_provider.dart';
import 'base_cache_provider.dart';
import 'base_repo.dart';

class BaseRepository {
  List<Source> _sources = <Source>[baseNetworkProvider];
  List<Cache> _caches = <Cache>[baseCacheProvider];

  Future<String> fetchItem(String url,
      {forceLoadFromCache = false,
      shouldCache = true,
      Map<String, String> headers}) async {
    String result;

    for (var source in _caches) {
      forceLoadFromCache = await source.shouldForceLoadFromCache(url);
      print("Loading from cache as not reached max-age $forceLoadFromCache");
      if (forceLoadFromCache) break;
    }

    if (forceLoadFromCache) {
      result = await _fetchFromCaches(url);
      return result;
    }

    result = await _fetchFromSources(url, headers);

    if (result != null && shouldCache) {
      _addToCache(url, result);
      return result;
    }

    result = await _fetchFromCaches(url);
    return result;
  }

  Future<String> _fetchFromSources(
      String url, Map<String, String> headers) async {
    var result;
    for (var source in _sources) {
      result = await source
          .getData(url, headers: headers)
          .timeout(Duration(seconds: 60));
      if (result != null) break;
    }

    return result;
  }

  Future<String> _fetchFromCaches(String url) async {
    var result;
    for (var source in _caches) {
      result = await source.getData(url);
      if (result != null) break;
    }

    return result;
  }

  void _addToCache(String url, String result) {
    for (var cache in _caches) {
      cache.saveToCache(url, result);
    }
  }

  void clearCache() {
    //todo clear all cache
  }
}
