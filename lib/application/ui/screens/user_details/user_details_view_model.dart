import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

import 'package:movie_night/application/domain/entities/user.dart';
import 'package:movie_night/application/repository/account_repository.dart';

class UserDetailsViewModel extends ChangeNotifier {
  final _accountRepository = AccountRepository();

  String _locale = '';
  bool isLoadingProgress = false;
  bool isFavorite = false;
  late Stream<User> user;
  String userId;
  String? userName;

  UserDetailsViewModel(this.userId) {
    user = _accountRepository.userStream(userId);
  }

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    await _isFavorite();
  }

  Future<void> favoriteUser() async {
    _accountRepository.favoriteUser(userId);
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> _isFavorite() async {
    try {
      final newIsFavorite = await _accountRepository.isFavoriteUser(userId);
      if (newIsFavorite != null) {
        isFavorite = newIsFavorite;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
