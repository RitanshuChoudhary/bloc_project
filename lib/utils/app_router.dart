import 'package:bloctodolist/core/widgets/features/auth/data/models/user_model.dart';
import 'package:bloctodolist/core/widgets/features/auth/presentation/pages/sign_in_page.dart';
import 'package:bloctodolist/core/widgets/features/auth/presentation/pages/sign_up_page.dart';
import 'package:bloctodolist/core/widgets/features/task/presentation/task_page.dart';
import 'package:flutter/material.dart';
import '../core/widgets/features/auth/presentation/pages/splash_page.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashPage());

      case AppRoutes.signIn:
        return MaterialPageRoute(builder: (_) => SignInPage());

      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => SignUpPage());

      case AppRoutes.task:
        final user = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (_) => TaskPage(user: user));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
