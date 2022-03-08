import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/blocs/home_bloc/home_bloc.dart';
import 'package:test_project/blocs/home_bloc/home_state.dart';
import 'package:test_project/blocs/post_add_bloc/post_add_state.dart';
import 'package:test_project/models/post_model.dart';
import 'package:test_project/models/user_model.dart';
import 'package:test_project/ui/home_page/components/posts_widget.dart';
import 'package:test_project/ui/home_page/components/users_list.dart';

import 'sub_pages/post_add_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddPage()));
              },
              child: const Text('Добавить'))
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeLoadedState) {
          return Column(
            children: [
              UsersList(
                  users: state.users, selectedIndex: state.selectedItem ?? -1),
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: PostListHandling(state: state),
                ),
              )
            ],
          );
        } else if (state is HomeLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeErrorState) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}

class PostListHandling extends StatelessWidget {
  const PostListHandling({Key? key, required this.state}) : super(key: key);
  final HomeLoadedState state;
  @override
  Widget build(BuildContext context) {
    final status = state.postsStatus;
    switch (status) {
      case UniversalStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case UniversalStatus.loaded:
        return PostList(
            posts: state.posts, user: state.users[state.selectedItem!]);
      case UniversalStatus.initial:
        return const Center(child: Text('Выберите'));
      default:
        return const Center(child: Text('Ошибка'));
    }
  }
}

class PostList extends StatelessWidget {
  const PostList({Key? key, required this.posts, required this.user})
      : super(key: key);
  final List<PostModel> posts;
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostsWidget(post: posts[index], userModel: user);
        });
  }
}
