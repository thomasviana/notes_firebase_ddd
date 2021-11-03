import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/auth/i_auth_facade.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _authFacade;

  AuthBloc(
    this._authFacade,
  ) : super(const Initial()) {
    on<AuthEvent>((event, emit) {
      event.map(
        authCheckRequested: (e) async {
          final userOption = await _authFacade.getSignedUser();
          emit(
            userOption.fold(
              () => const AuthState.unauthenticated(),
              (_) => const AuthState.authenticated(),
            ),
          );
        },
        signedOut: (e) async {
          await _authFacade.signOut();
          emit(
            const AuthState.unauthenticated(),
          );
        },
      );
    });
  }
}
