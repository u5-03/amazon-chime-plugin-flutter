import 'package:amazon_chime_plugin/debug/amazon_chime_plugin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: AmazonChimeSDKSampleScreen(),
        ),
      ),
    ),
  );
}
