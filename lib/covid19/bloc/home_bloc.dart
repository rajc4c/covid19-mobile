import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:openspaces/covid19/api.dart';
import 'package:openspaces/covid19/base_inherited_bloc_provider.dart';
import 'package:openspaces/covid19/modal/global_stat.dart';
import 'package:openspaces/covid19/modal/homestat.dart';
import 'package:http/http.dart' as http;

class HomeBloc extends BaseBloc {
  StreamController<HomeStat> _streamController = StreamController();
  StreamController<GlobalStat> _globalStreamController = StreamController();

  Stream<HomeStat> get homeStream => _streamController.stream;
  Stream<GlobalStat> get globalStatStream => _globalStreamController.stream;


  getHomeData({ @required String province}) {
    try {
      print("[homeApiCalled]");
      String url = get_home_stat;
      if(province.isNotEmpty) {
        url = "$get_home_stat/?provice=$province";
      }
     print("[homeApi][url] ===========>>> $url");
      http.get("$url").timeout(Duration(minutes: 5)).then((resp) {
        print("[homedata]======>>> ${resp.body}");
        if(resp.statusCode >= 200 && resp.statusCode <= 400) {
          Map<String, dynamic> respMap = jsonDecode(resp.body);
          _streamController.sink.add(HomeStat.fromJson(respMap));
        }
      }, onError: (err) {
        print(err.toString());
        _streamController.sink.addError(err.toString());
      });
    } catch (e) {
      _streamController.sink.addError(e.toString());
    }
  }

   globalData() {
    try {
      print("[globalApiCalled]");
      String url = get_home_stat;
      print("[homeApi][url] ===========>>> $url");
      http.get(get_global_stat).timeout(Duration(minutes: 5)).then((resp) {
        print("[globalData]======>>> ${resp.body}");
        if(resp.statusCode >= 200 && resp.statusCode <= 400) {
          Map<String, dynamic> respMap = jsonDecode(resp.body);
          _globalStreamController.sink.add(GlobalStat.fromJson(respMap));
        }
      }, onError: (err) {
        print(err.toString());
        _globalStreamController.sink.addError(err.toString());
      });
    } catch (e) {
      _globalStreamController.sink.addError(e.toString());
    }
  }

  @override
  void clearCache() {
    // TODO: implement clearCache
  }

  @override
  void dispose() {
    _streamController.close();
    _globalStreamController.close();
  }
}
