import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String? imageUrl;
  const UserEntity({
    required this.uid,
    required this.email,
    required this.name,
    this.imageUrl,
  });
  @override
  List<Object?> get props => [name, email, imageUrl, uid];
}
