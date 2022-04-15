import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movie_night/application/configuration/ad_mob_configuration.dart';

class AdHelper {
  InterstitialAd? _interstitialAd;
  bool _isAdReady = false;

  /// Maximum duration allowed between loading and showing the ad.
  final Duration maxCacheDuration = const Duration(hours: 4);

  /// Keep track of load time so we don't show an expired ad.
  DateTime? _appOpenLoadTime;

  String _rewardedAdUnitId() {
    if (Platform.isAndroid) {
      return AdMobConfiguration.rewardedAdUnitIdAndroidTest;
    } else {
      throw Exception('Unknown platform for rewardedAdUnitId');
    }
  }

  void loadAd() {
    // InterstitialAd.load(
    //   adUnitId: _rewardedAdUnitId(),
    //   request: const AdRequest(),
    //   adLoadCallback: InterstitialAdLoadCallback(
    //     onAdLoaded: (ad) {
    //       _appOpenLoadTime = DateTime.now();
    //       _interstitialAd = ad;
    //     },
    //     onAdFailedToLoad: (error) {
    //       print('Ошибка загрузить рекламу: $error');
    //       // Handle the error.
    //     },
    //   ),
    // );
  }

  bool get isAdAvailable => _interstitialAd != null;

  void showAdIfAvailable() {
    // if (!isAdAvailable) {
    //   print('Попытка показать рекламу до того как разрешили');
    //   loadAd();
    //   return;
    // }
    // if (_isAdReady) {
    //   print('Попытка показать рекламу когда она уже показана');
    //   return;
    // }
    // if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
    //   print('Долго ждал. Загружаем другую рекламу');
    //   _interstitialAd!.dispose();
    //   _interstitialAd = null;
    //   loadAd();
    //   return;
    // }
    // // Set the fullScreenContentCallback and show the ad.
    // _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
    //   onAdShowedFullScreenContent: (ad) {
    //     _isAdReady = true;
    //     print('$ad полностью показал рекламу');
    //   },
    //   onAdFailedToShowFullScreenContent: (ad, error) {
    //     print('$ad ошибка показать на весь экран: $error');
    //     _isAdReady = false;
    //     ad.dispose();
    //     _interstitialAd = null;
    //   },
    //   onAdDismissedFullScreenContent: (ad) {
    //     print('$ad скрыл рекламу');
    //     _isAdReady = false;
    //     ad.dispose();
    //     _interstitialAd = null;
    //     loadAd();
    //   },
    // );
    // _interstitialAd!.show();
  }
}
