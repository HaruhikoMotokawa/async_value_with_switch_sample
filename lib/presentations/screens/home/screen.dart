import 'package:async_value_with_switch_sample/presentations/screens/switch_pattern_a/screen.dart';
import 'package:async_value_with_switch_sample/presentations/screens/switch_pattern_b/screen.dart';
import 'package:async_value_with_switch_sample/presentations/screens/when/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            ElevatedButton(
              child: const Text(WhenScreen.name),
              onPressed: () => context.push(WhenScreen.path),
            ),
            ElevatedButton(
              child: const Text(SwitchPatternAScreen.name),
              onPressed: () => context.push(SwitchPatternAScreen.path),
            ),
            ElevatedButton(
              child: const Text(SwitchPatternBScreen.name),
              onPressed: () => context.push(SwitchPatternBScreen.path),
            ),
          ],
        ),
      ),
    );
  }
}
