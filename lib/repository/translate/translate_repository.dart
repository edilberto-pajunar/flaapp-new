import 'dart:convert';
import 'dart:developer';

import 'package:flaapp/repository/translate/base_translate_repository.dart';
import 'package:flaapp/utils/constant/strings/api.dart';
import 'package:http/http.dart' as http;

class TranslateRepository extends BaseTranslateRepository {
  final String baseUrl = "api-free.deepl.com";

  @override
  Future<String> translateWord(String word, String language) async {
    final uri = Uri.https(
      baseUrl,
      "/v2/translate",
    );

    log("Calling: $uri");

    final Map<String, dynamic> body = {
      "text": [
        word,
      ],
      "target_lang": language,
    };

    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: FlaappAPI.headers,
    );

    log("Response: ${response.reasonPhrase}");

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return body["translations"][0]["text"];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
