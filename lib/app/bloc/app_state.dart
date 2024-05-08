part of 'app_bloc.dart';

@immutable
final class AppState extends Equatable {
  const AppState({
    this.user,
  });

  final User? user;

  bool get isAuthenticated => user != null;
  bool get isVerified => user?.emailVerified ?? false;
  bool get hasCompletedOnboarding => user?.hasCompletedOnboarding ?? false;

  @override
  List<Object?> get props => [user];
}
