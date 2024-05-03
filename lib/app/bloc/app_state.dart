part of 'app_bloc.dart';

@immutable
final class AppState extends Equatable {
  const AppState({
    this.userAuth,
    this.userData,
  });

  // auth repository
  final UserAuth? userAuth;
  bool isAuthenticated() => userAuth != null;
  bool isVerified() => userAuth?.emailVerified ?? false;

  // data repository
  final UserData? userData;
  bool hasCompletedOnboarding() => userData?.hasCompletedOnboarding ?? false;

  /// Returns a copy of this [AppState] with the given values updated.
  AppState copyWith({
    UserAuth? userAuth,
    UserData? userData,
  }) {
    return AppState(
      userAuth: userAuth ?? this.userAuth,
      userData: userData ?? this.userData,
    );
  }

  @override
  List<Object?> get props => [
        userAuth,
        userData,
      ];
}
