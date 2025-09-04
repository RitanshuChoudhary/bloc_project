import 'package:bloctodolist/core/widgets/features/auth/data/models/user_model.dart';
import 'package:bloctodolist/core/widgets/features/auth/logic/bloc/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserModel? user;
  AuthBloc() : super(AuthInitial()) {
    on<AppStarts>((event, emit) {
      if (user != null) {
        emit(AuthAuthenticated(user: user!));
      } else {
        emit(AuthUnAuthenticated());
      }
    });

    on<LoginRequested>((event, emit) {
      emit(AuthLoading());
      if (user != null &&
          user!.userName == event.userName &&
          user!.password == event.password) {
        emit(AuthAuthenticated(user: user!));
      } else {
        emit(AuthError(errorMessage: "Invalid username or password"));
        emit(AuthUnAuthenticated());
      }
    });
    on<SignUpRequested>((event, emit) {
      emit(AuthLoading());
      user = UserModel(
        id: DateTime.now().toString(),
        userName: event.userName,
        email: event.userName,
        password: event.password,
      );
      emit(AuthAuthenticated(user: user!));
    });
    on<LogoutRequested>((event, emit) {
      emit(AuthLoading());
      user = null;
      emit(AuthUnAuthenticated());
    });
  }
}
