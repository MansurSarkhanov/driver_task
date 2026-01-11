import 'dart:ui';

class LocalizationManager {
  static LocalizationManager? _instance;

  LocalizationManager._();

  static LocalizationManager get instance {
    _instance ??= LocalizationManager._();
    return _instance!;
  }

  static const path = "assets/translations";

  static List<Locale> supportedLocales = [
    Locale('az'),
    Locale('en'),
    Locale('ru'),
  ];

  static List<LanguageModel> supportedLanguages = [
    LanguageModel(locale: Locale('az'), name: "Azərbaycan"),
    LanguageModel(locale: Locale('en'), name: "English"),
    LanguageModel(locale: Locale('ru'), name: "Русский"),
  ];
}

class LanguageModel {
  final Locale locale;
  final String name;

  LanguageModel({required this.locale, required this.name});
}
