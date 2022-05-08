import 'package:shared_preferences/shared_preferences.dart';

class DataProviderKeys {
  DataProviderKeys._();

  static const showReviewKey = 'show_review_key';
  static const pastimeKey = 'pastime_key';
  static const neededTimeKey = 'needed_time_key';
}

class DataProvider {
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<DateTime?> getNeededTime() async {
    final dateTime = await _getTime(DataProviderKeys.neededTimeKey);
    return dateTime;
  }

  Future<void> saveNeededTime(DateTime dateTime) async {
    await _saveTime(dateTime, DataProviderKeys.neededTimeKey);
  }

  Future<bool?> getShowReview() async {
    return (await _sharedPreferences).getBool(DataProviderKeys.showReviewKey);
  }

  Future<void> setShowReview(bool showReview) async {
    (await _sharedPreferences)
        .setBool(DataProviderKeys.showReviewKey, showReview);
  }

  Future<DateTime?> getPastime() async {
    final dateTime = await _getTime(DataProviderKeys.pastimeKey);
    return dateTime;
  }

  Future<void> savePastime(DateTime dateTime) async {
    await _saveTime(dateTime, DataProviderKeys.pastimeKey);
  }

  Future<DateTime?> _getTime(String key) async {
    final timestamp = (await _sharedPreferences).getInt(key);
    final dateTime = timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp)
        : null;
    return dateTime;
  }

  Future<void> _saveTime(DateTime dateTime, String key) async {
    final timestamp = dateTime.millisecondsSinceEpoch;
    (await _sharedPreferences).setInt(key, timestamp);
  }
}
