import 'package:flutter/material.dart';
import 'package:test_project/blocs/posts_bloc/posts_bloc.dart';
import 'package:test_project/models/user_model.dart';

class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({Key? key, required this.user, required this.post})
      : super(key: key);
  final PostModel post;
  final UserModel? user;
  @override
  Widget build(BuildContext context) {
    final isMe = user == null;
    return Scaffold(
      appBar: AppBar(
        title: Text('PostDetails'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text('title: ${post.title}'),
              SizedBox(height: 10),
              Text('body: ${post.body}'),
              SizedBox(height: 10),
              Text('postId: ${post.id}'),
              SizedBox(height: 10),
              Text('id отправителя: ${post.userId}'),
              SizedBox(height: 10),
              Text('Отправитель: ${isMe ? 'Вы' : user!.name}'),
            ],
          ),
        ),
      ),
    );
  }
}
