// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: SplashPage());
    },
    SignInRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const SignInPage());
    },
    NotesOverviewRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: NotesOverviewPage());
    },
    NoteFormRoute.name: (routeData) {
      final args = routeData.argsAs<NoteFormRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: NoteFormPage(key: args.key, editedNote: args.editedNote));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(SplashRoute.name, path: '/'),
        RouteConfig(SignInRoute.name, path: '/sign-in-page'),
        RouteConfig(NotesOverviewRoute.name, path: '/notes-overview-page'),
        RouteConfig(NoteFormRoute.name, path: '/note-form-page')
      ];
}

/// generated route for [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute() : super(name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute() : super(name, path: '/sign-in-page');

  static const String name = 'SignInRoute';
}

/// generated route for [NotesOverviewPage]
class NotesOverviewRoute extends PageRouteInfo<void> {
  const NotesOverviewRoute() : super(name, path: '/notes-overview-page');

  static const String name = 'NotesOverviewRoute';
}

/// generated route for [NoteFormPage]
class NoteFormRoute extends PageRouteInfo<NoteFormRouteArgs> {
  NoteFormRoute({Key? key, required Note? editedNote})
      : super(name,
            path: '/note-form-page',
            args: NoteFormRouteArgs(key: key, editedNote: editedNote));

  static const String name = 'NoteFormRoute';
}

class NoteFormRouteArgs {
  const NoteFormRouteArgs({this.key, required this.editedNote});

  final Key? key;

  final Note? editedNote;
}
