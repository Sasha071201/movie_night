import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/api_client/api_client_exception.dart';
import 'package:movie_night/application/repository/movie_repository.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/widgets/dialog_widget.dart';
import 'package:movie_night/application/ui/widgets/vertical_widgets_with_header/movies_with_header_widget.dart';

import '../../../../domain/connectivity/app_connectivity_reactor.dart';
import '../../../../domain/entities/movie/movie.dart';
import '../../../../domain/entities/movie/movie_genres.dart';

class HomeMoviesState {
  int currentHeaderMovieIndex = 0;
  List<Movie> headerMovies = [];
  List<MovieWithHeaderData> moviesWithHeader = [];
  bool isLoadingProgress = false;
}

class HomeMoviesViewModel extends ChangeNotifier {
  AppConnectivityReactor? _appConnectivityReactor;
  final _repository = MovieRepository();
  final state = HomeMoviesState();
  String _locale = '';
  late BuildContext _context;
  Timer? _timer;

  final _controllerNeedUpdate = StreamController<bool>();
  StreamSubscription? _streamNeedUpdateSubscription;

  HomeMoviesViewModel() {
    _listenNeedUpdate();
  }

  void onIndexChanged(int index) {
    state.currentHeaderMovieIndex = index;
    notifyListeners();
  }

  Future<void> setupLocale(BuildContext context) async {
    _context = context;
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _listenConnectivity(onConnectionYes: () async {
      state.headerMovies.clear();
      state.moviesWithHeader.clear();
      await _loadHeaderMovies();
      await _loadMovies();
    });
  }

  void _listenNeedUpdate() {
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription =
        _controllerNeedUpdate.stream.listen((needUpdate) {
      if (needUpdate) {
        _timer?.cancel();
        _timer = Timer(const Duration(seconds: 10), () async {
          state.headerMovies.clear();
          state.moviesWithHeader.clear();
          await _loadHeaderMovies();
          await _loadMovies();
        });
      }
    });
  }

  void _listenConnectivity({
    required Function() onConnectionYes,
  }) {
    _appConnectivityReactor?.dispose();
    _appConnectivityReactor = AppConnectivityReactor(context: _context);
    _appConnectivityReactor?.listenToConnectivityChanged(
      onConnectionYes: onConnectionYes,
      onConnectionNo: () {},
    );
  }

  Future<void> _loadHeaderMovies() async {
    try {
      final moviesUpcoming =
          await _repository.fetchUpcomingMovies(locale: _locale);
      moviesUpcoming.results
          .removeWhere((element) => element.backdropPath == null);
      state.headerMovies = moviesUpcoming.results;
      notifyListeners();
    } on ApiClientException catch (e) {
      DialogWidget.showSnackBar(
        context: _context,
        text: e.asString(_context),
        backgroundColor: AppColors.colorError,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> _loadMovies() async {
    if (state.isLoadingProgress) return;
    state.isLoadingProgress = true;
    notifyListeners();

    try {
      await _fillMapMovies(rawLength: 4);
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

  Future<void> _fillMapMovies({int page = 1, required int rawLength}) async {
    final tempMovies = <MovieWithHeaderData>[];
    final difference =
        MovieGenres.values.length - state.moviesWithHeader.length;
    final length = difference < rawLength ? difference : rawLength;
    for (var i = 0; i < length; i++) {
      final tempGenres = tempMovies.map((movie) => movie.movieGenres).toList();
      final readyGenres =
          state.moviesWithHeader.map((movie) => movie.movieGenres).toList();
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
      tempMovies.add(
        MovieWithHeaderData(
          title: genre.asString(_context),
          list: moviesByGenre,
          movieGenres: genre,
        ),
      );
    }
    final newMovies = List<MovieWithHeaderData>.from(state.moviesWithHeader);
    newMovies.addAll(tempMovies);
    state.moviesWithHeader = newMovies;
  }

  void showedCategoryAtIndex({
    required int index,
  }) {
    if (state.moviesWithHeader.isEmpty ||
        state.moviesWithHeader.length == MovieGenres.values.length) return;
    if (index < state.moviesWithHeader.length - 1) return;
    _listenConnectivity(
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
