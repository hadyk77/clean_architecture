import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repository/user_repository.dart';

class LoginUseCase {
  final UserRepository userRepository;
  LoginUseCase({required this.userRepository});
  Future<Either<Failure, UserEntity>> call(
      {required String email, required String password}) async {
    return await userRepository.login(email: email, password: password);
  }
}
