part of 'app_bloc.dart';

@immutable
final class AppState extends Equatable {
  AppState({
    this.user,
  })  : isAuthenticated = user != null,
        isVerified = user?.emailVerified ?? false;

  final User? user;
  final bool isAuthenticated;
  final bool isVerified;

  @override
  List<Object> get props => [isAuthenticated, isVerified];
}
