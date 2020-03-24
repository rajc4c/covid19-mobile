import 'dart:async';

import 'package:openspaces/covid19/api.dart';
import 'package:openspaces/covid19/base_inherited_bloc_provider.dart';
import 'package:openspaces/covid19/modal/homestat.dart';
import 'package:http/http.dart' as http;

class HomeBloc extends BaseBloc {
  StreamController<HomeStat> _streamController = StreamController();

  getHomeData() {
    try {
      http.get(get_home_stat).timeout(Duration(minutes: 5)).then((resp) {
        if(resp.statusCode >= 200 && resp.statusCode <= 400) {

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
    // TODO: implement dispose
  }
}