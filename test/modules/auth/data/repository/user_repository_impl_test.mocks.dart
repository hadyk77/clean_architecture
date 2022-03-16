// Mocks generated by Mockito 5.1.0 from annotations
// in clean_code/test/modules/auth/data/repository/user_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:clean_code/modules/authentication/data/data_source/user_data_source.dart'
    as _i3;
import 'package:clean_code/modules/authentication/data/models/user_model.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeUserModel_0 extends _i1.Fake implements _i2.UserModel {}

/// A class which mocks [UserDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserDataSource extends _i1.Mock implements _i3.UserDataSource {
  MockUserDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.UserModel> login({String? email, String? password}) => (super
      .noSuchMethod(
          Invocation.method(#login, [], {#email: email, #password: password}),
          returnValue: Future<_i2.UserModel>.value(_FakeUserModel_0())) as _i4
      .Future<_i2.UserModel>);
  @override
  _i4.Future<_i2.UserModel> register(
          {String? email, String? password, String? name}) =>
      (super.noSuchMethod(
              Invocation.method(#register, [],
                  {#email: email, #password: password, #name: name}),
              returnValue: Future<_i2.UserModel>.value(_FakeUserModel_0()))
          as _i4.Future<_i2.UserModel>);
  @override
  _i4.Future<void> logout() =>
      (super.noSuchMethod(Invocation.method(#logout, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
}