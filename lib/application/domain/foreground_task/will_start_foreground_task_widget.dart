import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import '../../../generated/l10n.dart';
import 'check_update_task_handler.dart';

class WillStartForegroundTaskWidget extends StatelessWidget {
  final Widget child;
  const WillStartForegroundTaskWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillStartForegroundTask(
      onWillStart: () async {
        FlutterForegroundTask.saveData(key: 'customData', value: 'hello');
        return true;
      },
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'movie_night_check_update_23',
        channelName: 'Check update',
        channelDescription:
            'This notification appears when the app starts checking to see if the movies, TV shows, or people you\'ve marked as favorite have been updated.',
        channelImportance: NotificationChannelImportance.HIGH,
        priority: NotificationPriority.HIGH,
        isSticky: true,
        visibility: NotificationVisibility.VISIBILITY_PUBLIC,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
        ),
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 10000,
        autoRunOnBoot: true,
        allowWifiLock: true,
      ),
      printDevLog: true,
      notificationTitle: S.of(context).checking_data_for_updates,
      notificationText: S.of(context).click_to_open_the_application,
      callback: () => _startCallback(),
      child: child,
    );
  }

  void _startCallback() async {
    FlutterForegroundTask.setTaskHandler(CheckUpdateTaskHandler());
  }
}
