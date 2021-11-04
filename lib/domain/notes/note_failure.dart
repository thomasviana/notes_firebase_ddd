import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_failure.freezed.dart';

@freezed
class NoteFailure<T> with _$NoteFailure {
  const factory NoteFailure.unexpected() = _Unexpected;
}
