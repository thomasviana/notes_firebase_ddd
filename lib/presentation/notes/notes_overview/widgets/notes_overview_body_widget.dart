import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/notes/note_watcher/note_watcher_bloc.dart';
import 'critical_failure_display_widget.dart';
import 'error_note_card_widget.dart';
import 'note_card_widget.dart';

class NotesOverviewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteWatcherBloc, NoteWatcherState>(
      builder: (context, state) {
        return state.map(
          initial: (_) {
            return Container();
          },
          loadInProgress: (_) =>
              const Center(child: CircularProgressIndicator()),
          loadSucces: (state) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final note = state.notes[index];
                if (note.failureOption.isSome()) {
                  return ErrorNoteCard(note: note);
                } else {
                  return NoteCard(note: note);
                }
              },
              itemCount: state.notes.size,
            );
          },
          loadFailure: (state) {
            return CriticalFailureDisplay(failure: state.noteFailure);
          },
        );
      },
    );
  }
}
