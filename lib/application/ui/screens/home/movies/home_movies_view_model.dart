import 'dart:async';

import 'package:flutter/material.dart';

class HomeMoviesViewModel extends ChangeNotifier {
  final _headerMoviesPageController =
      PageController(viewportFraction: 302 / 390);
  PageController get headerMoviesPageController => _headerMoviesPageController;

  Timer? _timer;

  int _currentHeaderMovieIndex = 0;
  int get currentHeaderMovieIndex => _currentHeaderMovieIndex;

  final _listHeaderMovies = <String>[
    'Movies',
    'Movies',
    'Movies',
    'Movies',
    'Movies',
  ];
  List<String> get listHeaderMovies => _listHeaderMovies;

  HomeMoviesViewModel() {
    _startTimer(_headerMoviesPageController);
  }

  void _startTimer(PageController controller) {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 3000), () {
      if (_currentHeaderMovieIndex == _listHeaderMovies.length - 1) {
        _currentHeaderMovieIndex = 0;
        controller.jumpToPage(_currentHeaderMovieIndex);
      } else {
        _currentHeaderMovieIndex++;
        controller.animateToPage(
          _currentHeaderMovieIndex,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      }
      notifyListeners();
      _startTimer(controller);
    });
  }

  void onHeaderChanged(int index, PageController controller) {
    _currentHeaderMovieIndex = index;
    _startTimer(controller);
    notifyListeners();
  }

  void onMoviePressed() {
    _timer?.cancel();
  }

  void resumeWorking() {
    _startTimer(_headerMoviesPageController);
    if (_headerMoviesPageController.hasClients) {
      _headerMoviesPageController.jumpToPage(_currentHeaderMovieIndex);
    }
  }

  void stopWorking() {
    _timer?.cancel();
    _currentHeaderMovieIndex = 0;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
