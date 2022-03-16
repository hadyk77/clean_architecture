import 'package:clean_code/core/error/exception.dart';
import 'package:clean_code/core/error/failure.dart';
import 'package:clean_code/modules/authentication/data/data_source/user_data_source.dart';
import 'package:clean_code/modules/authentication/data/models/user_model.dart';
import 'package:clean_code/modules/authentication/data/repository/user_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_impl_test.mocks.dart';

@GenerateMocks([UserDataSource])
void main() {
  late MockUserDataSource mockUserDataSource;
  late UserRepositoryImpl userRepositoryImpl;
  setUp(() {
    mockUserDataSource = MockUserDataSource();
    userRepositoryImpl = UserRepositoryImpl(mockUserDataSource);
  });

  const email = "hadykamel3@gmail.com";
  const name = "hady mohamed";
  const uid = "1";
  const user = UserModel(
    email: email,
    uid: uid,
    name: name,
  );
  test('should return user model when login', () async {
    when(mockUserDataSource.login(email: email, password: "123456"))
        .thenAnswer((realInvocation) async => user);

    final result =
        await userRepositoryImpl.login(email: email, password: "123456");

    verify(mockUserDataSource.login(email: email, password: "123456"));

    expect(result, const Right(user));
  });

  test('should throw exception when login failed', () async {
    when(mockUserDataSource.login(email: email, password: "123456"))
        .thenThrow(ServerException());

    final result =
        await userRepositoryImpl.login(email: email, password: "123456");

    verify(mockUserDataSource.login(email: email, password: "123456"));

    expect(result, const Left(FirebaseFailure()));
  });

  test('should return user model when register sucess', () async {
    when(mockUserDataSource.register(
      email: email,
      password: "123456",
      name: name,
    )).thenAnswer((realInvocation) async => user);

    final result = await userRepositoryImpl.register(
      email: email,
      password: "123456",
      name: name,
    );

    verify(mockUserDataSource.register(
      email: email,
      password: "123456",
      name: name,
    ));

    expect(result, const Right(user));
  });

  test('should throw exception when register failed', () async {
    when(mockUserDataSource.register(
            email: email, password: "123456", name: name))
        .thenThrow(CustomFirebaseException());

    final result = await userRepositoryImpl.register(
      email: email,
      password: "123456",
      name: name,
    );

    verify(mockUserDataSource.register(
      email: email,
      password: "123456",
      name: name,
    ));

    expect(result, const Left(FirebaseFailure()));
  });
}
