import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String email;
  final String username;
  final String password;
  final String phone;

  const AuthEntity({
    this.userId,
    required this.email,
    required this.username,
    required this.password,
    required this.phone,
  });

  @override
  List<Object?> get props => [userId, email, phone, username, password];
}
