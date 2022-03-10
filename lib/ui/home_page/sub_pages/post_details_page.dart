import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/blocs/post_add_bloc/post_add_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => addCommentDialog(context),
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.05),
                    border: InputBorder.none,
                    hintText: 'Write comment'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addCommentDialog(context) {
    final TextEditingController commentController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (secondContext) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 0),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(secondContext).viewInsets.bottom),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Comments add',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (text) {
                        return text == null ? 'Form is Empty' : null;
                      },
                      controller: commentController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.05),
                          border: InputBorder.none,
                          hintText: 'Write comment'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (text) {
                        if (text == null) {
                          return 'Form is empty';
                        } else if (text.length < 2) {
                          return 'Min lenght is 2';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.05),
                          border: InputBorder.none,
                          hintText: 'Write name'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      validator: (text) {
                        if (text == null) {
                          return 'Form is empty';
                        } else if (RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text)) {
                          return null;
                        } else {
                          return 'Incorrect email';
                        }
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.05),
                          border: InputBorder.none,
                          hintText: 'Write email'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width / 8,
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<PostDetailsBloc>(context)
                                  .sendComment(
                                text: commentController.text,
                                email: emailController.text,
                                name: nameController.text,
                              );
                              FocusScope.of(secondContext).unfocus();
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Добавить')),
                    ),
                  )
                ],
              ),
            ),
          );
        });
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
