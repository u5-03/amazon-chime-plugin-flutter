// ignore_for_file: prefer_constructors_over_static_methods

import 'package:amazon_chime_plugin/src/pigeon/generated/message_data.g.dart';

sealed class AmazonChimeError implements Exception {
  AmazonChimeError(this.message);
  factory AmazonChimeError.customError([String msg = '']) =>
      CustomError('Error: $msg');
  factory AmazonChimeError.responseMessage([String msg = '']) =>
      ResponseMessage(msg);
  factory AmazonChimeError.unknown() => UnknownError('不明なエラーが発生しました(ac)');

  factory AmazonChimeError.invalidResponse() =>
      InvalidResponse('Invalid Response');
  final String message;

  @override
  String toString() {
    return message;
  }

  // エラー同士を比較するための実装(主にUnitTestで使用)
  // SwiftでいうとこのEquatableのようなもの
  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  //   return other is AmazonChimeError && other.message == message;
  // }

  // @override
  // int get hashCode => message.hashCode;
}

final class InvalidResponse extends AmazonChimeError {
  InvalidResponse(super.message);
}

final class CustomError extends AmazonChimeError {
  CustomError(super.message);
}

final class ResponseMessage extends AmazonChimeError {
  ResponseMessage(super.message);
}

final class UnknownError extends AmazonChimeError {
  UnknownError(super.message);
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
