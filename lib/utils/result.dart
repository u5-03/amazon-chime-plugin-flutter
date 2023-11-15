// Ref: https://codewithandrea.com/articles/flutter-exception-handling-try-catch-result-type/

import 'package:amazon_chime_plugin/errors/amazon_chime_error.dart';

/// Base Result class
/// [S] represents the type of the Success value
sealed class Result<S> {
  const Result();

  factory Result.success(S value) => Success(value);
  factory Result.failure(AmazonChimeError exception) => Failure(exception);
}

final class Success<S> extends Result<S> {
  const Success(this.value);
  final S value;
}

final class Failure<S> extends Result<S> {
  const Failure(this.exception);
  final AmazonChimeError exception;
}

extension ResultExtension<S, E extends Exception> on Result<S> {
  bool get isSuccess => this is Success<S>;
  bool get isFailure => this is Failure;

  S? get value {
    return switch (this) {
      Success(value: final value) => value,
      Failure(exception: final _) => null,
    };
  }

  AmazonChimeError? get error {
    return switch (this) {
      Success(value: final _) => null,
      Failure(exception: final exception) => exception,
    };
  }

  String get asContentString {
    return switch (this) {
      Success(value: final value) => value.toString(),
      Failure(exception: final exception) => exception.toString(),
    };
  }
}
