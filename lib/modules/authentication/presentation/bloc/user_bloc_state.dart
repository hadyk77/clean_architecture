part of 'user_bloc.dart';

abstract class UserBlocState extends Equatable {
  const UserBlocState();

  @override
  List<Object> get props => [];
}

class LoadingState extends UserBlocState {}

class UnAuthenticatedState extends UserBlocState {}

class AuthenticatedState extends UserBlocState {
  final UserEntity user;

  const AuthenticatedState(this.user);
}

class ErrorState extends UserBlocState {
  final Failure failure;

  const ErrorState(this.failure);
}
