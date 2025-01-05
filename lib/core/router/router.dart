import 'package:async_value_with_switch_sample/presentations/screens/bad_when/screen.dart';
import 'package:async_value_with_switch_sample/presentations/screens/home/screen.dart';
import 'package:async_value_with_switch_sample/presentations/screens/switch_pattern_a/screen.dart';
import 'package:async_value_with_switch_sample/presentations/screens/when/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) => _goRouter;

final _goRouter = GoRouter(
  // アプリが起動した時
  initialLocation: '/',
  // パスと画面の組み合わせ
  routes: [
    GoRoute(
      path: HomeScreen.path,
      name: HomeScreen.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const HomeScreen(),
        );
      },
    ),
    GoRoute(
      path: WhenScreen.path,
      name: WhenScreen.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const WhenScreen(),
        );
      },
    ),
    GoRoute(
      path: BadWhenScreen.path,
      name: BadWhenScreen.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const BadWhenScreen(),
        );
      },
    ),
    GoRoute(
      path: SwitchPatternAScreen.path,
      name: SwitchPatternAScreen.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const SwitchPatternAScreen(),
        );
      },
    ),
  ],
  // 遷移ページがないなどのエラーが発生した時に、このページに行く
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  ),
);
