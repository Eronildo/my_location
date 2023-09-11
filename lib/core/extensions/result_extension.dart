import '../utils/result.dart';

/// [Result] Extension.
extension ResultExtension<F, S> on Result<F, S> {
  /// Returns true if the current result is an [Failure].
  bool isFailure() => this.failure != null;

  /// Returns true if the current result is a [Success].
  bool isSuccess() => this.success != null;

  /// Returns the value of [F] if any.
  F? tryGetFailure() => this.failure;

  /// Returns the value of [S] if any.
  S? tryGetSuccess() => this.success;

  /// Handle the [Result] when [Success] or [Failure]
  ///
  /// if the result is a failure, it will be returned in [whenFailure]
  /// if it is a success it will be returned in [whenSuccess].
  W fold<W>(
    W Function(F failure) whenFailure,
    W Function(S success) whenSuccess,
  ) {
    final failure = this.failure;
    if (failure != null) return whenFailure(failure);
    final success = this.success;
    if (success != null) return whenSuccess(success);

    throw StateError('Has no result: $this');
  }

  /// Execute [whenFailure] if the [Result] is a failure.
  L? foldFailure<L>(
    L Function(F failure) whenFailure,
  ) {
    final failure = this.failure;
    if (failure == null) return null;

    return whenFailure(failure);
  }

  /// Execute [whenSuccess] if the [Result] is a success.
  R? foldSuccess<R>(
    R Function(S success) whenSuccess,
  ) {
    final success = this.success;
    if (success == null) return null;

    return whenSuccess(success);
  }
}
