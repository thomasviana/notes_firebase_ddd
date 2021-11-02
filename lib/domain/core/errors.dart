import 'package:notes_firebase_ddd/domain/core/failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() =>
      Error.safeToString('UnexpectedValueError(valueFailure: $valueFailure)');
}
