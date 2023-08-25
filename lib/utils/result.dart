// Ref: https://codewithandrea.com/articles/flutter-exception-handling-try-catch-result-type/

/// Base Result class
/// [S] represents the type of the success value
/// [E] should be [Exception] or a subclass of it
sealed class Result<S, E extends Exception> {
  const Result();
}

final class Success<S, E extends Exception> extends Result<S, E> {
  const Success(this.value);
  final S value;
}

final class Failure<S, E extends Exception> extends Result<S, E> {
  const Failure(this.exception);
  final E exception;
}

extension ResultExtension<S, E extends Exception> on Result<S, E> {
  bool get isSuccess => this is Success<S, E>;
  bool get isFailure => this is Failure<S, E>;

  S? get value {
    return switch (this) {
      Success(value: final value) => value,
      Failure(exception: final _) => null,
    };
  }

  E? get error {
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
