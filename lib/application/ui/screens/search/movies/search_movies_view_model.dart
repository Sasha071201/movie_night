import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/screens/view_movies/view_movies_view_model.dart';

import '../../../../../generated/l10n.dart';
import '../../../../domain/api_client/api_client_exception.dart';
import '../../../../domain/connectivity/app_connectivity_reactor.dart';
import '../../../../domain/entities/movie/movie_genres.dart';
import '../../../../repository/movie_repository.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/dialog_widget.dart';
import '../../../widgets/vertical_widgets_with_header/movies_with_header_widget.dart';

class SearchMoviesState {
  List<MovieWithHeaderData> moviesWithHeader = [];
  List<MovieWithHeaderData> moviesWithGenres = [];
  bool isLoadingProgress = false;
}

class SearchMoviesViewModel extends ChangeNotifier {
  AppConnectivityReactor? _appConnectivityReactor;
  final _repository = MovieRepository();
  final state = SearchMoviesState();
  bool _initialCategorySetup = false;
  late BuildContext _context;
  String _locale = '';
  Timer? _timer;

  final _controllerNeedUpdate = StreamController<bool>();
  StreamSubscription? _streamNeedUpdateSubscription;

  SearchMoviesViewModel() {
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
        state.moviesWithHeader.clear();
        state.moviesWithGenres.clear();
        await _loadMovies();
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
          state.moviesWithHeader.clear();
          state.moviesWithGenres.clear();
          await _loadMovies();
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

  Future<void> _loadMovies() async {
    if (state.isLoadingProgress) return;
    state.isLoadingProgress = true;
    notifyListeners();

    try {
      if (_initialCategorySetup) {
        await _fillMoviesWithGenre(rawLength: 4);
      } else {
        await _fillMoviesWithGenre(rawLength: 4);
        await _fillMoviesWithHeader();
      }
    } on ApiClientException catch (e) {
      _controllerNeedUpdate.add(true);
      DialogWidget.showSnackBar(
        context: _context,
        text: e.asString(_context),
        backgroundColor: AppColors.colorError,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    state.isLoadingProgress = false;
    notifyListeners();
  }

  Future<void> _fillMoviesWithHeader({int page = 1}) async {
    final tempMovies = <MovieWithHeaderData>[];
    final moviesNowPlayingResponse = await _repository.fetchNowPlayingMovies(
      page: page,
      locale: _locale,
    );
    final moviesPopularResponse = await _repository.fetchPopularMovies(
      page: page,
      locale: _locale,
    );
    final moviesTopRatedResponse = await _repository.fetchTopRatedMovies(
      page: page,
      locale: _locale,
    );
    tempMovies.add(MovieWithHeaderData(
      title: S.of(_context).now_playing,
      list: moviesNowPlayingResponse.results,
      viewMediaType: ViewMediaType.nowPlaying,
      movieId: 0,
    ));
    tempMovies.add(MovieWithHeaderData(
      title: S.of(_context).popular,
      list: moviesPopularResponse.results,
      viewMediaType: ViewMediaType.popular,
      movieId: 0,
    ));
    tempMovies.add(MovieWithHeaderData(
      title: S.of(_context).top_rated,
      list: moviesTopRatedResponse.results,
      viewMediaType: ViewMediaType.topRated,
      movieId: 0,
    ));
    final newMovies = List<MovieWithHeaderData>.from(state.moviesWithHeader);
    newMovies.addAll(tempMovies);
    state.moviesWithHeader = newMovies;
    _initialCategorySetup = true;
  }

  Future<void> _fillMoviesWithGenre(
      {int page = 1, required int rawLength}) async {
    final tempMovies = <MovieWithHeaderData>[];
    final difference =
        MovieGenres.values.length - state.moviesWithGenres.length;
    final length = difference < rawLength ? difference : rawLength;
    for (var i = 0; i < length; i++) {
      final tempGenres = tempMovies.map((movie) => movie.movieGenres).toList();
      final readyGenres =
          state.moviesWithGenres.map((movie) => movie.movieGenres).toList();
      MovieGenres genre = getRandomGenre();
      while (tempGenres.contains(genre) || readyGenres.contains(genre)) {
        genre = getRandomGenre();
      }
      final discoveryMoviesByGenre = await _repository.fetchMovies(
        page: page,
        locale: _locale,
        withGenres: "${genre.asId()}",
      );
      final moviesByGenre = discoveryMoviesByGenre.results;
      tempMovies.add(MovieWithHeaderData(
        title: genre.asString(_context),
        list: moviesByGenre,
        movieGenres: genre,
      ));
    }
    final newMovies = List<MovieWithHeaderData>.from(state.moviesWithGenres);
    newMovies.addAll(tempMovies);
    state.moviesWithGenres = newMovies;
  }

  void showedCategoryAtIndex({
    required BuildContext context,
    required int index,
  }) {
    if (state.moviesWithGenres.isEmpty ||
        state.moviesWithGenres.length == MovieGenres.values.length) return;
    if (index < state.moviesWithGenres.length - 1) return;
    _listenConnectivity(
      context: context,
      onConnectionYes: _loadMovies,
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
