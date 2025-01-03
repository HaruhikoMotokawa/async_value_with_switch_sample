import 'package:async_value_with_switch_sample/data/repositories/user/provider.dart';
import 'package:async_value_with_switch_sample/presentations/shared/floating_action_button/floating_action_button.dart';
import 'package:async_value_with_switch_sample/presentations/shared/list_view/user_list_view.dart';
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
      body: Center(
        child: userList.when(
          // ここからデフォルトの設定で入っている
          skipLoadingOnReload: false,
          skipLoadingOnRefresh: true,
          skipError: false,
          // ここまで
          data: (list) {
            return list.isEmpty
                ? const Text('データがありません')
                : Expanded(
                    child: UserListView(list: list),
                  );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: const EditUserFloatingActionButton(),
    );
  }
}
