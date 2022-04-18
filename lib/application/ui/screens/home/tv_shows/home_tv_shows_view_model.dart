import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show_genres.dart';
import 'package:movie_night/application/repository/tv_show_repository.dart';

import '../../../../domain/api_client/api_client_exception.dart';
import '../../../../domain/connectivity/app_connectivity_reactor.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/dialog_widget.dart';
import '../../../widgets/vertical_widgets_with_header/tv_shows_with_header_widget.dart';

class HomeTvShowsState {
  int currentHeaderTvShowIndex = 0;
  List<TvShow> headerTvShows = [];
  List<TvShowWithHeaderData> tvShowsWithHeader = [];
  bool isLoadingProgress = false;
}

class HomeTvShowsViewModel extends ChangeNotifier {
  AppConnectivityReactor? _appConnectivityReactor;
  final _repository = TvShowRepository();
  final state = HomeTvShowsState();
  late BuildContext _context;
  String _locale = '';
  Timer? _timer;

  final _controllerNeedUpdate = StreamController<bool>();
  StreamSubscription? _streamNeedUpdateSubscription;

  void onIndexChanged(int index) {
    state.currentHeaderTvShowIndex = index;
    notifyListeners();
  }

  HomeTvShowsViewModel() {
    _listenNeedUpdate();
  }

  Future<void> setupLocale(BuildContext context) async {
    _context = context;
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _listenConnectivity(
        context: _context,
        onConnectionYes: () async {
          state.headerTvShows.clear();
          state.tvShowsWithHeader.clear();
          await _loadHeaderTvShows();
          await _loadTvShows();
        });
  }

  void _listenNeedUpdate() {
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription =
        _controllerNeedUpdate.stream.listen((needUpdate) {
      if (needUpdate) {
        _timer?.cancel();
        _timer = Timer(const Duration(seconds: 10), () async {
          state.headerTvShows.clear();
          state.tvShowsWithHeader.clear();
          await _loadHeaderTvShows();
          await _loadTvShows();
        });
      }
    });
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

  Future<void> _loadHeaderTvShows() async {
    try {
      final airingTodayTvShows =
          await _repository.fetchAiringTodayTvShows(locale: _locale, page: 1);
      airingTodayTvShows.results
          .removeWhere((element) => element.backdropPath == null);
      state.headerTvShows = airingTodayTvShows.results;
      notifyListeners();
    } on ApiClientException catch (e) {
      DialogWidget.showSnackBar(
        context: _context,
        text: e.asString(_context),
        backgroundColor: AppColors.colorError,
      );
    } catch (e) {
    }
  }

  Future<void> _loadTvShows() async {
    if (state.isLoadingProgress) return;
    state.isLoadingProgress = true;
    notifyListeners();

    try {
      await _fillMapTvShows(rawLength: 4);
    } on ApiClientException catch (e) {
      _controllerNeedUpdate.add(true);
      DialogWidget.showSnackBar(
        context: _context,
        text: e.asString(_context),
        backgroundColor: AppColors.colorError,
      );
    } catch (e) {
    }
    state.isLoadingProgress = false;
    notifyListeners();
  }

  Future<void> _fillMapTvShows({int page = 1, required int rawLength}) async {
    final tempTvShow = <TvShowWithHeaderData>[];
    final difference =
        TvShowGenres.values.length - state.tvShowsWithHeader.length;
    final length = difference < rawLength ? difference : rawLength;
    for (var i = 0; i < length; i++) {
      final tempGenres =
          tempTvShow.map((tvShow) => tvShow.tvShowGenres).toList();
      final readyGenres =
          state.tvShowsWithHeader.map((tvShow) => tvShow.tvShowGenres).toList();
      TvShowGenres genre = getRandomGenre();
      while (tempGenres.contains(genre) || readyGenres.contains(genre)) {
        genre = getRandomGenre();
      }
      final discoveryTvShowsByGenre = await _repository.fetchTvShows(
        page: page,
        locale: _locale,
        withGenres: '${genre.asId()}',
      );
      final tvShowsByGenre = discoveryTvShowsByGenre.results;
      tempTvShow.add(TvShowWithHeaderData(
        title: genre.asString(_context),
        list: tvShowsByGenre,
        tvShowGenres: genre,
      ));
    }
    final newMapTvShows =
        List<TvShowWithHeaderData>.from(state.tvShowsWithHeader);
    newMapTvShows.addAll(tempTvShow);
    state.tvShowsWithHeader = newMapTvShows;
  }

  void showedCategoryAtIndex({
    required BuildContext context,
    required int index,
  }) {
    if (state.tvShowsWithHeader.isEmpty ||
        state.tvShowsWithHeader.length == TvShowGenres.values.length) return;
    if (index < state.tvShowsWithHeader.length - 1) return;
    _listenConnectivity(
      context: context,
      onConnectionYes: _loadTvShows,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription = null;
    _appConnectivityReactor?.dispose();
    _appConnectivityReactor = null;
    super.dispose();
  }
}
