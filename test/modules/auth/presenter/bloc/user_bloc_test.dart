import 'package:clean_code/core/error/failure.dart';
import 'package:clean_code/modules/authentication/domain/entities/user_entity.dart';
import 'package:clean_code/modules/authentication/domain/use_cases/login_use_case.dart';
import 'package:clean_code/modules/authentication/domain/use_cases/logout_use_case.dart';
import 'package:clean_code/modules/authentication/domain/use_cases/register_use_case.dart';
import 'package:clean_code/modules/authentication/presentation/bloc/user_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_bloc_test.mocks.dart';

@GenerateMocks([LoginUseCase, RegisterUseCase, LogoutUseCase])
void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late UserBloc userBloc;
  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    mockLogoutUseCase = MockLogoutUseCase();

    userBloc = UserBloc(
      loginUseCase: mockLoginUseCase,
      registerUseCase: mockRegisterUseCase,
      logoutUseCase: mockLogoutUseCase,
    );
  });
  const email = "hadykamel3@gmail.com";
  const password = "123456";
  const String name = "hady mohamed";
  const UserEntity user = UserEntity(uid: "1", email: email, name: name);
  const Failure failure =
      FirebaseFailure(message: "invalid email or password", code: "401");
  test('should emit authenticated state when login sucess', () async* {
    when(mockLoginUseCase(email: email, password: password))
        .thenAnswer((_) async => const Right(user));

    userBloc.add(const LoginEvent(email: email, password: password));

    final expcted = [
      UnAuthenticatedState(),
      LoadingState(),
      const AuthenticatedState(user)
    ];
    expectLater(userBloc.state, emitsInOrder(expcted));
  });

  test('should emit error state when login failed', () async* {
    when(mockLoginUseCase(email: email, password: password))
        .thenAnswer((realInvocation) async => const Left(failure));

    userBloc.add(const LoginEvent(email: email, password: password));

    final expcted = [
      UnAuthenticatedState(),
      LoadingState(),
      const ErrorState(failure)
    ];
    expectLater(userBloc.state, emitsInOrder(expcted));
  });

  group('test register use case', () {
    test('should bloc state be authenticated when register sucess', () async* {
      when(mockRegisterUseCase(email: email, password: password, name: name))
          .thenAnswer((_) async => const Right(user));

      userBloc.add(
          const RegisterEvent(email: email, password: password, name: name));

      expectLater(
          userBloc.state, emitsInOrder([const AuthenticatedState(user)]));
    });
  });
}
