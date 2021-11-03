import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/auth/user_entity.dart';
import '../../domain/core/value_objects.dart';

extension FirebaseUserDomainX on User {
  UserEntity toDomain() {
    return UserEntity(
      id: UniqueId.fromUniqueString(uid),
    );
  }
}
