import 'package:clean_code/modules/authentication/domain/entities/user_entity.dart';
import 'package:clean_code/modules/authentication/domain/repository/user_repository.dart';
import 'package:clean_code/modules/authentication/domain/use_cases/login_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_use_case_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockUserRepository;

  late LoginUseCase loginUseCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    loginUseCase = LoginUseCase(userRepository: mockUserRepository);
  });
  const email = "hadykamel3@gmail.com";
  const password = "123456";
  const user =
      UserEntity(uid: "1", email: "hadykamel3@gmail.com", name: "hady mohamed");

  test("should return user when logged in", () async {
    when(mockUserRepository.login(email: email, password: password))
        .thenAnswer((realInvocation) async => const Right(user));

    final result = await loginUseCase(email: email, password: password);

    expect(result, const Right(user));

    verify(mockUserRepository.login(email: email, password: password));
  });
}
