import 'package:async_value_with_switch_sample/data/repositories/user/provider.dart';
import 'package:async_value_with_switch_sample/presentations/shared/floating_action_button/floating_action_button.dart';
import 'package:async_value_with_switch_sample/presentations/shared/list_view/user_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchPatternBScreen extends ConsumerWidget {
  const SwitchPatternBScreen({
    super.key,
  });

  static const path = '/switch_pattern_b';
  static const name = 'SwitchPatternBScreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(userListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
      ),
      body: Center(
        child: switch (userList) {
          AsyncData(:final value, isLoading: false) =>
            value.isEmpty ? const Text('データがありません') : UserListView(list: value),
          AsyncData(isLoading: true) => const CircularProgressIndicator(),
          AsyncError(:final error, :final stackTrace) =>
            Text('エラーが発生しました  $error, $stackTrace'),
          _ => const CircularProgressIndicator(),
        },
      ),
      floatingActionButton: const EditUserFloatingActionButton(),
    );
  }
}
