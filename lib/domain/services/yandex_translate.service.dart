import 'dart:convert';

import 'package:http/http.dart' as http;

const String apiKey =
    'trnsl.1.1.20160123T071304Z.26374f6d3b8aeaad.d0432de1b65a5ea05748c4401fb2376b99a1f5ab';
const String lang = 'en-ru';
const String url = 'https://translate.yandex.net/api/v1.5/tr.json/translate';

class YandexTranslateService {
  Future<List<String>> translate(String text) async {
    final uri = Uri(
        scheme: 'https',
        host: 'translate.yandex.net',
        path: 'api/v1.5/tr.json/translate',
        queryParameters: {'lang': lang, 'key': apiKey, 'text': text});

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('text')) {
          return data['text'] as List<String>;
        }
        throw 'No response data';
      } catch (e) {
        print('DECODE ERROR: ');
        print(e);
        rethrow;
      }
    } else {
      print('HTTP error: ${response.statusCode}');
      throw 'Http error';
    }
  }
}
