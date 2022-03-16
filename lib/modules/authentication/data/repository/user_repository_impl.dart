import 'package:clean_code/core/error/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../data_source/user_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, UserEntity>> login(
      {required String email, required String password}) async {
    try {
      final user = await dataSource.login(email: email, password: password);
      return Right(user);
    } on CustomFirebaseException catch (e) {
      return Left(FirebaseFailure(
        message: e.message,
        code: e.code,
      ));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final result = await dataSource.register(
          email: email, password: password, name: name);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(
        message: e.message,
        code: e.code,
      ));
    }
  }

  @override
  Future<Option<FirebaseFailure>> logout() async {
    try {
      await dataSource.logout();
      return none();
    } on CustomFirebaseException catch (e) {
      return some(FirebaseFailure(message: e.message, code: e.code));
    }
  }
}
