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

class WhenScreen extends ConsumerWidget {
  const WhenScreen({
    super.key,
  });

  static const path = '/when';
  static const name = 'WhenScreen';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(userListProvider.future),
        child: CustomScrollView(
          slivers: [
            const EditAsyncSettingSliverList(),
            userList.when(
              skipLoadingOnReload: asyncSetting.skipLoadingOnReload,
              skipLoadingOnRefresh: asyncSetting.skipLoadingOnRefresh,
              skipError: asyncSetting.skipError,
              data: (list) => UserSliverList(list: list),
              error: ErrorSliverWidget.new,
              loading: LoadingWidget.new,
            ),
          ],
        ),
      ),
      floatingActionButton: const EditUserFloatingActionButton(),
    );
  }
}
