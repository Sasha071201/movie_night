import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/entities/actor.dart';
import 'package:movie_night/application/domain/entities/movie.dart';

class SearchViewModel extends ChangeNotifier {
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

  final List<Movie> _suggestionMovies = [
    Movie(
      title: 'Heroes',
      description: '2021, US, Drama',
    ),
    Movie(
      title: 'Heroes now',
      description: '2021, US, Drama',
    ),
    Movie(
      title: 'Jumanji',
      description: '2021, US, Drama',
    ),
  ];

  final List<Actor> _suggestionActors = [
    Actor(name: 'John Cena'),
    Actor(name: 'Carlos Pena'),
    Actor(name: 'James Maslow'),
    Actor(name: 'kendall Smith'),
  ];

  Future<List<dynamic>> fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));
    switch (_currentCategoryIndex) {
      case 0:
      case 1:
        return _suggestionMovies.where((element) {
          return element.title
              .toLowerCase()
              .contains(searchValue.toLowerCase());
        }).toList();
      case 2:
        return _suggestionActors.where((element) {
          return element.name.toLowerCase().contains(searchValue.toLowerCase());
        }).toList();
      default:
        return [];
    }
  }
}
