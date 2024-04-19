part of 'app_bloc.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}

final class AppState extends Equatable {
  const AppState({
    this.status = AuthStatus.unauthenticated,
    this.user,
  });

  final AuthStatus status;
  final User? user;

  @override
  List<Object> get props => [status];
}
