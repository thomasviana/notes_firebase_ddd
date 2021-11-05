import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import '../../../application/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/notes/note_actor/note_actor_bloc.dart';
import '../../../application/notes/note_watcher/note_watcher_bloc.dart';
import '../../../injection.dart';
import '../../routes/app_router.dart';

class NotesOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatcherBloc>(
          create: (context) => getIt<NoteWatcherBloc>()
            ..add(const NoteWatcherEvent.watchAllStarted()),
        ),
        BlocProvider<NoteActorBloc>(
          create: (context) => getIt<NoteActorBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeMap(
                  unauthenticated: (_) =>
                      context.router.replace(const SignInRoute()),
                  orElse: () {});
            },
          ),
          // BlocListener<NoteActorBloc, NoteActorState>(
          //   listener: (context, state) {
          //     state.maybeMap(
          //       deleteFailure: (state) {
          //         FlushbarHelper.createError(
          //           duration: const Duration(seconds: 5),
          //           message: state.noteFailure.map(
          //             unexpected: (_) =>
          //                 'Unexpected error occured while deleting, please contact support.',
          //             insufficientPermission: (_) =>
          //                 'Insufficient permissions ❌',
          //             unableToUpdate: (_) => 'Impossible error',
          //           ),
          //         ).show(context);
          //       },
          //       orElse: () {},
          //     );
          //   },
          // ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            leading: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.signedOut());
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.indeterminate_check_box),
                onPressed: () {},
              )
            ],
          ),
          body: Container(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // TODO: Navigate to NoteFormPage
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
