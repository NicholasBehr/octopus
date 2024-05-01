part of 'app_bloc.dart';

@immutable
sealed class AppEvent {
  const AppEvent();
}

final class AppAuthUpdateRecieved extends AppEvent {
  const AppAuthUpdateRecieved({required this.authUpdate});

  final AuthUpdate authUpdate;
}

final class AppUserDataRecieved extends AppEvent {
  const AppUserDataRecieved({required this.userData});

  final UserData userData;
}

final class AppSignOutRequested extends AppEvent {
  const AppSignOutRequested();
}
