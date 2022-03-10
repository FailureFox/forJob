import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/blocs/post_details_bloc/post_details_State.dart';
import 'package:test_project/domain/comments_domain.dart';
import 'package:test_project/domain/posts_domain.dart';
import 'package:test_project/models/comments_model.dart';

class PostDetailsBloc extends Cubit<PostDetailsState> {
  CommentsDomain domain = CommentsDomain();
  final int id;
  PostDetailsBloc({required this.id}) : super(PostDetailsState()) {
    loadComments();
  }

  loadComments() async {
    try {
      emit(state.copyWith(status: PostDetailsStatus.loading));
      final List<CommentModel> comments = await domain.getPostComments(id);
      emit(
          state.copyWith(comments: comments, status: PostDetailsStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: PostDetailsStatus.error));
    }
  }

  sendComment(
      {required String text,
      required String email,
      required String name}) async {
    if (text != '') {
      emit(state.copyWith(status: PostDetailsStatus.sending));
      final CommentModel model =
          await domain.sendPostComment(text: text, email: email, name: name);
      final List<CommentModel> comments = [model, ...state.comments];
      emit(
          state.copyWith(comments: comments, status: PostDetailsStatus.sended));
    }
  }
}
