part of 'app_bloc.dart';

@immutable
sealed class AppEvent {
  const AppEvent();
}

final class AppUserUpdateRecieved extends AppEvent {
  const AppUserUpdateRecieved({required this.user});
  final User? user;
}
