import 'package:clean_code/core/error/exception.dart';
import 'package:clean_code/modules/authentication/data/data_source/user_data_source_impl.dart';
import 'package:clean_code/modules/authentication/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_data_source_impl_test.mocks.dart';

@GenerateMocks([FirebaseAuth, UserCredential, User])
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late UserDataSourceImpl userDataSource;
  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    userDataSource = UserDataSourceImpl(mockFirebaseAuth);
  });
  const email = "hadykamel3@gmail.com";
  const password = "123456";
  const name = "hady mohamed";
  const UserModel user = UserModel(
    uid: "1",
    email: email,
    name: "hady mohamed",
    imageUrl: "test.com",
  );

  final MockUserCredential mockUserCredential = MockUserCredential();
  test('should return userModel when logged in sucess', () async {
    when(mockFirebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .thenAnswer(
      (_) async => mockUserCredential,
    );

    final result = await userDataSource.login(email: email, password: password);
    verify(mockFirebaseAuth.signInWithEmailAndPassword(
        email: email, password: password));

    expect(result, user);
  });

  test('should return userModel when registered sucess', () async {
    when(mockFirebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password))
        .thenAnswer(
      (_) async => mockUserCredential,
    );

    final result = await userDataSource.register(
        email: email, password: password, name: name);
    verify(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password));

    verify(mockUserCredential.user?.updateDisplayName(name));

    expect(result, user);
  });

  test('should throw firebase failure when login failed', () async {
    when(mockFirebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .thenThrow(FirebaseAuthException(code: "100"));

    final call = userDataSource.login;

    expect(() => call(email: email, password: password),
        throwsA(const TypeMatcher<CustomFirebaseException>()));
  });

  test('should throw firebase failure when registered failed', () async {
    when(mockFirebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .thenThrow(FirebaseAuthException(code: "100"));

    final call = userDataSource.register;

    expect(() => call(email: email, password: password, name: name),
        throwsA(const TypeMatcher<CustomFirebaseException>()));
  });
}
