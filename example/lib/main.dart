import 'dart:async';

import 'package:amazon_chime_plugin/debug/amazon_chime_plugin_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AmazonChimeSDKExample());
}

class AmazonChimeSDKExample extends StatefulWidget {
  const AmazonChimeSDKExample({super.key});

  @override
  State<AmazonChimeSDKExample> createState() => _AmazonChimeSDKExampleState();
}

class _AmazonChimeSDKExampleState extends State<AmazonChimeSDKExample> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {}

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: ChimeSDKSampleScreen(),
      ),
    );
  }
}
