import 'package:test_project/blocs/post_add_bloc/post_add_state.dart';
import 'package:test_project/models/post_model.dart';
import 'package:test_project/models/user_model.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitialState extends HomeState {
  const HomeInitialState();
}

class HomeLoadedState extends HomeState {
  List<UserModel> users;
  int? selectedItem;
  final List<PostModel> posts;
  UniversalStatus postsStatus;
  HomeLoadedState({
    required this.users,
    this.selectedItem,
    this.postsStatus = UniversalStatus.initial,
    this.posts = const [],
  });

  HomeLoadedState copyWith({
    List<UserModel>? users,
    int? selectedItem,
    List<PostModel>? posts,
    UniversalStatus? postsStatus,
  }) {
    return HomeLoadedState(
      users: users ?? this.users,
      selectedItem: selectedItem ?? this.selectedItem,
      posts: posts ?? this.posts,
      postsStatus: postsStatus ?? this.postsStatus,
    );
  }
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState({required this.error});
}
