import 'package:clean_code/core/error/exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import 'user_data_source.dart';

class UserDataSourceImpl implements UserDataSource {
  final FirebaseAuth firebaseAuth;

  UserDataSourceImpl(this.firebaseAuth);

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      final _firebaseUser = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      final user = UserModel.fromFirebaseUser(_firebaseUser);

      return user;
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseException(
        message: e.message,
        code: e.code,
      );
    }
  }

  @override
  Future<UserModel> register(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final _firebaseUser = (await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;

      await _firebaseUser.updateDisplayName(name);
      await _firebaseUser.reload();
      final _updatedUser = firebaseAuth.currentUser!;
      final user = UserModel.fromFirebaseUser(_updatedUser);

      return user;
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseException(
        message: e.message,
        code: e.code,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseException(
        message: e.message,
        code: e.code,
      );
    }
  }
}
