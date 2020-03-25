import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:openspaces/covid19/api.dart';
import 'package:openspaces/covid19/base_inherited_bloc_provider.dart';
import 'package:openspaces/covid19/modal/homestat.dart';
import 'package:http/http.dart' as http;

class HomeBloc extends BaseBloc {
  StreamController<HomeStat> _streamController = StreamController();
  Stream<HomeStat> get homeStream => _streamController.stream;

  getHomeData({ @required String province}) {
    try {
      print("[homeApiCalled]");
      http.get("$get_home_stat/?provice=$province").timeout(Duration(minutes: 5)).then((resp) {
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

  @override
  void clearCache() {
    // TODO: implement clearCache
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
