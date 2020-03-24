
import '../../base_repo.dart';
import '../api.dart';
import 'base_api_provider.dart';
import 'base_cache_provider.dart';

class BaseRepository {
//  List<Source> _sources = <Source>[baseNetworkProvider];
  List<Cache> _caches = <Cache>[baseCacheProvider];

  Future<String> fetchItem(String url,
      {forceLoadFromCache = false, shouldCache = true}) async {
    String result;

    for (var source in _caches) {
      forceLoadFromCache = await source.shouldForceLoadFromCache(url);
      if (forceLoadFromCache) break;
    }

    if (forceLoadFromCache) {
      result = await _fetchFromCaches(url);
      return result;
    }

    result = await _fetchFromSources(url);

    if (result != null && shouldCache) {
      _addToCache(url, result);
      return result;
    }

    result = await _fetchFromCaches(url);

    return result;
  }

  Future<String> _fetchFromSources(String url) async {
    var result = baseNetworkProvider.getData(url);
    if (url == get_open_space_geo_json) {
      result = result.timeout(Duration(seconds: 60));
    }
    return result;
    //    var result;
//    for (var source in _sources) {
//      result = await source.getData(url);
//      if (result != null) break;
//    }
//
//    return result;
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
    for (var cache in _caches) {
      cache.clearCache(get_open_space);
    }
  }
}
