import 'package:flutter/material.dart';
import 'package:test_project/models/user_model.dart';
import 'package:test_project/ui/home_page/components/users_list_item.dart';

class UsersList extends StatelessWidget {
  const UsersList({Key? key, required this.users, required this.selectedIndex})
      : super(key: key);
  final List<UserModel> users;
  final int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F1F1),
      child: SizedBox(
        height: MediaQuery.of(context).size.width / 3.5,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: users.length,
          itemBuilder: (context, index) {
            return UsersListItems(
              user: users[index],
              index: index,
              isSelected: index == selectedIndex,
            );
          },
        ),
      ),
    );
  }
}
