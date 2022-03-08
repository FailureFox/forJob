import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/blocs/home_bloc/home_bloc.dart';
import 'package:test_project/domain/user_domain.dart';
import 'package:test_project/ui/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<HomeBloc>(
        create: (_) => HomeBloc(userDomain: UsersDomain()),
        child: const HomePage(),
      ),
    );
  }
}



  // return BlocBuilder<PostBloc, PostsState>(
  //       bloc: bloc,
  //       builder: (context, state) {
  //         return AnimatedContainer(
  //           height: getHeight(state),
  //           duration: const Duration(milliseconds: 300),
  //           clipBehavior: Clip.hardEdge,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(5),
  //           ),
  //           margin: const EdgeInsets.all(5),
  //           child: Container(
  //             decoration: const BoxDecoration(color: Colors.white),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 GestureDetector(
  //                   onTap: () {
  //                     expanded ? controller.forward() : controller.reverse();
  //                     expanded = !expanded;
  //                     bloc.state is PostsLoadedState
  //                         ? null
  //                         : bloc.loadPosts(widget.user.id);
  //                     setState(() {});
  //                   },
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(5.0),
  //                     child: Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         SizedBox(
  //                           height: 90,
  //                           child: Image.network(widget.user.avatars.first.url),
  //                         ),
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
  //                           ))
  //                       .toList(),
  //               ],
  //             ),
  //           ),
  //         );
  //       });