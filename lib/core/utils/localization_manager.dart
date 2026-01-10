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
    Locale('ru')
  ];
}