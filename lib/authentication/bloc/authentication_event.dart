part of 'authentication_bloc.dart';

// AuthenticationEvent instances will be the input to the
// AuthenticationBloc and will be processed and used to emit new
// AuthenticationState instances.
abstract class AuthenticationEvent {
  const AuthenticationEvent();
}
//Events are represented as classes
//Events refers to an activity to be performed

//notifies the bloc of a change to the user's AuthenticationStatus
class _AuthenticationStatusChanged extends AuthenticationEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;
}

//notifies the bloc of a logout request
class AuthenticationLogoutRequest extends AuthenticationEvent {}
