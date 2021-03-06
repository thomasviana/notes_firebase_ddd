import 'package:dartz/dartz.dart';

import 'auth_failure.dart';
import 'user_entity.dart';
import 'value_objects.dart';

abstract class IAuthFacade {
  Future<Option<UserEntity>> getSignedUser();
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
  Future<void> signOut();
}
