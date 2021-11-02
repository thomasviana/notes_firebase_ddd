import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:notes_firebase_ddd/domain/auth/auth_failure.dart';
import 'package:notes_firebase_ddd/domain/auth/i_auth_facade.dart';
import 'package:notes_firebase_ddd/domain/auth/value_objects.dart';

part 'sign_in_form_bloc.freezed.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(
    this._authFacade,
  ) : super(SignInFormState.initial()) {
    on<SignInFormEvent>((event, emit) async {
      event.map(
        emailChanged: (e) async* {
          emit(state.copyWith(
            emailAddress: EmailAddress(e.emailString),
            authFailureOrSuccessOption: none(),
          ));
        },
        passwordChanged: (e) async* {
          emit(state.copyWith(
            password: Password(e.passwordString),
            authFailureOrSuccessOption: none(),
          ));
        },
        registerWithEmailAndPasswordPressed: (e) async* {},
        signInWithEmailAndPasswordPressed: (e) async* {},
        signInWithGooglePressed: (e) async* {
          emit(state.copyWith(
            isSubmitting: true,
            authFailureOrSuccessOption: none(),
          ));
          final failureOrSuccess = await _authFacade.signInWithGoogle();
          emit(state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: some(failureOrSuccess),
          ));
        },
      );
    });
  }
}
