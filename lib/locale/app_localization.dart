import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openspaces/l10n/messages_all.dart';
import 'package:openspaces/locale/app_locales.dart';

class AppLocalization {
  static Future<AppLocalization> load(Locale locale) {
    final String name =
    locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  // list of locales
  AppLocales appLocales = AppLocales();
  String get heyWorld {
    return appLocales.heyWorld;
  }

  String get localeTest {
    return appLocales.localeTest;
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final Locale overriddenLocale;

  AppLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) =>
      ['en', 'np', ].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}