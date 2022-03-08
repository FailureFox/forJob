import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/domain/posts_domain.dart';
import 'package:test_project/models/user_model.dart';

import 'posts_state.dart';

class PostBloc extends Cubit<PostsState> {
  static final PostsDomain domain = PostsDomain();

  PostBloc() : super(const PostsInitialState());

  loadPosts(int id) async {
    try {
      emit(PostsLoadingState());
      final List<PostModel> posts = await domain.getPosts(id);
      emit(PostsLoadedState(posts: posts));
    } catch (e) {
      emit(PostsErrorState(error: e.toString()));
    }
  }
}

class PostModel {
  final int userId;
  final int id;
  final String title;
  final String body;
  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      userId: map['userId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));
}
