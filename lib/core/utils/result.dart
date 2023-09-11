// ignore_for_file: non_constant_identifier_names

/// Result [Record] Type
///
/// Receives two values [F] and [S]
/// as [F] is a failure and [S] is a success.
typedef Result<F, S> = ({F? failure, S? success});

/// Build a [Result] that returns a [success].
Result<F, S> Success<F, S>(S success) => (failure: null, success: success);

/// Build a [Result] that returns a [failure].
Result<F, S> Failure<F, S>(F failure) => (failure: failure, success: null);
