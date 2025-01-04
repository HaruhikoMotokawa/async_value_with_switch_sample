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
        ActionItem(
          icon: Icons.person,
          text: EditUserType.create.text,
          returnValue: EditUserType.create,
        ),
        ActionItem(
          icon: Icons.person_add_alt,
          text: EditUserType.createBatch.text,
          returnValue: EditUserType.createBatch,
        ),
        ActionItem(
          icon: Icons.delete,
          text: EditUserType.delete.text,
          returnValue: EditUserType.delete,
        ),
        ActionItem(
          icon: Icons.delete_forever,
          text: EditUserType.deleteAll.text,
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
      case EditUserType.delete:
        await viewModel.delete();
      case EditUserType.deleteAll:
        await viewModel.initUser();
    }

    if (context.mounted == false) return;

    showCustomSnackbar(context, result.text);
  }
}

enum EditUserType {
  create('ユーザーデータを一つ作成'),
  createBatch('ユーザーデータを30個作成'),
  delete('ユーザーデータを一つ削除'),
  deleteAll('全てのユーザーデータを削除');

  const EditUserType(this.text);

  final String text;
}
