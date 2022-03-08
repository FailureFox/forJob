import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/blocs/post_details_bloc/post_details_State.dart';
import 'package:test_project/blocs/post_details_bloc/post_details_bloc.dart';
import 'package:test_project/models/comments_model.dart';
import 'package:test_project/models/post_model.dart';
import 'package:test_project/models/user_model.dart';

class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({Key? key, required this.user, required this.post})
      : super(key: key);
  final PostModel post;
  final UserModel? user;
  @override
  Widget build(BuildContext context) {
    final isMe = user == null;
    return BlocProvider(
      create: (_) => PostDetailsBloc(id: post.id),
      child: Scaffold(
        appBar: AppBar(
          title: Text('PostDetails'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text('title: ${post.title}'),
              const SizedBox(height: 10),
              Text('body: ${post.body}'),
              const SizedBox(height: 10),
              Text('postId: ${post.id}'),
              const SizedBox(height: 10),
              Text('id отправителя: ${post.userId}'),
              const SizedBox(height: 10),
              Text('Отправитель: ${isMe ? 'Вы' : user!.name}'),
              const Divider(height: 20),
              Text('Comments', style: Theme.of(context).textTheme.headline6),
              const CommentInputWidget(),
              const CommentsList()
            ],
          ),
        ),
      ),
    );
  }
}

class CommentInputWidget extends StatefulWidget {
  const CommentInputWidget({Key? key}) : super(key: key);

  @override
  State<CommentInputWidget> createState() => _CommentInputWidgetState();
}

class _CommentInputWidgetState extends State<CommentInputWidget> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        onEditingComplete: () {
          BlocProvider.of<PostDetailsBloc>(context)
              .sendComment(controller.text);
          controller.clear();
          setState(() {});
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black.withOpacity(0.05),
            border: InputBorder.none,
            hintText: 'Write comment'),
      ),
    );
  }
}

class CommentsList extends StatelessWidget {
  const CommentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostDetailsBloc, PostDetailsState>(
      builder: (context, state) {
        if (state.status == PostDetailsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == PostDetailsStatus.error) {
          return const Center(child: Text('error'));
        } else {
          return Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state.status == PostDetailsStatus.sending)
                    const CircularProgressIndicator(),
                  ...state.comments.map((e) => CommentsWidget(model: e))
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class CommentsWidget extends StatelessWidget {
  const CommentsWidget({Key? key, required this.model}) : super(key: key);
  final CommentModel model;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(model.name),
      subtitle: Text(model.body),
    );
  }
}
