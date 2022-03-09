import 'package:flutter/material.dart';

import '../factories/screen_factory.dart';

abstract class Screens {
  Screens._();
  static const loader = "/";
  static const signIn = "/sign_in";
  static const signUp = "/sign_in/sign_up";
  static const main = "/main";
}

class AppNavigation {
  static final _screenFactory = ScreenFactory();

  static Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Screens.loader:
        return _getScreenRoute(_screenFactory.makeLoader());
      // case Screens.signUp:
      //   return _getScreenRoute(_screenFactory.makeSignUp());
      // case Screens.signIn:
      //   return _getScreenRoute(_screenFactory.makeSignIn());
      // case Screens.main:
      //   return _getScreenRoute(_screenFactory.makeMain());
      default:
        return _getScreenRoute(
          const Scaffold(
            body: Center(
              child: Text("Ошибка"),
            ),
          ),
        );
    }
  }

  static void pop(BuildContext context, int count) {
    int number = 0;
    Navigator.of(context).popUntil((route) {
      return number++ == count;
    });
  }

  static Route<Object> _getScreenRoute(Widget child) => PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1),
        pageBuilder: (context, animation, _) => FadeTransition(
          opacity: animation,
          child: child,
        ),
      );

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      Screens.loader,
      (route) => false,
    );
  }
}