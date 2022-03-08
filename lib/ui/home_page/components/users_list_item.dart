import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/blocs/home_bloc/home_bloc.dart';
import 'package:test_project/models/user_model.dart';

class UsersListItems extends StatelessWidget {
  const UsersListItems(
      {Key? key,
      required this.user,
      required this.index,
      required this.isSelected})
      : super(key: key);
  final UserModel user;
  final int index;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<HomeBloc>(context).getPosts(user.id, index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    blurRadius: 1,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ]
              : null,
          border: Border.all(color: isSelected ? Colors.blue : Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: SizedBox.square(
          dimension: MediaQuery.of(context).size.width / 3.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(user.avatarPath),
                              fit: BoxFit.fitHeight)),
                    )),
              ),
              const SizedBox(height: 5),
              Text(
                user.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
