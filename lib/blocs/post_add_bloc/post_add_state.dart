import 'package:test_project/models/post_model.dart';

class PostAddState {
  List<PostModel> posts;
  String title;
  String body;
  UniversalStatus status;
  PostAddState({
    this.posts = const [],
    this.status = UniversalStatus.initial,
    this.title = '',
    this.body = '',
  });

  PostAddState copyWith({
    List<PostModel>? posts,
    String? title,
    String? body,
    UniversalStatus? status,
  }) {
    return PostAddState(
      posts: posts ?? this.posts,
      title: title ?? this.title,
      body: body ?? this.body,
      status: status ?? this.status,
    );
  }
}

enum UniversalStatus { initial, loaded, loading, error }
