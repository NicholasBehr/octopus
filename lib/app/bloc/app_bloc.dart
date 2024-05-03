import 'dart:async';
import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthRepository authRepository,
    required DataRepository dataRepository,
  })  : _authRepository = authRepository,
        _dataRepository = dataRepository,
        super(const AppState()) {
    on<AppAuthUpdateRecieved>(_onAuthUpdateRecieved);
    on<AppUserDataRecieved>(_onUserDataRecieved);
    on<AppSignOutRequested>(_onSignOutRequested);
    _authRepository.getAuthUpdates().forEach(
          (authUpdate) => add(AppAuthUpdateRecieved(authUpdate: authUpdate)),
        );
  }

  final AuthRepository _authRepository;
  final DataRepository _dataRepository;

  StreamSubscription<UserData>? _userDataSubscription;

  void _onAuthUpdateRecieved(
    AppAuthUpdateRecieved event,
    Emitter<AppState> emit,
  ) {
    switch (event.authUpdate) {
      case Right(value: final user):
        emit(AppState(userAuth: user));

        if (user != null) {
          _userDataSubscription =
              _dataRepository.getUserDataStream(user.uid).listen(
                    (userData) => add(AppUserDataRecieved(userData: userData)),
                  );
        } else {
          _userDataSubscription?.cancel();
        }
      case Left(value: final _):
        emit(const AppState());
        _userDataSubscription?.cancel();
    }
  }

  void _onUserDataRecieved(
    AppUserDataRecieved event,
    Emitter<AppState> emit,
  ) =>
      emit(state.copyWith(userData: event.userData));

  Future<void> _onSignOutRequested(
    AppSignOutRequested event,
    Emitter<AppState> emit,
  ) async {
    await _authRepository.signOut();
  }

  @override
  Future<void> close() async {
    await _userDataSubscription?.cancel();
    return super.close();
  }
}
