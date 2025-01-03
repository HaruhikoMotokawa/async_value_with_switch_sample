import 'package:async_value_with_switch_sample/domains/models/user.dart';
import 'package:async_value_with_switch_sample/presentations/shared/list_tile/user_list_tile.dart';
import 'package:flutter/material.dart';

class UserListView extends StatelessWidget {
  const UserListView({
    required this.list,
    super.key,
  });
  final List<User> list;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final user = list[index];
        return UserListTile(user: user);
      },
      separatorBuilder: (BuildContext context, int index) {
        if (index == list.length - 1) {
          return const SizedBox.shrink();
        } else {
          return const Divider();
        }
      },
    );
  }
}
