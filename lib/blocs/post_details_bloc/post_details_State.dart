import 'package:test_project/domain/posts_domain.dart';

class PostDetailsState {
  List<CommentModel> comments;
  PostDetailsStatus status;
  PostDetailsState(
      {this.status = PostDetailsStatus.initial, this.comments = const []});

  PostDetailsState copyWith({
    List<CommentModel>? comments,
    PostDetailsStatus? status,
  }) {
    return PostDetailsState(
      comments: comments ?? this.comments,
      status: status ?? this.status,
    );
  }
}

enum PostDetailsStatus { loading, loaded, initial, sending, sended, error }
