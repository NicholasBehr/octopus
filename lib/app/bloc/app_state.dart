part of 'app_bloc.dart';

@immutable
final class AppState extends Equatable {
  AppState({
    this.user,
    bool? hasCompletedOnboarding,
  })  : isAuthenticated = user != null,
        isVerified = user?.emailVerified ?? false,
        hasCompletedOnboarding = hasCompletedOnboarding ?? false;

  final User? user;
  final bool isAuthenticated;
  final bool isVerified;
  final bool hasCompletedOnboarding;

  /// Returns a copy of this `AppState` with the given values updated.
  AppState copyWith({
    User? user,
    bool? hasCompletedOnboarding,
  }) {
    return AppState(
      user: user ?? this.user,
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
    );
  }

  @override
  List<Object> get props => [
        isAuthenticated,
        isVerified,
        hasCompletedOnboarding,
      ];
}
