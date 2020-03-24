import 'base_repo.dart';
import 'helper/preferences.dart';

class BaseCacheProvider extends Cache {
  @override
  Future<String> getData(String url) {
    return SharedPreferencesHelper.getByUrl(url);
  }

  @override
  Future<bool> saveToCache(String key, String value) async {
    bool saved = await SharedPreferencesHelper.save(key, value);
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    bool savedAge =
        await SharedPreferencesHelper.saveLastSavedTime(key, currentTime);
    return saved && savedAge;
  }

  @override
  Future<bool> clearCache(String key) async {
    bool cleared = await SharedPreferencesHelper.clear(key);
    return cleared;
  }

  @override
  Future<bool> shouldForceLoadFromCache(String key) async {
    var maxAgeInMin = 30;

    int lastSavedTime = await SharedPreferencesHelper.getLastSavedTime(key);
    print("url $key last saved time: $lastSavedTime");

    if (lastSavedTime == null) {
      return false;
    }

    Duration difference = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(lastSavedTime));

    bool shouldForceLoadFromCache = difference.inMinutes <= maxAgeInMin;

    return shouldForceLoadFromCache;
  }
}

BaseCacheProvider baseCacheProvider = BaseCacheProvider();
