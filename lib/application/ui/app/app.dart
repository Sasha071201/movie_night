import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../generated/l10n.dart';
import '../navigation/app_navigation.dart';
import '../themes/app_theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppTheme.dark,
        darkTheme: AppTheme.dark,
        debugShowCheckedModeBanner: false,
        title: 'Movie Night',
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        initialRoute: Screens.loader,
        onGenerateRoute: AppNavigation.onGenerateRoute,
      );
  }
}