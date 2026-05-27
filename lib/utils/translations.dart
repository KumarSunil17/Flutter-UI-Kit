import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Translations {
  Translations(this.locale);

  final Locale locale;
  static Map<dynamic, dynamic> _localizedValues = {};

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations)!;
  }

  String text(String key) {
    return _localizedValues[key]?.toString() ?? '** $key not found';
  }

  static Future<Translations> load(Locale locale) async {
    final translations = Translations(locale);
    final jsonContent =
        await rootBundle.loadString("locale/i18n_${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent) as Map<dynamic, dynamic>;
    return translations;
  }

  String get currentLanguage => locale.languageCode;
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}
