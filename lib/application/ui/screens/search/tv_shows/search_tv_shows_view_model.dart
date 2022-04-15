import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../domain/api_client/api_client_exception.dart';
import '../../../../domain/connectivity/app_connectivity_reactor.dart';
import '../../../../domain/entities/tv_shows/tv_show_genres.dart';
import '../../../../repository/tv_show_repository.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/dialog_widget.dart';
import '../../../widgets/vertical_widgets_with_header/tv_shows_with_header_widget.dart';
import '../../view_movies/view_movies_view_model.dart';

class SearchTvShowState {
  List<TvShowWithHeaderData> tvShowsWithHeader = [];
  List<TvShowWithHeaderData> tvShowsWithGenres = [];
  bool isLoadingProgress = false;
}

class SearchTvShowsViewModel extends ChangeNotifier {
  AppConnectivityReactor? _appConnectivityReactor;
  final _repository = TvShowRepository();
  final state = SearchTvShowState();
  bool _initialCategorySetup = false;
  late BuildContext _context;
  String _locale = '';
  Timer? _timer;

  final _controllerNeedUpdate = StreamController<bool>();
  StreamSubscription? _streamNeedUpdateSubscription;

  SearchTvShowsViewModel() {
    _listenNeedUpdate();
  }

  Future<void> setupLocale(BuildContext context) async {
    _context = context;
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _listenConnectivity(
      context: context,
      onConnectionYes: () async {
        _initialCategorySetup = false;
        state.tvShowsWithHeader.clear();
        state.tvShowsWithGenres.clear();
        await _loadTvShows();
      },
    );
  }

  void _listenNeedUpdate() {
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription =
        _controllerNeedUpdate.stream.listen((needUpdate) {
      if (needUpdate) {
        _timer?.cancel();
        _timer = Timer(const Duration(seconds: 10), () async {
          _initialCategorySetup = false;
          state.tvShowsWithHeader.clear();
          state.tvShowsWithGenres.clear();
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

  Future<void> _loadTvShows() async {
    if (state.isLoadingProgress) return;
    state.isLoadingProgress = true;
    notifyListeners();

    try {
      if (_initialCategorySetup) {
        await _fillTvShowsWithGenre(rawLength: 4);
      } else {
        await _fillTvShowsWithGenre(rawLength: 4);
        await _fillTvShowsWithHeader();
      }
    } on ApiClientException catch (e) {
      _controllerNeedUpdate.add(true);
      DialogWidget.showSnackBar(
        context: _context,
        text: e.asString(_context),
        backgroundColor: AppColors.colorError,
      );
    } catch (e) {
      print(e);
    }
    state.isLoadingProgress = false;
    notifyListeners();
  }

  Future<void> _fillTvShowsWithHeader({int page = 1}) async {
    final tempTvShows = <TvShowWithHeaderData>[];
    final tvShowsNowPlayingResponse = await _repository.fetchTvShowOnTheAir(
      page: page,
      locale: _locale,
    );
    final tvShowsPopularResponse = await _repository.fetchPopularTvShow(
      page: page,
      locale: _locale,
    );
    final tvShowsTopRatedResponse = await _repository.fetchTopRatedTvShow(
      page: page,
      locale: _locale,
    );
    tempTvShows.add(TvShowWithHeaderData(
      title: S.of(_context).now_playing,
      list: tvShowsNowPlayingResponse.results,
      viewMediaType: ViewMediaType.nowPlaying,
      tvShowId: 0,
    ));
    tempTvShows.add(TvShowWithHeaderData(
      title: S.of(_context).popular,
      list: tvShowsPopularResponse.results,
      viewMediaType: ViewMediaType.popular,
      tvShowId: 0,
    ));
    tempTvShows.add(TvShowWithHeaderData(
      title: S.of(_context).top_rated,
      list: tvShowsTopRatedResponse.results,
      viewMediaType: ViewMediaType.topRated,
      tvShowId: 0,
    ));
    final newMovies = List<TvShowWithHeaderData>.from(state.tvShowsWithHeader);
    newMovies.addAll(tempTvShows);
    state.tvShowsWithHeader = newMovies;
    _initialCategorySetup = true;
  }

  Future<void> _fillTvShowsWithGenre(
      {int page = 1, required int rawLength}) async {
    final tempTvShows = <TvShowWithHeaderData>[];
    final difference =
        TvShowGenres.values.length - state.tvShowsWithGenres.length;
    final length = difference < rawLength ? difference : rawLength;
    for (var i = 0; i < length; i++) {
      final tempGenres =
          tempTvShows.map((movie) => movie.tvShowGenres).toList();
      final readyGenres =
          state.tvShowsWithGenres.map((movie) => movie.tvShowGenres).toList();
      TvShowGenres genre = getRandomGenre();
      while (tempGenres.contains(genre) || readyGenres.contains(genre)) {
        genre = getRandomGenre();
      }
      final discoveryMoviesByGenre = await _repository.fetchTvShows(
        page: page,
        locale: _locale,
        withGenres: "${genre.asId()}",
      );
      final moviesByGenre = discoveryMoviesByGenre.results;
      tempTvShows.add(TvShowWithHeaderData(
        title: genre.asString(_context),
        list: moviesByGenre,
        tvShowGenres: genre,
      ));
    }
    final newMovies = List<TvShowWithHeaderData>.from(state.tvShowsWithGenres);
    newMovies.addAll(tempTvShows);
    state.tvShowsWithGenres = newMovies;
  }

  void showedCategoryAtIndex({
    required BuildContext context,
    required int index,
  }) {
    if (state.tvShowsWithGenres.isEmpty ||
        state.tvShowsWithGenres.length == TvShowGenres.values.length) return;
    if (index < state.tvShowsWithGenres.length - 1) return;
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
