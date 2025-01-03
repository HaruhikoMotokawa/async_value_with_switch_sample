import 'package:async_value_with_switch_sample/data/repositories/user/provider.dart';
import 'package:async_value_with_switch_sample/presentations/shared/floating_action_button/floating_action_button.dart';
import 'package:async_value_with_switch_sample/presentations/shared/list_tile/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WhenScreen extends ConsumerWidget {
  const WhenScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(userListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhenScreen'),
      ),
      body: userList.when(
        data: (list) {
          return Center(
            child: list.isEmpty
                ? const Text('データがありません')
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final user = list[index];
                      return UserListTile(
                        user: user,
                        onTap: () {},
                        onLongPress: () {},
                      );
                    },
                  ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const CircularProgressIndicator(),
      ),
      floatingActionButton: const EditUserFloatingActionButton(),
    );
  }
}
