import 'package:async_value_with_switch_sample/presentations/screens/bad_when/screen.dart';
import 'package:async_value_with_switch_sample/presentations/screens/switch_pattern_a/screen.dart';
import 'package:async_value_with_switch_sample/presentations/screens/when/screen.dart';
import 'package:async_value_with_switch_sample/presentations/shared/sliver_list/edit_async_setting/sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
  });

  static const path = '/';
  static const name = 'HomeScreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
      ),
      body: CustomScrollView(
        slivers: [
          const EditAsyncSettingSliverList(),
          SliverList.separated(
            itemCount: listTiles(context).length,
            itemBuilder: (context, index) {
              return listTiles(context)[index];
            },
            separatorBuilder: (context, index) {
              if (index == listTiles(context).length - 1) {
                return const SizedBox.shrink();
              } else {
                return const Divider();
              }
            },
          ),
          const SliverToBoxAdapter(
            child: Divider(),
          ),
        ],
      ),
    );
  }
}

extension on HomeScreen {
  List<ListTile> listTiles(BuildContext context) => [
        ListTile(
          title: const Text(WhenScreen.name),
          onTap: () => context.push(WhenScreen.path),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
          title: const Text(BadWhenScreen.name),
          onTap: () => context.push(BadWhenScreen.path),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
          title: const Text(SwitchPatternAScreen.name),
          onTap: () => context.push(SwitchPatternAScreen.path),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ];
}
