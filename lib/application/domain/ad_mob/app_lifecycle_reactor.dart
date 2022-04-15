import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movie_night/application/domain/ad_mob/ad_helper.dart';

/// Listens for app foreground events and shows app open ads.
class AppLifecycleReactor {
  final AdHelper adHelper;

  AppLifecycleReactor({required this.adHelper});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    if (appState == AppState.foreground) {
      adHelper.showAdIfAvailable();
    }
  }
}
