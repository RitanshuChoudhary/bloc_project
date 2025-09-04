import 'package:bloctodolist/core/widgets/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final UserModel user;
  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("${user.userName},${user.email}")),
    );
  }
}
