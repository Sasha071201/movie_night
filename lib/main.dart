import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/database/database.dart';
import 'package:movie_night/application/domain/foreground_task/foreground_task.dart';
import 'package:movie_night/application/ui/app/app.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'application/ui/notifications/app_notification_manager.dart';

//TODO использовать provider либо get_it, чтобы было чище архитектура.
AppDatabase? database;

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // MobileAds.instance.initialize();
      await Firebase.initializeApp();

      timeago.setLocaleMessages('ru', timeago.RuMessages());

      await _initDatabaser();

      await ForegroundTask.initForegroundTask();

      await AppNotificationManager.init(initScheduled: true);

      FlutterError.onError = (FlutterErrorDetails errorDetails) async {
        if (errorDetails.exception is HttpException) {
          final exception = errorDetails.exception as HttpException;
          if (exception.uri.toString().contains('image.tmdb.org')) return;
          await FirebaseCrashlytics.instance.recordError(
            errorDetails.exception,
            errorDetails.stack,
            reason: 'Error HttpException: ${errorDetails.exception}',
          );
        } else if (errorDetails.exception is SocketException) {
          print('help');
        } else {
          await FirebaseCrashlytics.instance.recordError(
            errorDetails.exception,
            errorDetails.stack,
            reason: 'Error FlutterError: ${errorDetails.exception}',
          );
        }
      };

      const app = App();
      runApp(app);
    },
    (exception, stackTrace) async {
      await FirebaseCrashlytics.instance.recordError(
        exception,
        stackTrace,
        reason: 'Error runZonedGuarded: $exception',
      );
    },
  );
}

Future<void> _initDatabaser() async {
  final connection = createDriftIsolateAndConnect();
  database = AppDatabase.connect(connection);
}
