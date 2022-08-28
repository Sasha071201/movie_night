import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:movie_night/application/domain/data_providers/data_provider.dart';

import '../../../generated/l10n.dart';
import '../database/database.dart';
import 'check_update_task_handler.dart';

class ForegroundTask {
  ForegroundTask._();

  static const Duration durationUpdate = Duration(hours: 11);

  static Future<void> initForegroundTask() async {
    await FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'movie_night_check_update_22',
        channelName: 'Check update',
        channelDescription:
            'This notification appears when the app starts checking to see if the movies, TV shows, or people you\'ve marked as favorite have been updated.',
        channelImportance: NotificationChannelImportance.HIGH,
        priority: NotificationPriority.HIGH,
        isSticky: true,
        playSound: true,
        visibility: NotificationVisibility.VISIBILITY_PUBLIC,
        iconData: const NotificationIconData(
          resType: ResourceType.drawable,
          resPrefix: ResourcePrefix.ic,
          name: 'notification',
        ),
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: true,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 5000,
        autoRunOnBoot: true,
        allowWifiLock: true,
      ),
      printDevLog: true,
    );
  }

  static Future<bool> startForegroundTask(BuildContext context) async {
    final dataProvider = DataProvider();
    final neededTime = await dataProvider.getNeededTime();
    final pastTime = DateTime.now();
    if (neededTime != null) {
      if (pastTime.compareTo(neededTime) >= 0) {
        final newNeedTime = DateTime.now().add(durationUpdate);
        await dataProvider.saveNeededTime(newNeedTime);

        ReceivePort? receivePort;
        if (await FlutterForegroundTask.isRunningService) {
          receivePort = await FlutterForegroundTask.restartService();
        } else {
          receivePort = await FlutterForegroundTask.startService(
            notificationTitle: S.of(context).checking_data_for_updates,
            notificationText: S.of(context).click_to_open_the_application,
            callback: _startCallback,
          );
        }
        if (receivePort != null) {
          final locale = Localizations.localeOf(context).toLanguageTag();
          await FlutterForegroundTask.saveData(key: 'locale', value: locale);
          final completer = Completer<bool>();
          try {
            receivePort.listen((message) async {
              if (message is SendPort) {
                final isolate = await createDriftIsolate();
                message.send(isolate.connectPort);
                completer.complete(true);
              }
            });
          } catch (e) {
            completer.completeError(e);
            rethrow;
          }
          await completer.future;
          return true;
        }
      }
    } else {
      final newNeedTime = DateTime.now().add(durationUpdate);
      await dataProvider.saveNeededTime(newNeedTime);
    }
    return false;
  }
}

void _startCallback() {
  FlutterForegroundTask.setTaskHandler(CheckUpdateTaskHandler());
}
