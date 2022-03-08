import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/blocs/post_add_page_bloc/post_add_state.dart';
import 'package:test_project/blocs/posts_bloc/posts_bloc.dart';
import 'package:test_project/domain/posts_domain.dart';

class PostAddBloc extends Cubit<PostAddState> {
  final PostsDomain domain = PostsDomain();
  final int id;
  PostAddBloc({required this.id}) : super(PostAddState());
  onTitleChange(String text) {
    emit(state.copyWith(title: text));
  }

  onBodyChange(String text) {
    emit(state.copyWith(body: text));
  }

  onSave() async {
    emit(state.copyWith(status: PostAddStatus.loading));
    try {
      final PostModel post = await domain.addPost({
        'userId': id,
        'title': state.title,
        'body': state.body,
      });
      final List<PostModel> posts = [...state.posts, post];

      print(post);
      emit(state.copyWith(
          title: '', body: '', posts: posts, status: PostAddStatus.added));
    } catch (e) {
      emit(state.copyWith(status: PostAddStatus.error));
    }
  }
}
