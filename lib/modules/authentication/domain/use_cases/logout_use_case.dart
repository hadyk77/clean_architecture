import 'package:clean_code/modules/authentication/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class LogoutUseCase {
  final UserRepository userRepository;

  LogoutUseCase({required this.userRepository});

  Future<Option<Failure>> call() async {
    return userRepository.logout();
  }
}
