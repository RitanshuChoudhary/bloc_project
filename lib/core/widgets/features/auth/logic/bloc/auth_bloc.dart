import 'package:bloctodolist/core/widgets/features/auth/data/models/user_model.dart';
import 'package:bloctodolist/core/widgets/features/auth/logic/bloc/auth_event.dart';
import 'package:bloctodolist/core/widgets/features/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  User? user;
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AppStarts>((event, emit) {
      if (user != null) {
        emit(AuthAuthenticated(user: user!));
      } else {
        emit(AuthUnAuthenticated());
      }
    });

    on<LoginRequested>((event, emit) {
      emit(AuthLoading());
    });
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.signUp(
          username: event.userName,
          email: event.email,
          password: event.password,
        );
        if (user != null) {
          emit(AuthAuthenticated(user: user));
        } else {
          emit(AuthUnAuthenticated());
        }
      } catch (e) {
        emit(AuthError(errorMessage: e.toString()));
        emit(AuthUnAuthenticated());
      }
    });
    on<LogoutRequested>((event, emit) {
      emit(AuthLoading());
      user = null;
      emit(AuthUnAuthenticated());
    });
  }
}
