import 'package:bloctodolist/core/widgets/features/auth/logic/bloc/auth_bloc.dart';
import 'package:bloctodolist/core/widgets/features/auth/logic/bloc/auth_event.dart';
import 'package:bloctodolist/core/widgets/features/auth/logic/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../utils/app_routes.dart';

class SignInPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  SignInPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.home,
              arguments: state.user,
            );
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (BuildContext context, AuthState state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(hintText: "Password"),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      LoginRequested(
                        password: passwordController.text,
                        email: emailController.text,
                      ),
                    );
                  },
                  child: Text("Login"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.signup);
                  },
                  child: Text("Don’t have an account? Sign up"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
