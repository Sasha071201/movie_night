import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_night/application/domain/entities/search/multi_search.dart';
import 'package:movie_night/application/repository/search_repository.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../main/main_view_model.dart';

class SearchViewModel extends ChangeNotifier {
  final _repository = SearchRepository();
  final _categoryController = PageController(initialPage: 0);
  PageController get categoryController => _categoryController;
  String _locale = '';
  String get locale => _locale;
  late DateFormat _dateFormat;
  DateFormat get dateFormat => _dateFormat;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  final _listCategory = <String>[
    'Movies',
    'TV Shows',
    'People',
  ];
  List<String> get listCategory => _listCategory;

  int _currentCategoryIndex = 0;
  int get currentCategoryIndex => _currentCategoryIndex;

  void selectCategory(int index, BuildContext context) {
    context.read<MainViewModel>().showAdIfAvailable();
    _currentCategoryIndex = index;
    _categoryController.jumpToPage(_currentCategoryIndex);
    Future.microtask(() => notifyListeners());
  }

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMd(_locale);
    _listCategory[0] = S.of(context).movies;
    _listCategory[1] = S.of(context).tv_shows;
    _listCategory[2] = S.of(context).people;
    Future.microtask(() => notifyListeners());
  }

  Future<MultiSearch> fetchSuggestions(String searchValue) async {
    return _repository.searchMulti(locale: _locale, query: searchValue);
  }
}
