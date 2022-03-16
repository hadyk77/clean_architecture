import 'package:clean_code/modules/authentication/data/data_source/user_data_source.dart';
import 'package:clean_code/modules/authentication/data/data_source/user_data_source_impl.dart';
import 'package:clean_code/modules/authentication/data/repository/user_repository_impl.dart';
import 'package:clean_code/modules/authentication/domain/repository/user_repository.dart';
import 'package:clean_code/modules/authentication/domain/use_cases/login_use_case.dart';
import 'package:clean_code/modules/authentication/domain/use_cases/logout_use_case.dart';
import 'package:clean_code/modules/authentication/domain/use_cases/register_use_case.dart';
import 'package:clean_code/modules/authentication/presentation/bloc/user_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final dI = GetIt.instance;
Future<void> init() async {
  //! Features
  dI.registerFactory<UserBloc>(
    () => UserBloc(
        loginUseCase: dI(), registerUseCase: dI(), logoutUseCase: dI()),
  );
  //! Core
  dI.registerLazySingleton(() => LoginUseCase(userRepository: dI()));
  dI.registerLazySingleton(() => RegisterUseCase(userRepository: dI()));
  dI.registerLazySingleton(() => LogoutUseCase(userRepository: dI()));
  dI.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(dI()));
  dI.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl(dI()));
  //! External Dependency

  dI.registerLazySingleton(() => FirebaseAuth.instance);
}
