import 'dart:async';

import 'package:flutter/material.dart';

class HomeTvShowsViewModel extends ChangeNotifier {
  final _headerTvShowsPageController =
      PageController(viewportFraction: 302 / 390);
  PageController get headerTvShowsPageController =>
      _headerTvShowsPageController;

  Timer? _timer;

  int _currentHeaderTvShowsIndex = 0;
  int get currentHeaderTvShowsIndex => _currentHeaderTvShowsIndex;

  final _listHeaderTvShows = <String>[
    'Movies',
    'Movies',
    'Movies',
    'Movies',
    'Movies',
  ];
  List<String> get listHeaderTvShows => _listHeaderTvShows;

  HomeTvShowsViewModel() {
    _startTimer(_headerTvShowsPageController);
  }

  void _startTimer(PageController controller) {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 3000), () {
      if (_currentHeaderTvShowsIndex == _listHeaderTvShows.length - 1) {
        _currentHeaderTvShowsIndex = 0;
        controller.jumpToPage(_currentHeaderTvShowsIndex);
      } else {
        _currentHeaderTvShowsIndex++;
        controller.animateToPage(
          _currentHeaderTvShowsIndex,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      }
      notifyListeners();
      _startTimer(controller);
    });
  }

  void onHeaderChanged(int index, PageController controller) {
    _currentHeaderTvShowsIndex = index;
    _startTimer(controller);
    notifyListeners();
  }

  void onTvShowPressed() {
    _timer?.cancel();
  }

  void resumeWorking() {
    _startTimer(_headerTvShowsPageController);
    if (_headerTvShowsPageController.hasClients) {
      _headerTvShowsPageController.jumpToPage(_currentHeaderTvShowsIndex);
    }
  }

  void stopWorking() {
    _timer?.cancel();
    _currentHeaderTvShowsIndex = 0;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
