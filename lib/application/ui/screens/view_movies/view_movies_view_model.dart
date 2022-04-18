import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/api_client/api_client_exception.dart';
import '../../../domain/api_client/media_type.dart';
import '../../../domain/entities/media.dart';
import '../../../domain/entities/movie/movie.dart';
import '../../../domain/entities/tv_shows/tv_show.dart';
import '../../../repository/movie_repository.dart';
import '../../../repository/tv_show_repository.dart';
import '../../themes/app_colors.dart';
import '../../widgets/dialog_widget.dart';

enum ViewMediaType { recommendation, similar, nowPlaying, popular, topRated }

extension ViewMediaTypeString on ViewMediaType {
  asString(BuildContext context) {
    switch (this) {
      case ViewMediaType.recommendation:
        return S.of(context).recommendation;
      case ViewMediaType.similar:
        return S.of(context).similar;
      case ViewMediaType.nowPlaying:
        return S.of(context).now_playing;
      case ViewMediaType.popular:
        return S.of(context).popular;
      case ViewMediaType.topRated:
        return S.of(context).top_rated;
    }
  }
}

class ViewMoviesData {
  final MediaType mediaType;
  final ViewMediaType viewMoviesType;
  final int mediaId;
  ViewMoviesData({
    required this.mediaType,
    required this.viewMoviesType,
    required this.mediaId,
  });
}

class ViewMoviesState {
  late Media media;
  bool isLoadingProgress = false;
}

class ViewMoviesViewModel extends ChangeNotifier {
  final _movieRepository = MovieRepository();
  final _tvShowRepository = TvShowRepository();
  final ViewMoviesState state;
  final ViewMoviesData data;
  late int _currentPage;
  late int _totalPage;
  String _locale = '';
  late BuildContext _context;
  Timer? _timer;

  final _controllerNeedUpdate = StreamController<bool>();
  StreamSubscription? _streamNeedUpdateSubscription;

  ViewMoviesViewModel(this.data)
      : state = ViewMoviesState()
          ..media = Media(mediaType: data.mediaType, media: []) {
    _listenNeedUpdate();
  }

  Future<void> setupLocale(BuildContext context) async {
    _context = context;
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _currentPage = 0;
    _totalPage = 1;
    await _loadMovies();
  }

  void _listenNeedUpdate() {
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription =
        _controllerNeedUpdate.stream.listen((needUpdate) {
      if (needUpdate) {
        _timer?.cancel();
        _timer = Timer(const Duration(seconds: 10), () async {
          await _loadMovies();
        });
      }
    });
  }

  Future<void> _loadMovies() async {
    if (state.isLoadingProgress || _currentPage >= _totalPage) return;
    state.isLoadingProgress = true;
    Future.microtask(() => notifyListeners());
    final nextPage = _currentPage + 1;

    try {
      await _fetchMovies(nextPage);
      state.isLoadingProgress = false;
    } on ApiClientException catch (e) {
      _controllerNeedUpdate.add(true);
      DialogWidget.showSnackBar(
        context: _context,
        text: e.asString(_context),
        backgroundColor: AppColors.colorError,
      );
    } catch (e) {
      log(e.toString());
    }
    state.isLoadingProgress = false;
    notifyListeners();
  }

  Future<void> _fetchMovies(int nextPage) async {
    if (state.media.mediaType == MediaType.movie) {
      late final moviesResponse;
      if (data.viewMoviesType == ViewMediaType.recommendation) {
        moviesResponse = await _movieRepository.fetchRecommendationMovies(
          locale: _locale,
          page: nextPage,
          movieId: data.mediaId,
        );
      } else if (data.viewMoviesType == ViewMediaType.similar) {
        moviesResponse = await _movieRepository.fetchSimilarMovies(
          locale: _locale,
          page: nextPage,
          movieId: data.mediaId,
        );
      } else if (data.viewMoviesType == ViewMediaType.nowPlaying) {
        moviesResponse = await _movieRepository.fetchNowPlayingMovies(
          page: nextPage,
          locale: _locale,
        );
      } else if (data.viewMoviesType == ViewMediaType.popular) {
        moviesResponse = await _movieRepository.fetchPopularMovies(
          page: nextPage,
          locale: _locale,
        );
      } else if (data.viewMoviesType == ViewMediaType.topRated) {
        moviesResponse = await _movieRepository.fetchTopRatedMovies(
          page: nextPage,
          locale: _locale,
        );
      }
      _currentPage = moviesResponse.page;
      _totalPage = moviesResponse.totalPages;
      final movieNewAndOld = List<Movie>.from(state.media.media);
      movieNewAndOld.addAll(moviesResponse.results);
      state.media.media = movieNewAndOld;
    } else if (state.media.mediaType == MediaType.tv) {
      late final tvShowsResponse;
      if (data.viewMoviesType == ViewMediaType.recommendation) {
        tvShowsResponse = await _tvShowRepository.fetchRecommendationTvShows(
          locale: _locale,
          page: nextPage,
          tvShowId: data.mediaId,
        );
      } else if (data.viewMoviesType == ViewMediaType.similar) {
        tvShowsResponse = await _tvShowRepository.fetchSimilarTvShows(
          locale: _locale,
          page: nextPage,
          tvShowId: data.mediaId,
        );
      } else if (data.viewMoviesType == ViewMediaType.nowPlaying) {
        tvShowsResponse = await _tvShowRepository.fetchTvShowOnTheAir(
          page: nextPage,
          locale: _locale,
        );
      } else if (data.viewMoviesType == ViewMediaType.popular) {
        tvShowsResponse = await _tvShowRepository.fetchPopularTvShow(
          page: nextPage,
          locale: _locale,
        );
      } else if (data.viewMoviesType == ViewMediaType.topRated) {
        tvShowsResponse = await _tvShowRepository.fetchTopRatedTvShow(
          page: nextPage,
          locale: _locale,
        );
      }
      _currentPage = tvShowsResponse.page;
      _totalPage = tvShowsResponse.totalPages;
      final mediaNewAndOld = List<TvShow>.from(state.media.media);
      mediaNewAndOld.addAll(tvShowsResponse.results);
      state.media.media = mediaNewAndOld;
    }
  }

  void showedCategoryAtIndex(int index) {
    if (index < state.media.media.length - 1) return;
    _loadMovies();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription = null;
    super.dispose();
  }
}
