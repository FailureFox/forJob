import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/blocs/home_bloc/home_bloc.dart';
import 'package:test_project/blocs/home_bloc/home_state.dart';
import 'package:test_project/ui/home_page/components/users_list.dart';

import 'components/users_list_item.dart';
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
          return UsersList(users: state.users);
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
