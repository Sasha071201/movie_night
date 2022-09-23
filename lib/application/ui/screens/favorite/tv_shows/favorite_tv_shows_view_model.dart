import 'dart:async';
import 'dart:developer';

import 'package:async/async.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../domain/api_client/api_client_exception.dart';
import '../../../../domain/connectivity/app_connectivity_reactor.dart';
import '../../../../repository/account_repository.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/dialog_widget.dart';
import '../../../widgets/vertical_widgets_with_header/tv_shows_with_header_widget.dart';
import '../../view_favorite/view_favorite_view_model.dart';

class FavoriteTvShowsState {
  List<TvShowWithHeaderData> tvShowsWithHeader = [];
  bool isLoadingProgress = false;
  bool isLoaded = false;
}

class FavoriteTvShowsViewModel extends ChangeNotifier {
  final _repository = AccountRepository();
  final state = FavoriteTvShowsState();
  String _locale = '';
  late BuildContext _context;
  StreamSubscription? _streamSubscription;
  final _controllerNeedUpdate = StreamController<bool>();
  StreamSubscription? _streamNeedUpdateSubscription;
  AppConnectivityReactor? _appConnectivityReactor;
  Timer? _timer;
  String? userId;

  bool isAllowShowFavoriteTvShows = false;
  bool isAllowShowFavoriteAndNotWatchedTvShows = false;
  bool isAllowShowWatchedTvShows = false;

  Future<void> _initIsAllowShow() async {
    await Future.wait<void>([
      _isAllowShowFavoriteTvShows(),
      _isAllowShowFavoriteAndNotWatchedTvShows(),
      _isAllowShowWatchedTvShows(),
    ]);
    notifyListeners();
  }

  Future<void> _isAllowShowFavoriteTvShows() async {
    final newIsallowShowFavoriteTvShows = await _repository.isAllowShowFavoriteTvShows(userId);
    if (newIsallowShowFavoriteTvShows != null) {
      isAllowShowFavoriteTvShows = newIsallowShowFavoriteTvShows;
      notifyListeners();
    }
  }

  Future<void> _isAllowShowFavoriteAndNotWatchedTvShows() async {
    final newIsAllowShowFavoriteAndNotWatchedTvShows =
        await _repository.isAllowShowFavoriteAndNotWatchedTvShows(userId);
    if (newIsAllowShowFavoriteAndNotWatchedTvShows != null) {
      isAllowShowFavoriteAndNotWatchedTvShows = newIsAllowShowFavoriteAndNotWatchedTvShows;
      notifyListeners();
    }
  }

  Future<void> _isAllowShowWatchedTvShows() async {
    final newIsAllowShowWatchedTvShows = await _repository.isAllowShowWatchedTvShows(userId);
    if (newIsAllowShowWatchedTvShows != null) {
      isAllowShowWatchedTvShows = newIsAllowShowWatchedTvShows;
      notifyListeners();
    }
  }

  FavoriteTvShowsViewModel(BuildContext context, [this.userId]) {
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

  void _listenNeedUpdate() {
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription = _controllerNeedUpdate.stream.listen((needUpdate) {
      if (needUpdate) _refresh();
    });
  }

  void _listenChanges() {
    _streamSubscription?.cancel();
    _streamSubscription = StreamGroup.merge([
      _repository.favoriteStream(),
      _repository.watchedStream(),
    ]).listen((event) {
      _timer?.cancel();
      _timer = Timer(const Duration(milliseconds: 1000), () {
        _refresh();
      });
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
    state.tvShowsWithHeader.clear();
    await _loadTvShows();
  }

  Future<void> _loadTvShows() async {
    if (state.isLoadingProgress) return;
    state.isLoadingProgress = true;

    try {
      await _fillTvShowsWithHeader();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    state.isLoadingProgress = false;
    notifyListeners();
  }

  Future<void> _fillTvShowsWithHeader() async {
    final tempTvShows = <TvShowWithHeaderData>[];
    try {
      if (userId == null || isAllowShowFavoriteTvShows) {
        final tvShowsFavoriteResult = await _repository.fetchFavoriteTvShows(_locale, 10, userId);
        if (tvShowsFavoriteResult.isNotEmpty) {
          tempTvShows.add(TvShowWithHeaderData(
            title: S.of(_context).favorite,
            list: tvShowsFavoriteResult,
            viewFavoriteType: ViewFavoriteType.favorite,
          ));
        }
      }
      if (userId == null || isAllowShowFavoriteAndNotWatchedTvShows) {
        final tvShowsFavoriteAndNotWatchedResult =
            await _repository.fetchFavoriteAndNotWatchedTvShows(_locale, 10, userId);
        if (tvShowsFavoriteAndNotWatchedResult.isNotEmpty) {
          tempTvShows.add(TvShowWithHeaderData(
            title: S.of(_context).favorite_and_not_watched,
            list: tvShowsFavoriteAndNotWatchedResult,
            viewFavoriteType: ViewFavoriteType.favoriteAndNotWatched,
          ));
        }
      }
      if (userId == null || isAllowShowWatchedTvShows) {
        final tvShowsWatchedResult = await _repository.fetchWatchedTvShows(_locale, 10, userId);
        if (tvShowsWatchedResult.isNotEmpty) {
          tempTvShows.add(TvShowWithHeaderData(
            title: S.of(_context).watched,
            list: tvShowsWatchedResult,
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
    final newMovies = List<TvShowWithHeaderData>.from(state.tvShowsWithHeader);
    newMovies.addAll(tempTvShows);
    state.tvShowsWithHeader = newMovies;
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
