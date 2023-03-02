import 'dart:async';
import 'package:packages/auth_repo/enums/auth_enum.dart';

class AuthenticationRepo{

  //Controller used to monitor changes in the Stream
  final _controller = StreamController<AuthenticationStatus>();

  //async = used for Futures
  //async* = used for Streams
  //Reference: https://stackoverflow.com/a/60036568
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));

    //In streams we use yield instead of return
    //Reference: https://stackoverflow.com/a/57492636

    //By default AuthStatus yields unauthenticated
    yield AuthenticationStatus.unauthenticated;
    //If any change come in the stream it will trigger this second yield
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  //Since we are maintaining a StreamController internally,
  //a dispose method is exposed so that the controller can be closed when it is no longer needed.
  void dispose() => _controller.close();
}