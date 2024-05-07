import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository_user/repository_user.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.read<RepositoryUser>().signInWithEmailAndPassword(
                  email: 'test@mail.ch',
                  password: 'password123',
                ),
        child: const Icon(Icons.verified_user),
      ),
    );
  }
}
