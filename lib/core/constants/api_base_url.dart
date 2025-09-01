import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConstants {
  static String baseUrl = dotenv.env['BASE_URL']!;


}
