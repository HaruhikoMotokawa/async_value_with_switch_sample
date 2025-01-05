import 'package:async_value_with_switch_sample/presentations/shared/sliver_list/edit_async_setting/view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditAsyncSettingSliverList extends ConsumerWidget {
  const EditAsyncSettingSliverList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = asyncSettingViewModelProvider;
    final state = ref.watch(provider);
    final viewModel = ref.watch(provider.notifier);

    return SliverList(
      delegate: SliverChildListDelegate([
        Column(
          spacing: 4,
          children: [
            SwitchListTile(
              title: const Text('skipLoadingOnReload'),
              value: state.skipLoadingOnReload,
              onChanged: (value) => viewModel.changeAsyncSetting(
                skipLoadingOnReload: value,
              ),
            ),
            SwitchListTile(
              title: const Text('skipLoadingOnRefresh'),
              value: state.skipLoadingOnRefresh,
              onChanged: (value) => viewModel.changeAsyncSetting(
                skipLoadingOnRefresh: value,
              ),
            ),
            SwitchListTile(
              title: const Text('skipError'),
              value: state.skipError,
              onChanged: (value) => viewModel.changeAsyncSetting(
                skipError: value,
              ),
            ),
            SwitchListTile(
              title: const Text('alwaysLoading'),
              value: state.alwaysLoading,
              onChanged: (value) => viewModel.changeAsyncSetting(
                alwaysLoading: value,
              ),
            ),
            ElevatedButton(
              onPressed: viewModel.invalidate,
              child: const Text('invalidate'),
            ),
            const Divider(),
          ],
        ),
      ]),
    );
  }
}
