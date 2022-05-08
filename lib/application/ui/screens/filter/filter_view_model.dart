import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:movie_night/application/domain/api_client/certifications.dart';
import 'package:movie_night/application/domain/api_client/release_type.dart';
import 'package:movie_night/application/domain/entities/genre.dart';
import 'package:movie_night/application/domain/entities/movie/movie_genres.dart';
import 'package:movie_night/application/ui/screens/view_all_movies/view_all_movies_view_model.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/api_client/media_type.dart';
import '../../../domain/entities/tv_shows/tv_show_genres.dart';
import '../../navigation/app_navigation.dart';
import '../../widgets/dialog_widget.dart';

enum DateTimeType { from, before }

class FilterData {
  List<Genre> withGenres = [];
  List<Genre> withoutGenres = [];

  List<String> certification = [];

  List<ReleaseType> releaseDates = [];

  bool includeAdult;

  int currentIndexReleaseDate = -1;
  List<int> currentIndicesWithGenre = [];
  List<int> currentIndicesWithoutGenre = [];
  DateTime? fromReleaseDate;
  DateTime? beforeReleaseDate;
  double voteAverageFrom;
  double voteAverageBefore;

  FilterData({
    this.includeAdult = false,
    this.currentIndexReleaseDate = -1,
    List<int> indicesWithGenre = const [],
    List<int> indicesWithoutGenre = const [],
    this.fromReleaseDate,
    this.beforeReleaseDate,
    this.voteAverageFrom = 0,
    this.voteAverageBefore = 100,
  })  : currentIndicesWithGenre = List.from(indicesWithGenre),
        currentIndicesWithoutGenre = List.from(indicesWithoutGenre);
}

class FilterState {
  late FilterData data;
}

class FilterViewModel extends ChangeNotifier {
  final MediaType mediaType;
  final bool openFromMain;
  late final FilterState state;
  late DateFormat _dateFormat;
  late BuildContext _context;
  String _locale = '';

  FilterViewModel(
      {required FilterData data,
      required this.mediaType,
      required this.openFromMain})
      : state = FilterState()
          ..data = FilterData(
            includeAdult: data.includeAdult,
            currentIndexReleaseDate: data.currentIndexReleaseDate,
            indicesWithGenre: data.currentIndicesWithGenre,
            indicesWithoutGenre: data.currentIndicesWithoutGenre,
            fromReleaseDate: data.fromReleaseDate,
            beforeReleaseDate: data.beforeReleaseDate,
            voteAverageBefore: data.voteAverageBefore,
            voteAverageFrom: data.voteAverageFrom,
          );

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : S.of(_context).not_chosen;

  Future<void> setupLocale(BuildContext context) async {
    _context = context;
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMd(_locale);
    state.data.releaseDates = ReleaseType.values.toList();
    await _loadFilterData();
  }

  void resetFilters() {
    state.data.beforeReleaseDate = null;
    state.data.fromReleaseDate = null;
    state.data.currentIndexReleaseDate = -1;
    state.data.currentIndicesWithGenre.clear();
    state.data.currentIndicesWithoutGenre.clear();
    state.data.voteAverageBefore = 100;
    state.data.voteAverageFrom = 0;
    notifyListeners();
  }

  Future<void> _loadFilterData() async {
    _loadCertification();
    _loadGenres();
    Future.microtask(() => notifyListeners());
  }

  void _loadCertification() {
    if (_locale == 'ru') {
      state.data.certification = Certifications.ru;
    } else {
      state.data.certification = Certifications.us;
    }
  }

  void _loadGenres() {
    if (mediaType == MediaType.movie) {
      final genres =
          MovieGenres.values.map((genre) => Genre(genre: genre)).toList();
      state.data.withGenres = genres;
      state.data.withoutGenres = genres;
    } else {
      final genres =
          TvShowGenres.values.map((genre) => Genre(genre: genre)).toList();
      state.data.withGenres = genres;
      state.data.withoutGenres = genres;
    }
  }

  void selectReleaseDateItem(int index) {
    if (state.data.currentIndexReleaseDate != index) {
      state.data.currentIndexReleaseDate = index;
      state.data.fromReleaseDate = null;
      state.data.beforeReleaseDate = null;
    } else {
      state.data.currentIndexReleaseDate = -1;
    }
    notifyListeners();
  }

  Future<void> pickDate(BuildContext context, DateTimeType dateTimeType) async {
    final dateNow = DateTime.now();
    final minDate = DateTime(1000);
    final maxDate = DateTime(dateNow.year + 1000);

    final date = await DialogWidget.showDataPicker(
      context: context,
      initialDate: dateNow,
      firstDate: minDate,
      lastDate: maxDate,
    );
    _selectReleaseDate(date, dateTimeType);
  }

  void _selectReleaseDate(DateTime? date, DateTimeType dateTimeType) {
    if (date != null) {
      state.data.currentIndexReleaseDate = -1;
      switch (dateTimeType) {
        case DateTimeType.before:
          state.data.beforeReleaseDate = date;

          break;
        case DateTimeType.from:
          state.data.fromReleaseDate = date;

          break;
      }
      notifyListeners();
    }
  }

  void selectWithGenre(int index) {
    if (state.data.currentIndicesWithGenre.contains(index)) {
      state.data.currentIndicesWithGenre.remove(index);
    } else {
      state.data.currentIndicesWithGenre.add(index);
    }
    notifyListeners();
  }

  void selectWithoutGenre(int index) {
    if (state.data.currentIndicesWithoutGenre.contains(index)) {
      state.data.currentIndicesWithoutGenre.remove(index);
    } else {
      state.data.currentIndicesWithoutGenre.add(index);
    }
    notifyListeners();
  }

  void selectIncludeAdult(bool value) {
    state.data.includeAdult = value;
    notifyListeners();
  }

  void onChangedVoteAverage(SfRangeValues values) {
    state.data.voteAverageFrom = values.start;
    state.data.voteAverageBefore = values.end;
    notifyListeners();
  }

  void apply(BuildContext context) {
    final titleReleaseDate = state.data.currentIndexReleaseDate != -1
        ? state.data.releaseDates[state.data.currentIndexReleaseDate]
        : null;
    final withGenres = _fillGenres(true);
    final withoutGenres = _fillGenres(false);
    final data = ViewAllMoviesData(
      withGenres: withGenres,
      withoutGenres: withoutGenres,
      fromReleaseDate: state.data.fromReleaseDate,
      beforeReleaseDate: state.data.beforeReleaseDate,
      titleReleaseDate: titleReleaseDate,
      includeAdult: state.data.includeAdult,
      voteAverageFrom: state.data.voteAverageFrom,
      voteAverageBefore: state.data.voteAverageBefore,
    );
    if (openFromMain) {
      Navigator.of(context).pushReplacementNamed(
        Screens.viewAllMovies,
        arguments: [data, mediaType],
      );
    } else {
      Navigator.of(context).pop(data);
    }
  }

  List<Genre> _fillGenres(bool isWithGenres) {
    final tempGenres = <Genre>[];
    final currentIndicesGenre = isWithGenres
        ? state.data.currentIndicesWithGenre
        : state.data.currentIndicesWithoutGenre;
    final genres =
        isWithGenres ? state.data.withGenres : state.data.withoutGenres;
    for (var i = 0; i < currentIndicesGenre.length; i++) {
      final indexGenre = currentIndicesGenre[i];
      final genre = genres[indexGenre];
      tempGenres.add(genre);
    }
    return tempGenres;
  }
}
