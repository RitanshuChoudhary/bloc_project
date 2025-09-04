import 'package:bloctodolist/core/widgets/features/auth/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserModel user;
  AuthAuthenticated({required this.user});
  @override
  List<Object?> get props => [user];
}

class AuthUnAuthenticated extends AuthState {}

class AuthError extends AuthState {
  final String errorMessage;
  AuthError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
