import 'package:flutter/material.dart';
import 'package:test_project/models/user_model.dart';
import 'package:test_project/ui/home_page/components/users_list_item.dart';

class UsersList extends StatelessWidget {
  const UsersList({Key? key, required this.users}) : super(key: key);
  final List<UserModel> users;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F1F1),
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UsersListItems(user: users[index]);
        },
      ),
    );
  }
}
