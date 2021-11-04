// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'dart:async' as _i10;

import 'package:dartz/dartz.dart' as _i11;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kt_dart/kt.dart' as _i13;

import 'application/auth/auth_bloc.dart' as _i16;
import 'application/auth/sign_in_form/bloc/sign_in_form_bloc.dart' as _i15;
import 'application/notes/note_actor/note_actor_bloc.dart' as _i7;
import 'application/notes/note_watcher/note_watcher_bloc.dart' as _i9;
import 'domain/auth/i_auth_facade.dart' as _i5;
import 'domain/notes/i_note_repository.dart' as _i8;
import 'domain/notes/note.dart' as _i14;
import 'domain/notes/note_failure.dart' as _i12;
import 'infrastructure/auth/firebase_auth_facade.dart' as _i6;
import 'infrastructure/core/firebase_injectable_module.dart'
    as _i17; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<_i3.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i4.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.lazySingleton<_i5.IAuthFacade>(() =>
      _i6.FirebaseAuthFacade(get<_i3.FirebaseAuth>(), get<_i4.GoogleSignIn>()));
  gh.factory<_i7.NoteActorBloc>(
      () => _i7.NoteActorBloc(get<_i8.INoteRepository>()));
  gh.factory<_i9.NoteWatcherBloc>(() => _i9.NoteWatcherBloc(
      get<_i8.INoteRepository>(),
      get<
          _i10.StreamSubscription<
              _i11.Either<_i12.NoteFailure<dynamic>,
                  _i13.KtList<_i14.Note>>>>()));
  gh.factory<_i15.SignInFormBloc>(
      () => _i15.SignInFormBloc(get<_i5.IAuthFacade>()));
  gh.factory<_i16.AuthBloc>(() => _i16.AuthBloc(get<_i5.IAuthFacade>()));
  return get;
}

class _$FirebaseInjectableModule extends _i17.FirebaseInjectableModule {}
