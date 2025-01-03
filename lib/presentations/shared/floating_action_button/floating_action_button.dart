import 'package:async_value_with_switch_sample/presentations/shared/floating_action_button/view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:utility_widgets/utility_widgets.dart';

class EditUserFloatingActionButton extends ConsumerWidget {
  const EditUserFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    return FloatingActionButton(
      onPressed: () => onPressed(context, ref),
      backgroundColor: colorScheme.primary,
      child: Icon(Icons.edit, color: colorScheme.onPrimary),
    );
  }
}

extension on EditUserFloatingActionButton {
  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final result = await ActionBottomSheet.show<EditUserType>(
      context,
      actions: [
        const ActionItem(
          icon: Icons.person,
          text: 'ユーザーデータを一つ作成',
          returnValue: EditUserType.create,
        ),
        const ActionItem(
          icon: Icons.person_add_alt,
          text: 'ユーザーデータを500個作成',
          returnValue: EditUserType.createBatch,
        ),
        const ActionItem(
          icon: Icons.delete,
          text: 'ユーザーデータを10個削除',
          returnValue: EditUserType.deleteBatch,
        ),
        const ActionItem(
          icon: Icons.delete_forever,
          text: '全てのユーザーデータを削除',
          returnValue: EditUserType.deleteAll,
        ),
      ],
    );

    if (result == null) return;
    final viewModel = ref.read(editUserActionViewModelProvider.notifier);

    switch (result) {
      case EditUserType.create:
        await viewModel.create();
      case EditUserType.createBatch:
        await viewModel.createBatch();
      case EditUserType.deleteBatch:
        await viewModel.deleteBatch();
      case EditUserType.deleteAll:
        await viewModel.initUser();
    }

    if (context.mounted == false) return;

    showCustomSnackbar(context, result.text);
  }
}

enum EditUserType {
  create('ユーザーデータを一つ作成'),
  createBatch('ユーザーデータを500個作成'),
  deleteBatch('ユーザーデータを10個削除'),
  deleteAll('全てのユーザーデータを削除');

  const EditUserType(this.text);

  final String text;
}
