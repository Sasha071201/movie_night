import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../main/main_view_model.dart';

class HomeViewModel extends ChangeNotifier {
  final _categoryController = PageController(initialPage: 0);
  PageController get categoryController => _categoryController;
  String _locale = '';

  final _listCategory = <String>[
    'Movies',
    'TV Shows',
    'People',
  ];

  List<String> get listCategory => _listCategory;

  int _currentCategoryIndex = 0;
  int get currentCategoryIndex => _currentCategoryIndex;

  void setupLocale(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _listCategory[0] = S.of(context).movies;
    _listCategory[1] = S.of(context).tv_shows;
    _listCategory[2] = S.of(context).people;
    Future.microtask(() => notifyListeners());
  }

  Future<void> selectCategory(int index, BuildContext context) async {
    context.read<MainViewModel>().showAdIfAvailable();
    _currentCategoryIndex = index;
    _categoryController.jumpToPage(_currentCategoryIndex);
    notifyListeners();
  }
}
