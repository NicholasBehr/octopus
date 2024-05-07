import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopus/app/bloc/app_bloc.dart';
import 'package:octopus/app/routes/routes.dart';
import 'package:octopus/l10n/l10n.dart';
import 'package:repository_user/repository_user.dart';

class App extends StatelessWidget {
  const App({
    required this.repositoryUser,
    super.key,
  });

  final RepositoryUser repositoryUser;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RepositoryUser>(create: (context) => repositoryUser),
      ],
      child: BlocProvider(
        create: (_) => AppBloc(
          repositoryUser: repositoryUser,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        AppRouter.router.refresh();
      },
      child: MaterialApp.router(
        // localization
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,

        // router
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routerDelegate: AppRouter.router.routerDelegate,

        // theme
        theme: ThemeData(
          colorSchemeSeed: Colors.green,
          useMaterial3: true,
        ),
      ),
    );
  }
}
