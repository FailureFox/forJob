import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: HttpDomain()
            .get(url: 'jsonplaceholder.typicode.com', path: '/users'),
        builder: (context, AsyncSnapshot as) {
          if (as.hasData && as.data != null) {
            return ListView.builder(
                itemCount: (as.data as List).length,
                itemBuilder: (context, index) {
                  return Text(as.data[index]['name']);
                });
          } else {
            return Container(color: Colors.red);
          }
        },
      ),
    );
  }
}

class HttpDomain {
  Future<dynamic> get(
      {required String url,
      required String path,
      Map<String, dynamic>? query}) async {
    try {
      Uri uri = Uri.https(url, path, query);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonString = response.body;
        return jsonDecode(jsonString);
      } else {
        throw Exception('Ошибка');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  post(
      {required String url,
      required String path,
      required Map<String, dynamic> post,
      required Map<String, String>? header,
      Map<String, dynamic>? query}) async {
    try {
      Uri uri = Uri.https(url, path, query);
      final response = await http.post(uri, body: post, headers: header);
      if (response.statusCode == 200) {
        final jsonString = response.body;
        return jsonDecode(jsonString);
      } else {
        throw Exception('Ошибка');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
