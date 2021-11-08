import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../domain/notes/note.dart';
import '../notes/note_form.dart/note_form_page.dart';

import '../notes/notes_overview/notes_overview_page.dart';
import '../sign_in/sign_in_page.dart';
import '../splash/splash_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignInPage),
    AutoRoute(page: NotesOverviewPage),
    AutoRoute(page: NoteFormPage, fullscreenDialog: true),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
