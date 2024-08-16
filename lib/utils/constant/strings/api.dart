import 'package:flaapp/utils/constant/strings/api_key.dart';

class FlaappAPI {
  static const String baseUrl = "api-free.deepl.com";

  static const Map<String, String> headers = {
    "Authorization": "DeepL-Auth-Key ${APIKey.deeplApi}",
    "Content-Type": "application/json",
  };
}
