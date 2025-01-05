import 'package:async_value_with_switch_sample/core/log/logger.dart';
import 'package:async_value_with_switch_sample/data/repositories/user/provider.dart';
import 'package:async_value_with_switch_sample/presentations/shared/floating_action_button/floating_action_button.dart';
import 'package:async_value_with_switch_sample/presentations/shared/sliver_list/edit_async_setting/sliver_list.dart';
import 'package:async_value_with_switch_sample/presentations/shared/sliver_list/edit_async_setting/view_model.dart';
import 'package:async_value_with_switch_sample/presentations/shared/sliver_list/user/sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class WhenScreen extends ConsumerWidget {
  const WhenScreen({
    super.key,
  });

  static const path = '/when';
  static const name = 'WhenScreen';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(userListProvider);
    final (skipLoadingOnReload, skipLoadingOnRefresh, skipError) = ref.watch(
      asyncSettingViewModelProvider.select(
        (state) => (
          state.skipLoadingOnReload,
          state.skipLoadingOnRefresh,
          state.skipError
        ),
      ),
    );

    logger
      ..d('isLoading: ${userList.isLoading}')
      ..d('hasError: ${userList.hasError}')
      ..d('hasValue: ${userList.hasValue}');

    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
      ),
      body: CustomScrollView(
        slivers: [
          const EditAsyncSettingSliverList(),
          userList.when(
            skipLoadingOnReload: skipLoadingOnReload,
            skipLoadingOnRefresh: skipLoadingOnRefresh,
            skipError: skipError,
            data: (list) {
              return list.isEmpty
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
                  : UserSliverList(list: list);
            },
            error: (error, stackTrace) =>
                SliverToBoxAdapter(child: Text(error.toString())),
            loading: () => const SliverToBoxAdapter(
              child: Center(
                child: Column(
                  children: [
                    Gap(100),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const EditUserFloatingActionButton(),
    );
  }
}
