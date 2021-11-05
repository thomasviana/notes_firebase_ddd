import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

import '../../../domain/notes/i_note_repository.dart';
import '../../../domain/notes/note.dart';
import '../../../domain/notes/note_failure.dart';
import '../../../domain/notes/value_objects.dart';
import '../../../infrastructure/notes/note_dtos.dart';
import '../../../presentation/notes/note_form.dart/misc/todo_item_presentation_classes.dart';

part 'note_form_bloc.freezed.dart';
part 'note_form_event.dart';
part 'note_form_state.dart';

@injectable
class NoteFormBloc extends Bloc<NoteFormEvent, NoteFormState> {
  final INoteRepository _iNoteRepository;
  NoteFormBloc(
    this._iNoteRepository,
  ) : super(NoteFormState.initial()) {
    on<NoteFormEvent>((event, emit) {
      event.map(
        initialize: (e) async* {
          e.initialNoteOption.fold(
              () => emit(state),
              (initialNote) => emit(state.copyWith(
                    note: initialNote,
                    isEditing: true,
                  )));
        },
        bodyChanged: (e) async* {
          emit(
            state.copyWith(
              note: state.note.copyWith(body: NoteBody(e.bodyStr)),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        colorChanged: (e) async* {
          emit(
            state.copyWith(
              note: state.note.copyWith(color: NoteColor(e.color)),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        todosChanged: (e) async* {
          emit(
            state.copyWith(
              note: state.note.copyWith(
                todos: List3(e.todos.map((primitive) => primitive.toDomain())),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        saved: (e) async* {
          Either<NoteFailure, Unit> failureOrSucces;
          emit(
            state.copyWith(
              isSaving: true,
              saveFailureOrSuccessOption: none(),
            ),
          );
          if (state.note.failureOption.isNone()) {
            failureOrSucces = state.isEditing
                ? await _iNoteRepository.update(state.note)
                : await _iNoteRepository.create(state.note);
            emit(state.copyWith(
              isSaving: false,
              saveFailureOrSuccessOption: some(failureOrSucces),
            ));
          }
          emit(state.copyWith(
            isSaving: false,
            showErrorMessages: true,
            saveFailureOrSuccessOption: none(),
          ));
        },
      );
    });
  }
}
