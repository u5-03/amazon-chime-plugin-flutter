import 'package:flutter/material.dart';

class FutureWidget<T> extends StatelessWidget {
  const FutureWidget({
    required this.future,
    required this.whenDone,
    super.key,
    this.initialData,
    this.whenWaiting,
    this.whenError,
  });
  final Future<T> future;
  final T? initialData;
  final Widget Function(T snapshotData) whenDone;
  final Widget? whenWaiting;
  final Widget? whenError;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasData) {
          return whenDone(snapshot.data as T);
        } else if (snapshot.hasError) {
          return whenError ?? Container();
        } else {
          return whenWaiting ?? Container();
        }
      },
    );
  }
}
