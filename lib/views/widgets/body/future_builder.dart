import 'package:flutter/material.dart';

class FutureWrapper<T> extends StatelessWidget {
  const FutureWrapper({
    required this.future,
    required this.child,
    super.key,
  });

  final Future<T>? future;
  final Widget Function(T?) child;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          final T? data = snapshot.data;
          return child(data);
        } else if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return Center(
            child: Text("Error: $snapshot.error"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
