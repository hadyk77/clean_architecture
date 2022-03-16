import 'package:bloc/bloc.dart';
import 'package:clean_code/core/error/failure.dart';
import 'package:clean_code/modules/authentication/domain/entities/user_entity.dart';
import 'package:clean_code/modules/authentication/domain/use_cases/login_use_case.dart';
import 'package:clean_code/modules/authentication/domain/use_cases/logout_use_case.dart';
import 'package:clean_code/modules/authentication/domain/use_cases/register_use_case.dart';
import 'package:equatable/equatable.dart';

part 'user_bloc_event.dart';
part 'user_bloc_state.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  UserBloc(
      {required this.loginUseCase,
      required this.registerUseCase,
      required this.logoutUseCase})
      : super(UnAuthenticatedState()) {
    on<LoginEvent>((event, emit) => _login(event, emit));
    on<RegisterEvent>((event, emit) => _register(event, emit));
    on<LogoutEvent>(_logout);
  }

  Future<void> _login(LoginEvent event, Emitter emit) async {
    emit(LoadingState());

    final result =
        await loginUseCase(email: event.email, password: event.password);

    result.fold(
      (l) => emit(ErrorState(l)),
      (r) => emit(AuthenticatedState(r)),
    );
  }

  Future<void> _register(RegisterEvent event, Emitter emit) async {
    emit(LoadingState());
    final result = await registerUseCase(
        email: event.email, password: event.password, name: event.name);

    result.fold(
      (l) => emit(ErrorState(l)),
      (r) => emit(AuthenticatedState(r)),
    );
  }

  Future<void> _logout(LogoutEvent event, Emitter emit) async {
    final result = await logoutUseCase();

    result.fold(() => emit(UnAuthenticatedState()), (a) => emit(ErrorState(a)));
  }
}
