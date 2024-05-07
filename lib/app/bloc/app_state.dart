part of 'app_bloc.dart';

@immutable
final class AppState extends Equatable {
  const AppState({
    this.user,
  });

  final User? user;
  bool isAuthenticated() => user != null;

  bool isVerified() => user?.authUser.emailVerified ?? false;

  bool hasCompletedOnboarding() =>
      user?.dataUser.hasCompletedOnboarding ?? false;

  @override
  List<Object?> get props => [user];
}
