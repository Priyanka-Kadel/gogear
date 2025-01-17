import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String username;
  final String email;
  final String phone;
  final String password;

  RegisterSubmitted({
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
  });

  @override
  List<Object> get props => [username, email, phone, password];
}
