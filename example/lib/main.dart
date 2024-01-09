import 'package:amazon_chime_plugin_example/presentation/amazon_chime_plugin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(
    MaterialApp(
      home: Scaffold(body: AmazonChimeSDKSampleScreen()),
    ),
  );
}
