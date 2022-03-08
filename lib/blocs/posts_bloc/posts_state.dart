import 'package:test_project/blocs/posts_bloc/posts_bloc.dart';

abstract class PostsState {
  const PostsState();
}

class PostsInitialState extends PostsState {
  const PostsInitialState();
}

class PostsLoadingState extends PostsState {}

class PostsLoadedState extends PostsState {
  List<PostModel> posts;

  PostsLoadedState({required this.posts});
}

class PostsErrorState extends PostsState {
  String error;
  PostsErrorState({required this.error});
}
