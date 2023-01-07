import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:translate_1/domain/models/errors/generic_error.model.dart';
import 'package:translate_1/domain/models/errors/http_error.model.dart';

class LibreTranslateService {
  Future<List<String>> translate(String text) async {
    final uri =
        Uri(scheme: 'https', host: 'libretranslate.com', path: 'translate');

    http.Response response;
    try {
      response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'origin': 'https://libretranslate.com',
        },
        body: json.encode({
          'q': text,
          'source': 'en',
          'target': 'ru',
          'format': 'text',
        }),
      );
    } catch (e, stackTrace) {
      throw GenericError(
        code: 1,
        message: 'can\'t send http request',
        details: e.toString(),
        stackTrace: stackTrace,
      );
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> data;
      try {
        data = json.decode(response.body);
      } catch (e, stackTrace) {
        throw GenericError(
          code: 1,
          message: 'Can\'t parse translation response JSON',
          details: e.toString(),
          stackTrace: stackTrace,
        );
      }
      if (data.containsKey('translatedText')) {
        return [data['translatedText'] as String];
      }
      throw GenericError(code: 2, message: 'No translation response data');
    } else {
      throw HttpError(code: response.statusCode, message: response.body);
    }
  }
}
