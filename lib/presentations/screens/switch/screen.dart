import 'package:async_value_with_switch_sample/core/log/logger.dart';
import 'package:async_value_with_switch_sample/data/repositories/user/provider.dart';
import 'package:async_value_with_switch_sample/presentations/shared/error/widget.dart';
import 'package:async_value_with_switch_sample/presentations/shared/floating_action_button/floating_action_button.dart';
import 'package:async_value_with_switch_sample/presentations/shared/loading/widget.dart';
import 'package:async_value_with_switch_sample/presentations/shared/sliver_list/edit_async_setting/sliver_list.dart';
import 'package:async_value_with_switch_sample/presentations/shared/sliver_list/edit_async_setting/view_model.dart';
import 'package:async_value_with_switch_sample/presentations/shared/sliver_list/user/sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class SwitchScreen extends ConsumerWidget {
  const SwitchScreen({
    super.key,
  });

  static const path = '/switch_screen';
  static const name = 'SwitchScreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(userListProvider.future),
        child: const CustomScrollView(
          slivers: [
            EditAsyncSettingSliverList(),
            _SwitchView(),
          ],
        ),
      ),
      floatingActionButton: const EditUserFloatingActionButton(),
    );
  }
}

class _SwitchView extends ConsumerWidget {
  const _SwitchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(userListProvider);

    final asyncSetting = ref.watch(asyncSettingViewModelProvider);

    if (asyncSetting.alwaysLoading) {
      // ２回目以降の変更を監視してinvalidateするとうまくいく
      ref.listen(userListProvider, (previous, _) {
        if (previous != null &&
            (previous.hasValue || previous.hasError) &&
            !previous.isLoading) {
          logger.d('invalidate');
          ref.invalidate(userListProvider);
        }
      });
    }
    logger
      ..d('isLoading: ${userList.isLoading}')
      ..d('hasError: ${userList.hasError}')
      ..d('hasValue: ${userList.hasValue}');
    return switch ((
      asyncSetting.skipLoadingOnReload,
      asyncSetting.skipLoadingOnRefresh,
      asyncSetting.skipError
    )) {
      (false, true, false) => switch (userList) {
          AsyncError(:final error, :final stackTrace) =>
            ErrorSliverWidget(error, stackTrace),
          AsyncData(:final value) => UserSliverList(list: value),
          _ => const LoadingWidget()
        },
      _ => const SliverToBoxAdapter(
          child: Column(
            children: [
              Gap(50),
              Icon(Icons.insert_emoticon_sharp, size: 100),
              Gap(8),
              Center(child: Text('データがありません')),
            ],
          ),
        ),
    };
  }
}
