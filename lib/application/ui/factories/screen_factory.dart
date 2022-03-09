import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/loader/loader_screen.dart';
import '../screens/loader/loader_view_model.dart';

class ScreenFactory {
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderViewModel(context),
      child: const LoaderScreen(),
      lazy: false,
    );
  }

  // Widget makeInitial() {
  //   return const InitialScreen();
  // }

  // Widget makeSignUp() {
  //   return const SignUpScreen();
  // }

  // Widget makeSignIn() {
  //   return const SignInScreen();
  // }

  // Widget makeMain() {
  //   return const Scaffold();
  // }
}
