import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/api_client/api_client_exception.dart';
import '../../../domain/api_client/release_type.dart';
import '../../../domain/api_client/sort_by_type.dart';
import '../../../domain/entities/genre.dart';
import '../../../domain/entities/media.dart';
import '../../../domain/entities/movie/movie.dart';
import '../../../repository/movie_repository.dart';
import '../../../repository/tv_show_repository.dart';
import '../../themes/app_colors.dart';
import '../../widgets/dialog_widget.dart';
import '../filter/filter_view_model.dart';

class ViewAllMoviesData {
  List<Genre> withGenres;
  List<Genre> withoutGenres;
  DateTime? fromReleaseDate;
  DateTime? beforeReleaseDate;
  ReleaseType? titleReleaseDate;
  bool? includeAdult;
  double? voteAverageFrom;
  double? voteAverageBefore;

  ViewAllMoviesData({
    this.withGenres = const [],
    this.withoutGenres = const [],
    this.fromReleaseDate,
    this.beforeReleaseDate,
    this.titleReleaseDate,
    this.includeAdult,
    this.voteAverageFrom,
    this.voteAverageBefore,
  });
}

class ViewAllMoviesState {
  late ViewAllMoviesData data;
  int indexSortBy = 1;
  late Media media;
  bool isLoadingProgress = false;
}

class ViewAllMoviesViewModel extends ChangeNotifier {
  final _movieRepository = MovieRepository();
  final _tvShowRepository = TvShowRepository();
  late DateFormat _dateFormat;
  final ViewAllMoviesState state;
  late int _currentPage;
  late int _totalPage;
  late BuildContext _context;
  String _locale = '';
  Timer? _timer;

  final _controllerNeedUpdate = StreamController<bool>();
  StreamSubscription? _streamNeedUpdateSubscription;

  ViewAllMoviesViewModel(ViewAllMoviesData data, MediaType mediaType)
      : state = ViewAllMoviesState()
          ..data = data
          ..media = Media(mediaType: mediaType, media: []) {
    _listenNeedUpdate();
  }

  Future<void> setupLocale(BuildContext context) async {
    _context = context;
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMd(_locale);
    await resetAll();
  }

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : S.of(_context).not_chosen;

  Future<void> resetAll() async {
    _currentPage = 0;
    _totalPage = 1;
    state.media.media.clear();
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
      await _fetchMovie(nextPage);
      state.isLoadingProgress = false;
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

  Future<void> _fetchMovie(int nextPage) async {
    final withGenres =
        state.data.withGenres.map((genre) => genre.asId()).join(',');
    final withoutGenres =
        state.data.withoutGenres.map((genre) => genre.asId()).join(',');
    if (state.media.mediaType == MediaType.movie) {
      final moviesResponse = await _movieRepository.fetchMovies(
        locale: _locale,
        page: nextPage,
        sortBy: SortBy.values[state.indexSortBy].asApiString(),
        withGenres: withGenres,
        withoutGenres: withoutGenres,
        includeAdult: state.data.includeAdult,
        withReleaseType: state.data.titleReleaseDate?.asApiString(),
        releaseDateFrom: state.data.fromReleaseDate,
        releaseDateBefore: state.data.beforeReleaseDate,
        voteAverageFrom: state.data.voteAverageFrom != null
            ? state.data.voteAverageFrom! / 10
            : null,
        voteAverageBefore: state.data.voteAverageBefore != null
            ? state.data.voteAverageBefore! / 10
            : null,
      );
      _currentPage = moviesResponse.page;
      _totalPage = moviesResponse.totalPages;
      final movieNewAndOld = List<Movie>.from(state.media.media);
      movieNewAndOld.addAll(moviesResponse.results);
      state.media.media = movieNewAndOld;
    } else if (state.media.mediaType == MediaType.tv) {
      final tvShowsResponse = await _tvShowRepository.fetchTvShows(
        locale: _locale,
        page: nextPage,
        sortBy: SortBy.values[state.indexSortBy].asApiString(),
        withGenres: withGenres,
        withoutGenres: withoutGenres,
        releaseDateFrom: state.data.fromReleaseDate,
        releaseDateBefore: state.data.beforeReleaseDate,
        voteAverageFrom: state.data.voteAverageFrom != null
            ? state.data.voteAverageFrom! / 10
            : null,
        voteAverageBefore: state.data.voteAverageBefore != null
            ? state.data.voteAverageBefore! / 10
            : null,
      );
      _currentPage = tvShowsResponse.page;
      _totalPage = tvShowsResponse.totalPages;
      final movieNewAndOld = List<TvShow>.from(state.media.media);
      movieNewAndOld.addAll(tvShowsResponse.results);
      state.media.media = movieNewAndOld;
    }
  }

  void showedCategoryAtIndex(int index) {
    if (index < state.media.media.length - 1) return;
    _loadMovies();
  }

  FilterData getFilterData() {
    final indicesWithGenre =
        state.data.withGenres.map((e) => e.asIndex()!).toList();
    final indicesWithoutGenre =
        state.data.withoutGenres.map((e) => e.asIndex()!).toList();

    return FilterData(
      includeAdult: state.data.includeAdult ?? false,
      currentIndexReleaseDate: state.data.titleReleaseDate != null
          ? ReleaseType.values.indexOf(state.data.titleReleaseDate!)
          : -1,
      indicesWithGenre: indicesWithGenre,
      indicesWithoutGenre: indicesWithoutGenre,
      fromReleaseDate: state.data.fromReleaseDate,
      beforeReleaseDate: state.data.beforeReleaseDate,
      voteAverageBefore: state.data.voteAverageBefore ?? 100,
      voteAverageFrom: state.data.voteAverageFrom ?? 0,
    );
  }

  Future<void> openFilter(
    Future<Object?> pushNamed,
    BuildContext context,
  ) async {
    final data = (await pushNamed) as ViewAllMoviesData?;
    if (data != null) {
      state.data = data;
    }
    await resetAll();
  }

  Future<void> selectIndexSortBy(int index, BuildContext context) async {
    state.indexSortBy = index;
    notifyListeners();
    await resetAll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription = null;
    super.dispose();
  }
}
