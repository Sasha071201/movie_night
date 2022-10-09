import 'package:flutter/cupertino.dart';
import 'package:movie_night/application/repository/account_repository.dart';

class SettingsViewModel extends ChangeNotifier {
  final _accountRepository = AccountRepository();

  bool isAllowShowFavoriteMovies = false;
  bool isAllowShowFavoriteTvShows = false;
  bool isAllowShowFavoriteAndNotWatchedMovies = false;
  bool isAllowShowFavoriteAndNotWatchedTvShows = false;
  bool isAllowShowWatchedMovies = false;
  bool isAllowShowWatchedTvShows = false;
  bool isAllowShowFavoriteActors = false;

  Future<void> init() async {
    await Future.wait<void>([
      _isAllowShowFavoriteMovies(),
      _isAllowShowFavoriteTvShows(),
      _isAllowShowFavoriteAndNotWatchedMovies(),
      _isAllowShowFavoriteAndNotWatchedTvShows(),
      _isAllowShowWatchedMovies(),
      _isAllowShowWatchedTvShows(),
      _isAllowShowFavoriteActors(),
    ]);
    notifyListeners();
  }

  Future<void> allowShowFavoriteMovies() async {
    _accountRepository.allowShowFavoriteMovies();
    isAllowShowFavoriteMovies = !isAllowShowFavoriteMovies;
    notifyListeners();
  }

  Future<void> _isAllowShowFavoriteMovies() async {
    final newIsAllowShowFavoriteMovies = await _accountRepository.isAllowShowFavoriteMovies();
    if (newIsAllowShowFavoriteMovies != null) {
      isAllowShowFavoriteMovies = newIsAllowShowFavoriteMovies;
      notifyListeners();
    }
  }

  Future<void> allowShowFavoriteTvShows() async {
    _accountRepository.allowShowFavoriteTvShows();
    isAllowShowFavoriteTvShows = !isAllowShowFavoriteTvShows;
    notifyListeners();
  }

  Future<void> _isAllowShowFavoriteTvShows() async {
    final newIsallowShowFavoriteTvShows = await _accountRepository.isAllowShowFavoriteTvShows();
    if (newIsallowShowFavoriteTvShows != null) {
      isAllowShowFavoriteTvShows = newIsallowShowFavoriteTvShows;
      notifyListeners();
    }
  }

  Future<void> allowShowFavoriteAndNotWatchedMovies() async {
    _accountRepository.allowShowFavoriteAndNotWatchedMovies();
    isAllowShowFavoriteAndNotWatchedMovies = !isAllowShowFavoriteAndNotWatchedMovies;
    notifyListeners();
  }

  Future<void> _isAllowShowFavoriteAndNotWatchedMovies() async {
    final newIsAllowShowFavoriteAndNotWatchedMovies =
        await _accountRepository.isAllowShowFavoriteAndNotWatchedMovies();
    if (newIsAllowShowFavoriteAndNotWatchedMovies != null) {
      isAllowShowFavoriteAndNotWatchedMovies = newIsAllowShowFavoriteAndNotWatchedMovies;
      notifyListeners();
    }
  }

  Future<void> allowShowFavoriteAndNotWatchedTvShows() async {
    _accountRepository.allowShowFavoriteAndNotWatchedTvShows();
    isAllowShowFavoriteAndNotWatchedTvShows = !isAllowShowFavoriteAndNotWatchedTvShows;
    notifyListeners();
  }

  Future<void> _isAllowShowFavoriteAndNotWatchedTvShows() async {
    final newIsAllowShowFavoriteAndNotWatchedTvShows =
        await _accountRepository.isAllowShowFavoriteAndNotWatchedTvShows();
    if (newIsAllowShowFavoriteAndNotWatchedTvShows != null) {
      isAllowShowFavoriteAndNotWatchedTvShows = newIsAllowShowFavoriteAndNotWatchedTvShows;
      notifyListeners();
    }
  }

  Future<void> allowShowWatchedMovies() async {
    _accountRepository.allowShowWatchedMovies();
    isAllowShowWatchedMovies = !isAllowShowWatchedMovies;
    notifyListeners();
  }

  Future<void> _isAllowShowWatchedMovies() async {
    final newIsAllowShowWatchedMovies = await _accountRepository.isAllowShowWatchedMovies();
    if (newIsAllowShowWatchedMovies != null) {
      isAllowShowWatchedMovies = newIsAllowShowWatchedMovies;
      notifyListeners();
    }
  }

  Future<void> allowShowWatchedTvShows() async {
    _accountRepository.allowShowWatchedTvShows();
    isAllowShowWatchedTvShows = !isAllowShowWatchedTvShows;
    notifyListeners();
  }

  Future<void> _isAllowShowWatchedTvShows() async {
    final newIsAllowShowWatchedTvShows = await _accountRepository.isAllowShowWatchedTvShows();
    if (newIsAllowShowWatchedTvShows != null) {
      isAllowShowWatchedTvShows = newIsAllowShowWatchedTvShows;
      notifyListeners();
    }
  }

  Future<void> allowShowFavoriteActors() async {
    _accountRepository.allowShowFavoriteActors();
    isAllowShowFavoriteActors = !isAllowShowFavoriteActors;
    notifyListeners();
  }

  Future<void> _isAllowShowFavoriteActors() async {
    final newIsAllowShowFavoriteActors = await _accountRepository.isAllowShowFavoriteActors();
    if (newIsAllowShowFavoriteActors != null) {
      isAllowShowFavoriteActors = newIsAllowShowFavoriteActors;
      notifyListeners();
    }
  }
}
