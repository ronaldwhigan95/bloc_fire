import 'package:auth_repo/authentication_repo.dart';
import 'package:bloc_fire/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc_fire/splash/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repo/user_repo.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepo _ar;
  late final UserRepo _ur;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ar = AuthenticationRepo();
    _ur = UserRepo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _ar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _ar),
        RepositoryProvider.value(value: _ur),
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          ar: _ar,
          ur: _ur,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  //TODO: Optimize Navigation

  final _navKey = GlobalKey<NavigatorState>();

  NavigatorState get _nav => _navKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _nav.pushAndRemoveUntil<void>(
                  HomeView.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _nav.pushAndRemoveUntil<void>(
                  LoginView.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashView.route(),
    );
  }
}
