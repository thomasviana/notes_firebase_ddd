import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

import 'note.dart';
import 'note_failure.dart';

abstract class INoteRepository {
  // READ watch notes
  // READ watch uncompleted notes
  // CREATE
  // UPDATE
  // DELETE

  Stream<Either<NoteFailure, KtList<Note>>> watchAll();
  Stream<Either<NoteFailure, KtList<Note>>> watchUncompleted();
  Stream<Either<NoteFailure, Unit>> create(Note note);
  Stream<Either<NoteFailure, Unit>> update(Note note);
  Stream<Either<NoteFailure, Unit>> delete(Note note);
}
