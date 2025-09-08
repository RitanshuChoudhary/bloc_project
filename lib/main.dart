import 'package:bloctodolist/core/widgets/features/auth/logic/bloc/auth_event.dart';
import 'package:bloctodolist/utils/app_router.dart';
import 'package:bloctodolist/utils/app_routes.dart';
import 'package:bloctodolist/utils/bloc_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/widgets/features/auth/logic/bloc/auth_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // if you used FlutterFire CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform, // only if using FlutterFire CLI
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppProviders.allProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
      ),
    );
  }
}
