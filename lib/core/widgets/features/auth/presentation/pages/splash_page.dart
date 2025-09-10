import 'package:bloctodolist/core/widgets/features/auth/data/models/user_model.dart';
import 'package:bloctodolist/core/widgets/features/auth/logic/bloc/auth_bloc.dart';
import 'package:bloctodolist/core/widgets/features/auth/logic/bloc/auth_state.dart';
import 'package:bloctodolist/utils/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.of(
            context,
          ).pushReplacementNamed(AppRoutes.task, arguments: state.user);
        }
        if (state is AuthUnAuthenticated) {
          Navigator.of(context).pushReplacementNamed(
            AppRoutes.signIn,
            arguments: UserModel(
              id: "id",
              userName: "userName",
              email: "email",
              password: "password",
            ),
          );
        }
      },
      child: Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
