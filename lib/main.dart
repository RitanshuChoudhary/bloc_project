import 'package:bloctodolist/core/widgets/features/auth/logic/bloc/auth_event.dart';
import 'package:bloctodolist/utils/app_router.dart';
import 'package:bloctodolist/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/widgets/features/auth/logic/bloc/auth_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc()..add(AppStarts()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
      ),
    );
  }
}
