import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStarts extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String userName;
  final String password;
  final String email;

  LoginRequested({
    required this.userName,
    required this.password,
    required this.email,
  });
  @override
  List<Object?> get props => [userName, password];
}

class SignUpRequested extends AuthEvent {
  final String userName;
  final String password;
  SignUpRequested({required this.userName, required this.password});
  @override
  List<Object?> get props => [userName, password];
}

class LogoutRequested extends AuthEvent {}
