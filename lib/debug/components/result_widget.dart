import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';
import 'package:amazon_chime_plugin/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class ResultWidget extends ConsumerWidget {
  const ResultWidget({required this.result, super.key});
  final Result<String, AmazonChimeError> result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (result) {
      case Success(value: final value):
        return Text(
          'Device OS is $value',
          // ignore: avoid_redundant_argument_values
          maxLines: null,
        );
      case Failure(exception: final exception):
        return Text(
          exception.toString(),
          // ignore: avoid_redundant_argument_values
          maxLines: null,
        );
    }
  }
}
