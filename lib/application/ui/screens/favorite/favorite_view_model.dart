import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movies/Favorite_movies_view_model.dart';
import 'tv_shows/favorite_tv_shows_view_model.dart';

class FavoriteViewModel extends ChangeNotifier {
  final _categoryController = PageController(initialPage: 0);
  PageController get categoryController => _categoryController;

  final _listCategory = <String>[
    'Movies',
    'TV shows',
    'Actors',
  ];
  List<String> get listCategory => _listCategory;

  int _currentCategoryIndex = 0;
  int get currentCategoryIndex => _currentCategoryIndex;

  void selectCategory(int index, BuildContext context) {
    _currentCategoryIndex = index;
    _categoryController.jumpToPage(_currentCategoryIndex);
    notifyListeners();
  }
}