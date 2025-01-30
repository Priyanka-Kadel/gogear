import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String email;
  final String username;
  final String password;

  const AuthEntity({
    this.userId,
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [userId, email, username, password];
}
