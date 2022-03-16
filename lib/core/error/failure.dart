import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  final String? code;
  const Failure({this.message, this.code});
  @override
  List<Object?> get props => [message, code];
}

class ServerFailure extends Failure {}

class FirebaseFailure extends Failure {
  const FirebaseFailure({String? message, String? code})
      : super(message: message, code: code);
}
