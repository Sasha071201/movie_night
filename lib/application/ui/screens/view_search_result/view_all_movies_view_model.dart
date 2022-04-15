import 'dart:async';

import 'package:flutter/material.dart';

import 'package:movie_night/application/domain/entities/search/multi_search.dart';

import '../../../domain/api_client/api_client_exception.dart';
import '../../../repository/search_repository.dart';
import '../../themes/app_colors.dart';
import '../../widgets/dialog_widget.dart';

class ViewSearchResultState {
  List<MultiSearchResult> searchResult = [];
  bool isLoadingProgress = false;
}

class ViewSearchResultViewModel extends ChangeNotifier {
  final _searchRepository = SearchRepository();
  final ViewSearchResultState state = ViewSearchResultState();
  late int _currentPage;
  late int _totalPage;
  late String query;
  String _locale = '';
  late BuildContext _context;
  Timer? _timer;

  final _controllerNeedUpdate = StreamController<bool>();
  StreamSubscription? _streamNeedUpdateSubscription;

  ViewSearchResultViewModel({
    required this.query,
  }) {
    _listenNeedUpdate();
  }

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    await resetAll();
  }

  Future<void> resetAll() async {
    _currentPage = 0;
    _totalPage = 1;
    state.searchResult.clear();
    await _loadSearchResult();
  }

  void _listenNeedUpdate() {
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription =
        _controllerNeedUpdate.stream.listen((needUpdate) {
      if (needUpdate) {
        _timer?.cancel();
        _timer = Timer(const Duration(seconds: 10), () async {
          await _loadSearchResult();
        });
      }
    });
  }

  Future<void> _loadSearchResult() async {
    if (state.isLoadingProgress || _currentPage >= _totalPage) return;
    state.isLoadingProgress = true;
    Future.microtask(() => notifyListeners());
    final nextPage = _currentPage + 1;

    try {
      await _fetchSearchResult(nextPage);
      state.isLoadingProgress = false;
    } on ApiClientException catch (e) {
      _controllerNeedUpdate.add(true);
      DialogWidget.showSnackBar(
        context: _context,
        text: e.asString(_context),
        backgroundColor: AppColors.colorError,
      );
    } catch (e) {
      print(e);
    }
    state.isLoadingProgress = false;
    notifyListeners();
  }

  Future<void> _fetchSearchResult(int nextPage) async {
    final searchResponse = await _searchRepository.searchMulti(
      locale: _locale,
      query: query,
      page: nextPage,
    );
    _currentPage = searchResponse.page;
    _totalPage = searchResponse.totalPages;
    final movieNewAndOld = List<MultiSearchResult>.from(state.searchResult);
    movieNewAndOld.addAll(searchResponse.results);
    state.searchResult = movieNewAndOld;
  }

  void showedCategoryAtIndex(int index) {
    if (index < state.searchResult.length - 1) return;
    _loadSearchResult();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription = null;
    super.dispose();
  }
}
