import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/app_review/app_review.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../main/main_view_model.dart';

class FavoriteViewModel extends ChangeNotifier {
  final _categoryController = PageController(initialPage: 0);
  Timer? _timer;
  final _appReview = AppReview();
  PageController get categoryController => _categoryController;
  String _locale = '';
  String? userId;

  FavoriteViewModel([this.userId]);

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

  void selectCategory(int index, BuildContext context) {
    context.read<MainViewModel?>()?.showAdIfAvailable();
    _showReview();
    _currentCategoryIndex = index;
    if (userId == null) {
      _categoryController.jumpToPage(_currentCategoryIndex);
    }
    notifyListeners();
  }

  void _showReview() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), () async {
      await _appReview.showReview();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
