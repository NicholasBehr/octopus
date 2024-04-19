import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AppState()) {
    on<AppAuthUpdateRecieved>(_onAuthUpdateRecieved);
    on<AppSignOutRequested>(_onSignOutRequested);
    _authRepository.getAuthUpdates().forEach(
          (authUpdate) => add(AppAuthUpdateRecieved(authUpdate: authUpdate)),
        );
  }

  final AuthRepository _authRepository;

  Future<void> _onAuthUpdateRecieved(
    AppAuthUpdateRecieved event,
    Emitter<AppState> emit,
  ) async {
    switch (event.authUpdate) {
      case Right(value: final user):
        emit(
          AppState(
            status: user != null
                ? AuthStatus.authenticated
                : AuthStatus.unauthenticated,
            user: user,
          ),
        );
      case Left(value: final _):
        emit(const AppState());
    }
  }

  Future<void> _onSignOutRequested(
    AppSignOutRequested event,
    Emitter<AppState> emit,
  ) async {
    await _authRepository.signOut();
  }
}
