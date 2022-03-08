import 'dart:convert';

import 'package:test_project/blocs/posts_bloc/posts_bloc.dart';
import 'package:test_project/domain/http_domain.dart';

class PostsDomain {
  Future<List<PostModel>> getPosts(int id) async {
    final List map = await HttpDomain.domain.get(
        url: 'jsonplaceholder.typicode.com',
        path: '/posts',
        query: {'userId': '$id'});
    return map.map((e) => PostModel.fromMap(e)).toList();
  }

  Future<PostModel> addPost(Map<String, dynamic> map) async {
    final post = await HttpDomain.domain.post(
      url: 'jsonplaceholder.typicode.com',
      path: '/posts',
      post: map,
      header: {'Content-type': 'application/json; charset=UTF-8'},
    );
    return PostModel.fromMap(post);
  }
}
