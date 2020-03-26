import 'package:intl/intl.dart';

class AppLocales {
  AppLocales();
  // list of locales
  String get heyWorld {
    return Intl.message('Hey World', name: 'heyWorld',);
  }

  String get localeTest {
    return Intl.message('Locale Test', name: 'localeTest',);
  }


}