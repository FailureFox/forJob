import 'dart:convert';

import 'package:test_project/blocs/posts_bloc/posts_bloc.dart';
import 'package:test_project/domain/http_domain.dart';

class PostsDomain {
  static const link = 'jsonplaceholder.typicode.com';
  Future<List<CommentModel>> getPostComments(int id) async {
    final postMap = await HttpDomain.domain
        .get(url: link, path: '/comments', query: {'postId': '$id'}) as List;
    return postMap.map((e) => CommentModel.fromMap(e)).toList();
  }

  Future<List<PostModel>> getPosts(int id) async {
    final List map = await HttpDomain.domain
        .get(url: link, path: '/posts', query: {'userId': '$id'});
    return map.map((e) => PostModel.fromMap(e)).toList();
  }

  Future<PostModel> addPost(Map<String, dynamic> map) async {
    final post = await HttpDomain.domain.post(
      url: link,
      path: '/posts',
      post: map,
      header: {'Content-type': 'application/json; charset=UTF-8'},
    );
    return PostModel.fromMap(post);
  }
}

class CommentModel {
  int postId;
  int id;
  String name;
  String email;
  String body;
  CommentModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      postId: map['postId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));
}
