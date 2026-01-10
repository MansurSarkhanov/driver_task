import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  static String get googleApiKey => dotenv.env['GOOGLE_API_KEY'] ?? '';
}
