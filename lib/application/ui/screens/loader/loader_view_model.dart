import 'package:flutter/cupertino.dart';

import '../../navigation/app_navigation.dart';

class LoaderViewModel {
  final BuildContext context;

  LoaderViewModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    const isAuth = false;
    final nextScreen = isAuth ? Screens.main : Screens.signIn;
    // Future.microtask(
    //   () => Navigator.of(context).pushReplacementNamed(nextScreen),
    // );
  }
}
