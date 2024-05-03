import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopus/app/bloc/app_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: UserText()),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => context.read<AuthRepository>().signOut(),
        child: const Icon(Icons.exit_to_app),
      ),
    );
  }
}

class UserText extends StatelessWidget {
  const UserText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count =
        context.select((AppBloc bloc) => bloc.state.hasCompletedOnboarding);
    return Text('$count', style: theme.textTheme.displayLarge);
  }
}
