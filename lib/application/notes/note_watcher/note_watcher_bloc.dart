import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

import '../../../domain/notes/i_note_repository.dart';
import '../../../domain/notes/note.dart';
import '../../../domain/notes/note_failure.dart';

part 'note_watcher_bloc.freezed.dart';
part 'note_watcher_event.dart';
part 'note_watcher_state.dart';

@injectable
class NoteWatcherBloc extends Bloc<NoteWatcherEvent, NoteWatcherState> {
  final INoteRepository _iNoteRepository;

  StreamSubscription<Either<NoteFailure, KtList<Note>>> _noteStreamSubscription;

  NoteWatcherBloc(
    this._iNoteRepository,
    this._noteStreamSubscription,
  ) : super(const _Initial()) {
    on<NoteWatcherEvent>((event, emit) async {
      await event.map(
        watchAllStarted: (e) async {
          emit(const NoteWatcherState.loadInProgress());
          await _noteStreamSubscription.cancel();
          _noteStreamSubscription = _iNoteRepository.watchAll().listen(
                (failureOrNotes) =>
                    add(NoteWatcherEvent.notesReceived(failureOrNotes)),
              );
        },
        watchUncompleteStarted: (e) async {
          emit(const NoteWatcherState.loadInProgress());
          await _noteStreamSubscription.cancel();
          _noteStreamSubscription = _iNoteRepository.watchUncompleted().listen(
                (failureOrNotes) =>
                    add(NoteWatcherEvent.notesReceived(failureOrNotes)),
              );
        },
        notesReceived: (e) {
          e.failureOrNotes.fold(
            (f) => emit(NoteWatcherState.loadFailure(f)),
            (notes) => emit(NoteWatcherState.loadSucces(notes)),
          );
        },
      );
    });
  }

  @override
  Future<void> close() async {
    await _noteStreamSubscription.cancel();
    return super.close();
  }
}
