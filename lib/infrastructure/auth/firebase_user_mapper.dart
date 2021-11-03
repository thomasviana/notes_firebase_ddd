import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_firebase_ddd/domain/auth/user_entity.dart';
import 'package:notes_firebase_ddd/domain/core/value_objects.dart';

extension FirebaseUserDomainX on User {
  UserEntity toDomain() {
    return UserEntity(
      id: UniqueId.fromUniqueString(uid),
    );
  }
}
