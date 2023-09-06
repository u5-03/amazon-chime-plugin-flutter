// ignore_for_file: prefer_constructors_over_static_methods

import 'package:amazon_chime_plugin/pigeon/generated/message_data.g.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AmazonChimeError implements Exception {
  const AmazonChimeError(this.message);
  final String message;

  @override
  String toString() {
    return message;
  }

  // エラー同士を比較するための実装(主にUnitTestで使用)
  // SwiftでいうとこのEquatableのようなもの
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AmazonChimeError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  static InvalidResponse invalidResponse() =>
      const InvalidResponse('Invalid Response');
  static CustomError customError([String msg = '']) =>
      CustomError('Error: $msg');
  static ResponseMessage responseMessage([String msg = '']) =>
      ResponseMessage(msg);
  static UnknownError unknown() => const UnknownError('Unknown Error');
}

class InvalidResponse extends AmazonChimeError implements Exception {
  const InvalidResponse(super.message);
}

class CustomError extends AmazonChimeError implements Exception {
  const CustomError(super.message);
}

class ResponseMessage extends AmazonChimeError implements Exception {
  const ResponseMessage(super.message);
}

class UnknownError extends AmazonChimeError implements Exception {
  const UnknownError(super.message);
}

extension AmazonChimeErrorTypeExt on AmazonChimeErrorType {
  String get code => index.toString();

  static AmazonChimeErrorType init(String code) {
    for (final type in AmazonChimeErrorType.values) {
      if (type.index.toString() == code) {
        return type;
      }
    }
    return AmazonChimeErrorType.unknown;
  }
}
