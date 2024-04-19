import 'package:flutter/material.dart';

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:octopus/app/bloc/app_bloc.dart';
import 'package:octopus/counter/counter.dart';
import 'package:octopus/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({required this.authRepository, super.key});

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authRepository: authRepository,
        ),
        child: const AppView(),
        lazy: false,
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CounterPage(),
    );
  }
}
