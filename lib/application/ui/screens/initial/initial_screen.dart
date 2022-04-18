import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/factories/screen_factory.dart';
import 'package:movie_night/application/ui/screens/initial/initial_view_model.dart';
import 'package:movie_night/application/ui/screens/loader/loader_screen.dart';
import 'package:movie_night/application/ui/screens/sign_in/sign_in_screen.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<InitialViewModel>();
    final screenFactory = ScreenFactory();
    return StreamBuilder<User?>(
      stream: vm.userChanges,
      builder: ((context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return const LoaderScreen();
        } else {
          if (snapshot.hasData) {
            final user = snapshot.data;
            if (user!.emailVerified) {
              return screenFactory.makeMain();
            } else {
              return const SignInScreen();
            }
          } else {
            return const SignInScreen();
          }
        }
      }),
    );
  }
}
