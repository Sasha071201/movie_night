import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:movie_night/application/domain/ad_mob/ad_helper.dart';
import 'package:movie_night/application/domain/connectivity/app_connectivity_reactor.dart';
import 'package:movie_night/application/domain/foreground_task/foreground_task.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';
import 'package:movie_night/application/ui/notifications/app_notification_manager.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/widgets/dialog_widget.dart';
import 'package:movie_night/generated/l10n.dart';

import '../../../domain/ad_mob/app_lifecycle_reactor.dart';

class MainViewModel extends ChangeNotifier {
  String _errorMessge = '';
  late AppLifecycleReactor _appLifecycleReactor;
  AppConnectivityReactor? _appConnectivityReactor;
  StreamSubscription? _notificationStreamSubscription;
  DateTime? _currentBackPressTime;
  var _currentTabIndex = 0;
  Timer? _timer;
  String _locale = '';

  int get currentTabIndex => _currentTabIndex;

  GlobalKey<ScaffoldState>? scaffoldKey;

  MainViewModel() {
    AdHelper adHelper = AdHelper()..loadAd();
    _appLifecycleReactor = AppLifecycleReactor(
      adHelper: adHelper,
    );
  }

  void init() {
    Future.microtask(() {
      final context = scaffoldKey!.currentState!.context;
      final locale = Localizations.localeOf(context).toLanguageTag();
      if (_locale == locale) return;
      _locale = locale;
      _appLifecycleReactor.listenToAppStateChanges();
      _listenConnectivity();
      _initNotification();
    });
  }

  void _initNotification() {
    final context = scaffoldKey!.currentState!.context;
    ForegroundTask.startForegroundTask(
      context,
    ); //TODO delete this on release
    _timer?.cancel();
    _timer = Timer.periodic(//ForegroundTask.durationUpdate,
      const Duration(seconds: 30),
      (timer) {
        ForegroundTask.startForegroundTask(context);
      },
    );
    _listenNotifications(context);
    AppNotificationManager.showScheduledNotificationDaily(
        id: 1,
        title: S.of(context).nothing_to_see,
        body: S.of(context).see_what_others_watching_on_search_page,
        payload: '',
        time: const Time(11));
    AppNotificationManager.showScheduledNotificationDaily(
        id: 2,
        title: S.of(context).cannot_sleep,
        body: S.of(context).see_what_movies_are_out_today,
        payload: '',
        time: const Time(0, 25));
  }

  void _listenConnectivity() {
    final context = scaffoldKey!.currentState!.context;
    _appConnectivityReactor?.dispose();
    _appConnectivityReactor = AppConnectivityReactor(context: context);
    _appConnectivityReactor?.listenToConnectivityChanged(
        onConnectionYes: () => DialogWidget.hideSnackBar(context),
        onConnectionNo: () {
          try {
            _errorMessge = S.of(context).no_internet_connection;
          } catch (e) {}
          DialogWidget.showSnackBar(
            context: context,
            text: _errorMessge,
            backgroundColor: AppColors.colorError,
            duration: const Duration(hours: 24),
          );
        });
  }

  void _listenNotifications(BuildContext context) {
    _notificationStreamSubscription?.cancel();
    _notificationStreamSubscription =
        AppNotificationManager.onNotification.listen((payload) {
      if (payload != null) {
        final id = payload.substring(
          payload.indexOf('-') + 1,
          payload.length,
        );

        if (payload.contains('movie')) {
          Navigator.of(context).pushNamed(
            Screens.movieDetails,
            arguments: int.parse(id),
          );
        } else if (payload.contains('tv')) {
          Navigator.of(context).pushNamed(
            Screens.tvShowDetails,
            arguments: int.parse(id),
          );
        } else if (payload.contains('person')) {
          Navigator.of(context).pushNamed(
            Screens.actorDetails,
            arguments: int.parse(id),
          );
        }
      }
    });
  }

  void showAdIfAvailable() async {
    _appLifecycleReactor.adHelper.showAdIfAvailable();
  }

  void setCurrentTabIndex(int value, BuildContext context) {
    showAdIfAvailable();
    _currentTabIndex = value;
    notifyListeners();
  }

  Future<bool> onBackPressed(BuildContext context) {
    DateTime now = DateTime.now();
    const duration = Duration(seconds: 2);
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > duration) {
      _currentBackPressTime = now;
      DialogWidget.showSnackBar(
        context: context,
        text: S.of(context).press_again_to_exit_app,
        duration: duration,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void dispose() {
    _appConnectivityReactor?.dispose();
    _appConnectivityReactor = null;
    _notificationStreamSubscription?.cancel();
    _notificationStreamSubscription = null;
    _timer?.cancel();
    super.dispose();
  }
}
