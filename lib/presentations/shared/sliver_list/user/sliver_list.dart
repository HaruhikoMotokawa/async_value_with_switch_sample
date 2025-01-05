import 'package:async_value_with_switch_sample/domains/models/user.dart';
import 'package:async_value_with_switch_sample/presentations/shared/list_tile/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UserSliverList extends StatelessWidget {
  const UserSliverList({
    required this.list,
    super.key,
  });
  final List<User> list;

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? const _EmptyWidget()
        : SliverList.separated(
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

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Column(
        children: [
          Gap(50),
          Icon(Icons.insert_emoticon_sharp, size: 100),
          Gap(8),
          Center(child: Text('データがありません')),
        ],
      ),
    );
  }
}
