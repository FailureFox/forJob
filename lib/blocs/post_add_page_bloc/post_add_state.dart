import 'package:test_project/blocs/posts_bloc/posts_bloc.dart';

class PostAddState {
  List<PostModel> posts;
  String title;
  String body;
  PostAddStatus status;
  PostAddState({
    this.posts = const [],
    this.status = PostAddStatus.initial,
    this.title = '',
    this.body = '',
  });

  PostAddState copyWith({
    List<PostModel>? posts,
    String? title,
    String? body,
    PostAddStatus? status,
  }) {
    return PostAddState(
      posts: posts ?? this.posts,
      title: title ?? this.title,
      body: body ?? this.body,
      status: status ?? this.status,
    );
  }
}

enum PostAddStatus { initial, added, loading, error }
