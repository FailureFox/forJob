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

class _UsersListItemsState extends State<UsersListItems>
    with SingleTickerProviderStateMixin {
  bool expanded = false;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      value: 1,
      vsync: this,
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 250),
    );
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
                    expanded ? controller.forward() : controller.reverse();
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
                      .map(
                        (e) => PostsWidget(post: e, userModel: widget.user),
                      )
                      .toList(),
                )
            ],
          ),
        );
      },
    );
  }
}
// AnimatedContainer(
//             width: getHeight(state),
//             height: getHeight(state),
//             duration: const Duration(milliseconds: 300),
//             clipBehavior: Clip.hardEdge,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(5),
//             ),
//             margin: const EdgeInsets.all(5),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Material(
//                   child: InkWell(
//                     onTap: () {
//                       expanded ? controller.forward() : controller.reverse();
//                       expanded = !expanded;
//                       bloc.state is PostsLoadedState
//                           ? null
//                           : bloc.loadPosts(widget.user.id);
//                       setState(() {});
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Flexible(
//                             child:
//                                 Image.network(widget.user.avatars.first.url)),
//                         const SizedBox(width: 10),
//                         Text(widget.user.name),
//                         const Spacer(),
//                         AnimatedIcon(
//                           icon: AnimatedIcons.close_menu,
//                           progress: controller,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 if (state is PostsLoadingState)
//                   const SizedBox.square(
//                       dimension: 30, child: CircularProgressIndicator()),
//                 if (state is PostsLoadedState && expanded)
//                   ...state.posts
//                       .map((e) => PostsWidget(
//                             post: e,
//                             userModel: widget.user,
//                           ))
//                       .toList(),
//               ],
//             ),
//           );