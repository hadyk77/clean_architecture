import '../models/user_model.dart';

abstract class UserDataSource {
  /// this should return UserModel object of logged in user
  ///
  /// Throws [CustomFirebaseException] when something went wrong during authentication
  Future<UserModel> login({
    required String email,
    required String password,
  });

  /// this should return UserModel object of logged in user
  ///
  /// Throws [CustomFirebaseException] when something went wrong during authentication
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  });

  /// this should logged current user out
  ///
  /// Throws [CustomFirebaseException] when something went wrong during authentication
  Future<void> logout();
}
