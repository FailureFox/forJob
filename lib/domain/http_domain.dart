import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpDomain {
  HttpDomain._();
  static final domain = HttpDomain._();
  Future<dynamic> get(
      {required String url,
      required String path,
      Map<String, dynamic>? query}) async {
    try {
      Uri uri = Uri.https(url, path, query);

      final response = await http.get(uri);

      final jsonString = response.body;
      return jsonDecode(jsonString);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<dynamic> post({
    required String url,
    required String path,
    required Map<String, dynamic> post,
    required Map<String, String>? header,
    Map<String, dynamic>? query,
  }) async {
    try {
      final String json = jsonEncode(post);
      Uri uri = Uri.https(url, path, query);
      final response =
          await http.post(uri, body: utf8.encode(json), headers: header);
      if (response.statusCode == 201) {
        final jsonString = response.body;
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw Exception('Ошибка');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
