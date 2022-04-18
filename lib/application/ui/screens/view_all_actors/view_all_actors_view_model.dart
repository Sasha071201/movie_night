import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/entities/actor/actor.dart';

import '../../../domain/api_client/api_client_exception.dart';
import '../../../repository/actor_repository.dart';
import '../../themes/app_colors.dart';
import '../../widgets/dialog_widget.dart';

class ViewAllActorsState {
  List<Actor> actors = [];
  bool isLoadingProgress = false;
}

class ViewAllActorsViewModel extends ChangeNotifier {
  final _actorRepository = ActorRepository();
  final ViewAllActorsState state = ViewAllActorsState();
  late int _currentPage;
  late int _totalPage;
  String _locale = '';
  late BuildContext _context;
  Timer? _timer;

  final _controllerNeedUpdate = StreamController<bool>();
  StreamSubscription? _streamNeedUpdateSubscription;

  ViewAllActorsViewModel() {
    _listenNeedUpdate();
  }

  Future<void> setupLocale(BuildContext context) async {
    _context = context;
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _currentPage = 0;
    _totalPage = 1;
    await _loadActors();
  }

  void _listenNeedUpdate() {
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription =
        _controllerNeedUpdate.stream.listen((needUpdate) {
      if (needUpdate) {
        _timer?.cancel();
        _timer = Timer(const Duration(seconds: 10), () async {
          await _loadActors();
        });
      }
    });
  }

  Future<void> _loadActors() async {
    if (state.isLoadingProgress || _currentPage >= _totalPage) return;
    state.isLoadingProgress = true;
    Future.microtask(() => notifyListeners());
    final nextPage = _currentPage + 1;

    try {
      await _fetchActors(nextPage);
    } on ApiClientException catch (e) {
      _controllerNeedUpdate.add(true);
      DialogWidget.showSnackBar(
        context: _context,
        text: e.asString(_context),
        backgroundColor: AppColors.colorError,
      );
    } catch (e) {
    }
    state.isLoadingProgress = false;
    notifyListeners();
  }

  Future<void> _fetchActors(int nextPage) async {
    final actorsResponse = await _actorRepository.fetchPopularActors(
      locale: _locale,
      page: nextPage,
    );
    _currentPage = actorsResponse.page;
    _totalPage = actorsResponse.totalPages;
    final actorNewAndOld = List<Actor>.from(state.actors);
    actorNewAndOld.addAll(actorsResponse.results);
    state.actors = actorNewAndOld;
  }

  void showedCategoryAtIndex(int index) {
    if (index < state.actors.length - 1) return;
    _loadActors();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription = null;
    super.dispose();
  }
}
