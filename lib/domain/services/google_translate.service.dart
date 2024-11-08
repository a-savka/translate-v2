import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:translate_1/domain/models/errors/generic_error.model.dart';
import 'package:translate_1/domain/models/errors/http_error.model.dart';

class GoogleTranslateService {
  Future<List<String>> translate(String text) async {
    final uri = Uri(
        scheme: 'https',
        host: 'translate.google.com',
        path: 'translate_a/single',
        queryParameters: {'client': 'at', 'dt': 't', 'dj': '1'});

    http.Response response;
    try {
      response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        encoding: Encoding.getByName('utf-8'),
        body: {'q': text, 'sl': 'en', 'tl': 'ru'},
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
      if (data.containsKey('sentences')) {
        return (data['sentences'] as List<dynamic>)
            .map((e) => e['trans'] as String)
            .toList();
      }
      throw GenericError(code: 2, message: 'No translation response data');
    } else {
      print('error ${response.statusCode} ${response.body}');
      throw HttpError(code: response.statusCode, message: response.body);
    }
  }
}
