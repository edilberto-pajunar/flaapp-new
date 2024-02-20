import 'package:flutter/material.dart';

class StreamWrapper<T> extends StatelessWidget {
  const StreamWrapper({
    required this.stream,
    required this.child,
    super.key,
  });

  final Stream<T>? stream;
  final Widget Function(T) child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final T data = snapshot.data as T;
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
