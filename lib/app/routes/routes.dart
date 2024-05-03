import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:octopus/app/bloc/app_bloc.dart';
import 'package:octopus/home/home.dart';
import 'package:octopus/login/login.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LoginPage()),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
    ],
    redirect: (context, state) {
      final appBloc = BlocProvider.of<AppBloc>(context);
      final isAuthenticated = appBloc.state.isAuthenticated;

      // 1. authentication guard clause
      if (!isAuthenticated) {
        return '/login';
      }

      // 2. inside app guard clause
      if (state.matchedLocation == '/login') {
        return '/home';
      }

      // we are authenticated & inside the app :)

      return null;
    },
  );
}
