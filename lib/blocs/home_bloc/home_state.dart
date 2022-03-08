import 'package:test_project/models/user_model.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitialState extends HomeState {
  const HomeInitialState();
}

class HomeLoadedState extends HomeState {
  List<UserModel> users;
  HomeLoadedState({required this.users});
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState({required this.error});
}
