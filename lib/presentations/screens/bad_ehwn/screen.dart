import 'package:async_value_with_switch_sample/data/repositories/user/provider.dart';
import 'package:async_value_with_switch_sample/presentations/shared/floating_action_button/floating_action_button.dart';
import 'package:async_value_with_switch_sample/presentations/shared/sliver_list/user/sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BadWhenScreen extends ConsumerWidget {
  const BadWhenScreen({
    super.key,
  });

  static const path = '/bad_when';
  static const name = 'BadWhenScreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ２回目以降はローディングにならない😢
    final userList = ref.watch(userListProvider).unwrapPrevious().valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
      ),
      body: CustomScrollView(
        slivers: [
          if (userList == null)
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  Gap(50),
                  Icon(Icons.insert_emoticon_sharp, size: 100),
                  Gap(8),
                  Center(child: Text('データがありません')),
                ],
              ),
            )
          else
            userList.isEmpty
                ? const SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Gap(50),
                        Icon(Icons.insert_emoticon_sharp, size: 100),
                        Gap(8),
                        Center(child: Text('データがありません')),
                      ],
                    ),
                  )
                : UserSliverList(list: userList),
        ],
      ),
      floatingActionButton: const EditUserFloatingActionButton(),
    );
  }
}
