import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Center(
        child: Column(
          children: [
            Gap(100),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
