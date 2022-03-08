import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/blocs/post_add_bloc/post_add_bloc.dart';
import 'package:test_project/blocs/post_add_bloc/post_add_state.dart';
import 'package:test_project/ui/home_page/components/posts_widget.dart';

class AddPage extends StatelessWidget {
  AddPage({Key? key}) : super(key: key);

  final PostAddBloc bloc = PostAddBloc(id: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Добавленные'),
        ),
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: BlocBuilder<PostAddBloc, PostAddState>(
                      bloc: bloc,
                      builder: (context, state) {
                        if (state.status == UniversalStatus.loading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state.status == UniversalStatus.added) {
                          return ListView.builder(
                              itemCount: state.posts.length,
                              itemBuilder: (context, index) {
                                return PostsWidget(
                                  post: state.posts[index],
                                  userModel: null,
                                );
                              });
                        } else if (state.status == UniversalStatus.error) {
                          return const Center(child: Text('Ошибка'));
                        } else {
                          return const Center(
                            child: Text('Добавьте данные'),
                          );
                        }
                      })),
              ElevatedButton(
                  onPressed: () => showPostAddBottomSheet(context),
                  child: const Text('Добавить'))
            ],
          ),
        ));
  }

  String? validate(text) {
    if (text != '') {
      return null;
    }
    return 'Заполните поле';
  }

  showPostAddBottomSheet(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (secondContext) => Form(
        key: formKey,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: validate,
                onSaved: (value) => bloc.onTitleChange(value!),
              ),
              const SizedBox(height: 10),
              TextFormField(
                  onSaved: (value) => bloc.onBodyChange(value!),
                  validator: validate),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    bloc.onSave();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
