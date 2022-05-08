import 'package:in_app_review/in_app_review.dart';

import '../data_providers/data_provider.dart';

class AppReview {
  final _inAppReview = InAppReview.instance;

  static const Duration duration = Duration(hours: 12);

  Future<void> showReview() async {
    final dataProvider = DataProvider();
    final showReview = await dataProvider.getShowReview();
    final pastime = await dataProvider.getPastime();
    final pastTime = DateTime.now();
    if (showReview != null || showReview == true) return;
    if (pastime == null) {
      final newPastime = DateTime.now().add(duration);
      await dataProvider.savePastime(newPastime);
      return;
    }
    if (pastTime.compareTo(pastime) < 0) return;
    if (await _inAppReview.isAvailable()) {
      _inAppReview.requestReview().then((value) {
        dataProvider.setShowReview(true);
      });
    }
  }
}
