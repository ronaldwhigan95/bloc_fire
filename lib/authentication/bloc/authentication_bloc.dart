import 'dart:async';

import 'package:auth_repo/authentication_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repo/user_repo.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

// The AuthenticationBloc manages the authentication state
// of the application which is used to determine things like
// whether or not to start the user at a login page or a home page.

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthenticationRepo ar, required UserRepo ur})
      : _ur = ur,
        _ar = ar,
        super(const AuthenticationState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequest>(_onAuthenticationLogoutRequested);
    _authenticationStatusSubscription = _ar.status.listen((event) {
      add(_AuthenticationStatusChanged(event));
    });
  }

  final AuthenticationRepo _ar;
  final UserRepo _ur;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  Future<UserModel?> _tryGetUser() async {
    try {
      final user = await _ur.getUserDetails();
      return user;
    } catch (_) {
      return null;
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequest event,
    Emitter<AuthenticationState> emit,
  ) {
    _ar.logOut();
  }

  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.authenticated:
        final userProfile = await _tryGetUser();
        return emit(userProfile != null
            ? AuthenticationState.authenticated(userProfile)
            : const AuthenticationState.unauthenticated());
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  @override
  Future<void> close() async {
    _authenticationStatusSubscription.cancel();
    super.close();
  }
}
