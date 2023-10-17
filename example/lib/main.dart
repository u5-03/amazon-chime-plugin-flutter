import 'package:amazon_chime_plugin/debug/get_version_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: GetVersionWidget(),
          ),
        ),
      ),
    ),
  );
}
