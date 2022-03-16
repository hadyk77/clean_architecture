import 'package:clean_code/modules/authentication/domain/entities/user_entity.dart';
import 'package:clean_code/modules/authentication/domain/use_cases/register_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'login_use_case_test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late RegisterUseCase registerUseCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    registerUseCase = RegisterUseCase(userRepository: mockUserRepository);
  });

  const email = "hadykamel3@gmail.com";
  const password = "123456";
  const name = "hady mohamed";
  const user = UserEntity(
    uid: "1",
    email: email,
    name: name,
  );

  test('should return user when registered sucessfully', () async {
    when(mockUserRepository.register(
            email: email, password: password, name: name))
        .thenAnswer((realInvocation) async => const Right(user));

    final result =
        await registerUseCase(email: email, password: password, name: name);
    expect(result, const Right(user));

    verify(mockUserRepository.register(
        name: name, email: email, password: password));
  });
}
