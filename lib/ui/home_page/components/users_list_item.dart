import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/blocs/posts_bloc/posts_bloc.dart';
import 'package:test_project/blocs/posts_bloc/posts_state.dart';
import 'package:test_project/models/user_model.dart';
import 'package:test_project/ui/home_page/components/posts_widget.dart';

class UsersListItems extends StatefulWidget {
  const UsersListItems({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  State<UsersListItems> createState() => _UsersListItemsState();
}

class _UsersListItemsState extends State<UsersListItems> {
  bool expanded = false;

  @override
  void initState() {
    super.initState();
  }

  PostBloc bloc = PostBloc();

  double getHeight(PostsState state) {
    final height = MediaQuery.of(context).size.width / 1.2;
    if (expanded) {
      if (state is PostsLoadingState) {
        return height + 60;
      } else if (state is PostsLoadedState) {
        return height +
            (Theme.of(context).textTheme.bodyText1!.fontSize! * 4) *
                state.posts.length;
      } else {
        return height;
      }
    } else {
      return height;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostsState>(
      bloc: bloc,
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: getHeight(state),
          color: Colors.white,
          margin: const EdgeInsets.all(15),
          child: Column(
            children: [
              Material(
                child: InkWell(
                  onTap: () {
                    expanded = !expanded;
                    bloc.state is PostsLoadedState
                        ? null
                        : bloc.loadPosts(widget.user.id);
                    setState(() {});
                  },
                  child: Container(
                    color: Colors.white,
                    child: SizedBox.square(
                      dimension: MediaQuery.of(context).size.width / 1.2,
                      child: Column(
                        children: [
                          Flexible(child: Image.asset(widget.user.avatarPath)),
                          Text(widget.user.name),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (state is PostsLoadingState)
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: CircularProgressIndicator(),
                ),
              if (state is PostsLoadedState && expanded)
                Column(
                  children: state.posts
                      .map((e) => PostsWidget(post: e, userModel: widget.user))
                      .toList(),
                )
            ],
          ),
        );
      },
    );
  }
}
