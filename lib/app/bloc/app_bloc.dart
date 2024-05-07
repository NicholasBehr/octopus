import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:repository_user/repository_user.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required RepositoryUser repositoryUser,
  })  : _repositoryUser = repositoryUser,
        super(const AppState()) {
    on<AppUserUpdateRecieved>(_onAppUserUpdateRecieved);
    _userStreamSubscription = _repositoryUser
        .getUserDataStream()
        .listen((user) => add(AppUserUpdateRecieved(user: user)));
  }

  final RepositoryUser _repositoryUser;
  late StreamSubscription<User?> _userStreamSubscription;

  void _onAppUserUpdateRecieved(
    AppUserUpdateRecieved event,
    Emitter<AppState> emit,
  ) {
    emit(AppState(user: event.user));
  }

  @override
  Future<void> close() async {
    await _userStreamSubscription.cancel();
    return super.close();
  }
}
