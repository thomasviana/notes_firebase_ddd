import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartz/dartz.dart';
import '../auth/value_objects.dart';
import 'failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  @override
  String toString() => 'EmailAddress(value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmailAddress && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
