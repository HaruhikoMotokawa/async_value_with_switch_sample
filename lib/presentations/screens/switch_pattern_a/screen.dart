import 'package:async_value_with_switch_sample/data/repositories/user/provider.dart';
import 'package:async_value_with_switch_sample/presentations/shared/floating_action_button/floating_action_button.dart';
import 'package:async_value_with_switch_sample/presentations/shared/list_view/user_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchPatternAScreen extends ConsumerWidget {
  const SwitchPatternAScreen({
    super.key,
  });

  static const path = '/switch_pattern_a';
  static const name = 'SwitchPatternAScreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(userListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
      ),
      body: Center(
        child: switch (userList) {
          AsyncData(:final value) =>
            value.isEmpty ? const Text('データがありません') : UserListView(list: value),
          AsyncError(:final error, :final stackTrace) =>
            Text('エラーが発生しました  $error, $stackTrace'),
          // AsyncLoadingを入れるだけだと、網羅されていないのでエラーになる
          // AsyncLoading() => const CircularProgressIndicator(),
          _ => const CircularProgressIndicator(),
        },
      ),
      floatingActionButton: const EditUserFloatingActionButton(),
    );
  }
}
