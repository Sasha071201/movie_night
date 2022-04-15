import 'package:shared_preferences/shared_preferences.dart';

class DateUpdateDataProviderKeys {
  DateUpdateDataProviderKeys._();

  static const neededTimeKey = 'needed_time_key';
}

class DateUpdateDataProvider {
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<DateTime?> getNeededTime() async {
    final dateTime = await _getTime(DateUpdateDataProviderKeys.neededTimeKey);
    return dateTime;
  }

  Future<void> saveNeededTime(DateTime dateTime) async {
    await _saveTime(dateTime, DateUpdateDataProviderKeys.neededTimeKey);
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
