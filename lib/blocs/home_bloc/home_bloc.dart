import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/blocs/home_bloc/home_state.dart';
import 'package:test_project/domain/user_domain.dart';
import 'package:test_project/models/user_model.dart';

class HomeBloc extends Cubit<HomeState> {
  final UsersDomain userDomain;
  HomeBloc({required this.userDomain}) : super(const HomeInitialState()) {
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
}
