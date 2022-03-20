import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/screens/home/movies/home_movies_view_model.dart';
import 'package:movie_night/application/ui/screens/home/tv_shows/home_tv_shows_view_model.dart';
import 'package:provider/provider.dart';

class HomeViewModel extends ChangeNotifier {
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
    prepareCategory(index, context);
    _currentCategoryIndex = index;
    _categoryController.jumpToPage(_currentCategoryIndex);
    notifyListeners();
  }

  void prepareCategory(index, BuildContext context) {
    switch (index) {
      case 0:
        context.read<HomeMoviesViewModel>().resumeWorking();
        context.read<HomeTvShowsViewModel>().stopWorking();
        break;
      case 1:
        context.read<HomeTvShowsViewModel>().resumeWorking();
        context.read<HomeMoviesViewModel>().stopWorking();
        break;
      case 2:
        context.read<HomeMoviesViewModel>().stopWorking();
        context.read<HomeTvShowsViewModel>().stopWorking();
        break;
    }
  }

  void stopWorkingScreen(BuildContext context) {
    context.read<HomeMoviesViewModel>().stopWorking();
    context.read<HomeTvShowsViewModel>().stopWorking();
  }
}
