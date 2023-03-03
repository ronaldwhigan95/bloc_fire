part of 'authentication_bloc.dart';

//For this, recall the auth_staus made and follow what was indicated there
class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unauthenticated,
    this.user = UserModel.emptyUser,
  });

  final AuthenticationStatus status;
  final UserModel user;

  const AuthenticationState.authenticated(UserModel user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.unknown() : this._();

  @override
  // TODO: implement props
  List<Object?> get props => [status, user];
}
