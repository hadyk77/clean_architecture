import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String uid,
    required String email,
    required String name,
    String? imageUrl,
  }) : super(uid: uid, email: email, name: name);

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? "",
      name: user.displayName ?? "",
      imageUrl: user.photoURL ?? "",
    );
  }

  @override
  String toString() {
    return "name:$name,email:$email,uid:$uid,imageUrl:$imageUrl";
  }
}
