import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase {
  final UserRepository userRepository;

  RegisterUseCase({required this.userRepository});

  Future<Either<Failure, UserEntity>> call(
      {required String email, required String password, required String name}) {
    return userRepository.register(
        name: name, email: email, password: password);
  }
}
