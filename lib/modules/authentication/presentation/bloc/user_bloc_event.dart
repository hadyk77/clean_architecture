part of 'user_bloc.dart';

abstract class UserBlocEvent extends Equatable {
  const UserBlocEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends UserBlocEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends UserBlocEvent {
  final String email;
  final String password;
  final String name;

  const RegisterEvent(
      {required this.email, required this.password, required this.name});
}

class LogoutEvent extends UserBlocEvent {}
