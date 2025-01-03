import 'package:async_value_with_switch_sample/presentations/shared/floating_action_button/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchScreen extends ConsumerWidget {
  const SwitchScreen({
    super.key,
  });

  static const path = '/switch';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userList = ref.watch(userListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SwitchScreen'),
      ),
      body: const Center(
        child: Text('データがありません'),
      ),
      floatingActionButton: const EditUserFloatingActionButton(),
    );
  }
}
