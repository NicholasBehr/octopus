import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:go_router/go_router.dart';

import 'package:octopus/app/bloc/app_bloc.dart';
import 'package:octopus/counter/counter.dart';
import 'package:octopus/counter/view/counter_page.dart';
import 'package:octopus/login/login.dart';

GoRouter buildRouter({
  required AppBloc appBloc,
}) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshStream(appBloc.stream),
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LoginPage()),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const CounterPage(),
      ),
    ],
    redirect: (context, state) {
      final isAuthenticated = appBloc.state.isAuthenticated;
      final onLoginPage = state.matchedLocation == '/login';

      // switch to login if unauthenticated
      if (!isAuthenticated) {
        return '/login';
      }

      // transition out of login to hmepage upon transition
      if (onLoginPage && isAuthenticated) {
        return '/home';
      }

      return null;
    },
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
