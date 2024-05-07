import 'dart:convert';

import 'package:flaapp/repository/translate/base_translate_repository.dart';
import 'package:flaapp/values/constant/strings/api_key.dart';
import 'package:http/http.dart' as http;

class TranslateRepository extends BaseTranslateRepository {
  final String baseUrl = "api-free.deepl.com";

  @override
  Future<String> translateWord(String word) async {
    final uri = Uri.https(
      baseUrl,
      "/v2/translate",
    );

    final response = await http.post(uri, body: {
      "text": [
        word,
      ],
      "target_lang": "DE",
    }, headers: {
      "Content-Type": "application/json",
      "DeepL-Auth-Key": APIKey.deeplApi,
    });

    if (response.statusCode == 200) {
      final body = response.body;

      return jsonDecode(body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
