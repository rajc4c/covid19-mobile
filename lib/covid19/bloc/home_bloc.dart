import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:openspaces/covid19/api.dart';
import 'package:openspaces/covid19/base_inherited_bloc_provider.dart';
import 'package:openspaces/covid19/modal/global_stat.dart';
import 'package:openspaces/covid19/modal/homestat.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class HomeBloc extends BaseBloc {
  BehaviorSubject<HomeStat> _streamController = BehaviorSubject();
  BehaviorSubject<GlobalStat> _globalStreamController = BehaviorSubject();

  Stream<HomeStat> get homeStream => _streamController.stream;

  Stream<GlobalStat> get globalStatStream => _globalStreamController.stream;

  getHomeData() {
    try {
      print("[homeApiCalled]");
      String url = get_all_stat;
     print("[homeApi][url] ===========>>> $url");
      http.get("$url").timeout(Duration(minutes: 5)).then((resp) {
        print("[homedata]======>>> ${resp.body}");
        if (resp.statusCode >= 200 && resp.statusCode <= 400) {
          Map<String, dynamic> respMap = jsonDecode(resp.body);
          _streamController.sink.add(HomeStat.fromJson(respMap['nepal']));
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
      String url = get_all_stat;
      print("[homeApi][url] ===========>>> $url");
      http.get(get_global_stat).timeout(Duration(minutes: 5)).then((resp) {
        print("[globalData]======>>> ${resp.body}");
        if (resp.statusCode >= 200 && resp.statusCode <= 400) {
          List response = jsonDecode(resp.body) as List;
          if (response == null || response.isEmpty) {
            _globalStreamController.sink.addError("Server not respoding");
          } else {
            Map<String, dynamic> respMap = response[0];
            _globalStreamController.sink.add(GlobalStat.fromJson(respMap));
          }
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

final HomeBloc homeBloc = HomeBloc();
