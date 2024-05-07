import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository_user/repository_user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const HomePageBody(),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => context.read<RepositoryUser>().signOut(),
        child: const Icon(Icons.exit_to_app),
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text('test'),
    );
  }
}
