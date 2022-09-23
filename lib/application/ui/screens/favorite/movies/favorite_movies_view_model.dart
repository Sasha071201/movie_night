import 'dart:async';
import 'dart:developer';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/api_client/api_client_exception.dart';
import 'package:movie_night/application/domain/connectivity/app_connectivity_reactor.dart';
import 'package:movie_night/application/ui/screens/view_favorite/view_favorite_view_model.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/widgets/dialog_widget.dart';

import '../../../../../generated/l10n.dart';
import '../../../../repository/account_repository.dart';
import '../../../widgets/vertical_widgets_with_header/movies_with_header_widget.dart';

class FavoriteMoviesState {
  List<MovieWithHeaderData> moviesWithHeader = [];
  bool isLoadingProgress = false;
  bool isLoaded = false;
}

class FavoriteMoviesViewModel extends ChangeNotifier {
  final _repository = AccountRepository();
  final state = FavoriteMoviesState();
  String _locale = '';
  late BuildContext _context;
  StreamSubscription? _streamSubscription;
  final _controllerNeedUpdate = StreamController<bool>();
  StreamSubscription? _streamNeedUpdateSubscription;
  AppConnectivityReactor? _appConnectivityReactor;
  Timer? _timer;
  String? userId;

  bool isAllowShowFavoriteMovies = false;
  bool isAllowShowFavoriteAndNotWatchedMovies = false;
  bool isAllowShowWatchedMovies = false;

  Future<void> _initIsAllowShow() async {
    await Future.wait<void>([
      _isAllowShowFavoriteMovies(),
      _isAllowShowFavoriteAndNotWatchedMovies(),
      _isAllowShowWatchedMovies(),
    ]);
    notifyListeners();
  }

  Future<void> _isAllowShowFavoriteMovies() async {
    final newIsAllowShowFavoriteMovies = await _repository.isAllowShowFavoriteMovies(userId);
    if (newIsAllowShowFavoriteMovies != null) {
      isAllowShowFavoriteMovies = newIsAllowShowFavoriteMovies;
      notifyListeners();
    }
  }

  Future<void> _isAllowShowFavoriteAndNotWatchedMovies() async {
    final newIsAllowShowFavoriteAndNotWatchedMovies =
        await _repository.isAllowShowFavoriteAndNotWatchedMovies(userId);
    if (newIsAllowShowFavoriteAndNotWatchedMovies != null) {
      isAllowShowFavoriteAndNotWatchedMovies = newIsAllowShowFavoriteAndNotWatchedMovies;
      notifyListeners();
    }
  }

  Future<void> _isAllowShowWatchedMovies() async {
    final newIsAllowShowWatchedMovies = await _repository.isAllowShowWatchedMovies(userId);
    if (newIsAllowShowWatchedMovies != null) {
      isAllowShowWatchedMovies = newIsAllowShowWatchedMovies;
      notifyListeners();
    }
  }

  FavoriteMoviesViewModel(BuildContext context, [this.userId]) {
    _context = context;
    _listenNeedUpdate();
    _listenChanges();
    _listenConnectivity(
      context: _context,
      onConnectionYes: _refresh,
    );
  }

  Future<void> setupLocale(BuildContext context) async {
    _context = context;
    final locale = Localizations.localeOf(_context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _controllerNeedUpdate.add(true);
  }

  void _listenConnectivity({
    required BuildContext context,
    required Function() onConnectionYes,
  }) {
    _appConnectivityReactor?.dispose();
    _appConnectivityReactor = AppConnectivityReactor(context: context);
    _appConnectivityReactor?.listenToConnectivityChanged(
      onConnectionYes: onConnectionYes,
      onConnectionNo: () {},
    );
  }

  void _listenChanges() {
    _streamSubscription?.cancel();
    _streamSubscription = StreamGroup.merge([
      _repository.favoriteStream(),
      _repository.watchedStream(),
    ]).listen((event) {
      _refresh();
    });
  }

  void _listenNeedUpdate() {
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription = _controllerNeedUpdate.stream.listen((needUpdate) {
      if (needUpdate) _refresh();
    });
  }

  Future<void> _refresh() async {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 1000), () async {
      state.isLoaded = false;
      notifyListeners();
      if (userId != null) {
        await _initIsAllowShow();
      }
      await resetAll();
      state.isLoaded = true;
      notifyListeners();
    });
  }

  Future<void> resetAll() async {
    state.moviesWithHeader.clear();
    await _loadMovies();
  }

  Future<void> _loadMovies() async {
    if (state.isLoadingProgress) return;
    state.isLoadingProgress = true;

    try {
      await _fillMoviesWithHeader();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    state.isLoadingProgress = false;
    notifyListeners();
  }

  Future<void> _fillMoviesWithHeader() async {
    final tempMovies = <MovieWithHeaderData>[];
    try {
      if (userId == null || isAllowShowFavoriteMovies) {
        final moviesFavoriteResult = await _repository.fetchFavoriteMovies(_locale, 10, userId);
        if (moviesFavoriteResult.isNotEmpty) {
          tempMovies.add(MovieWithHeaderData(
            title: S.of(_context).favorite,
            list: moviesFavoriteResult,
            viewFavoriteType: ViewFavoriteType.favorite,
          ));
        }
      }
      if (userId == null || isAllowShowFavoriteAndNotWatchedMovies) {
        final moviesFavoriteAndNotWatchedResult =
            await _repository.fetchFavoriteAndNotWatchedMovies(_locale, 10, userId);
        if (moviesFavoriteAndNotWatchedResult.isNotEmpty) {
          tempMovies.add(MovieWithHeaderData(
            title: S.of(_context).favorite_and_not_watched,
            list: moviesFavoriteAndNotWatchedResult,
            viewFavoriteType: ViewFavoriteType.favoriteAndNotWatched,
          ));
        }
      }
      if (userId == null || isAllowShowWatchedMovies) {
        final moviesWatchedResult = await _repository.fetchWatchedMovies(_locale, 10, userId);
        if (moviesWatchedResult.isNotEmpty) {
          tempMovies.add(MovieWithHeaderData(
            title: S.of(_context).watched,
            list: moviesWatchedResult,
            viewFavoriteType: ViewFavoriteType.watched,
          ));
        }
      }
    } on ApiClientException catch (e) {
      if (e.solution == ExceptionSolution.update) {
        _controllerNeedUpdate.add(true);
      } else if (e.solution == ExceptionSolution.showMessage) {
        DialogWidget.showSnackBar(
          context: _context,
          text: e.asString(_context),
          backgroundColor: AppColors.colorError,
        );
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    final newMovies = List<MovieWithHeaderData>.from(state.moviesWithHeader);
    newMovies.addAll(tempMovies);
    state.moviesWithHeader = newMovies;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _streamSubscription?.cancel();
    _streamSubscription = null;
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription = null;
    _appConnectivityReactor?.dispose();
    _appConnectivityReactor = null;
    super.dispose();
  }
}
