import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/blocs/home_bloc/home_state.dart';
import 'package:test_project/blocs/post_add_bloc/post_add_state.dart';
import 'package:test_project/domain/posts_domain.dart';
import 'package:test_project/domain/user_domain.dart';
import 'package:test_project/models/post_model.dart';
import 'package:test_project/models/user_model.dart';

class HomeBloc extends Cubit<HomeState> {
  final UsersDomain userDomain;
  final PostsDomain postDomain;
  HomeBloc({required this.userDomain, required this.postDomain})
      : super(const HomeInitialState()) {
    loading();
  }
  Future<void> loading() async {
    emit(const HomeLoadingState());
    try {
      final List<UserModel> users = await userDomain.getUsers();
      emit(HomeLoadedState(users: users));
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }

  Future<void> getPosts(int id, int index) async {
    final myState = state as HomeLoadedState;
    if (index != myState.selectedItem) {
      try {
        emit(myState.copyWith(postsStatus: UniversalStatus.loading));
        final List<PostModel> posts = await postDomain.getPosts(id);
        emit(myState.copyWith(
            selectedItem: index,
            posts: posts,
            postsStatus: UniversalStatus.loaded));
      } catch (e) {
        emit(myState.copyWith(postsStatus: UniversalStatus.error));
      }
    }
  }
}
