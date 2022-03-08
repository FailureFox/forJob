import 'package:flutter/material.dart';
import 'package:test_project/blocs/posts_bloc/posts_bloc.dart';
import 'package:test_project/models/user_model.dart';
import 'package:test_project/ui/home_page/sub_pages/post_details_page.dart';

class PostsWidget extends StatelessWidget {
  const PostsWidget({Key? key, required this.post, required this.userModel})
      : super(key: key);
  final PostModel post;
  final UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          child: ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostDetailsPage(
                          post: post,
                          user: userModel,
                        ))),
            title: Text(post.title),
          ),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
