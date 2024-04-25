import 'package:flutter/material.dart';

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: FloatingActionButton(
        onPressed: () =>
            context.read<AuthRepository>().signInWithEmailAndPassword(
                  email: 'test@mail.ch',
                  password: 'password123',
                ),
        child: const Icon(Icons.verified_user),
      ),
    );
  }
}
