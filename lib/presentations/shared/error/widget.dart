import 'package:flutter/material.dart';

class ErrorSliverWidget extends StatelessWidget {
  const ErrorSliverWidget(
    this.error,
    this.stackTrace, {
    super.key,
  });

  final Object error;
  final StackTrace stackTrace;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text('error: $error, stackTrace: $stackTrace'),
    );
  }
}
