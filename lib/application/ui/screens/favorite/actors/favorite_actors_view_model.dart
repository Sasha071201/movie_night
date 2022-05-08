import 'dart:async';
import 'dart:developer';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/screens/view_favorite/view_favorite_view_model.dart';

import '../../../../../generated/l10n.dart';
import '../../../../domain/api_client/api_client_exception.dart';
import '../../../../domain/connectivity/app_connectivity_reactor.dart';
import '../../../../repository/account_repository.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/dialog_widget.dart';
import '../../../widgets/vertical_widgets_with_header/actors_with_header_widget.dart';

class FavoriteActrosState {
  List<ActorWithHeaderData> actorsWithHeader = [];
  bool isLoadingProgress = false;
  bool isLoaded = false;
}

class FavoriteActorsViewModel extends ChangeNotifier {
  final _repository = AccountRepository();
  final state = FavoriteActrosState();
  String _locale = '';
  late BuildContext _context;
  StreamSubscription? _streamSubscription;
  final _controllerNeedUpdate = StreamController<bool>();
  StreamSubscription? _streamNeedUpdateSubscription;
  AppConnectivityReactor? _appConnectivityReactor;
  Timer? _timer;

  FavoriteActorsViewModel(BuildContext context) {
    _context = context;
    _listenNeedUpdate();
    _listenChanges();
    _listenConnectivity(
      context: _context,
      onConnectionYes: _refresh,
    );
  }

  Future<void> setupLocale(BuildContext context) async {
    _context = context;
    final locale = Localizations.localeOf(_context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _controllerNeedUpdate.add(true);
  }

  void _listenConnectivity({
    required BuildContext context,
    required Function() onConnectionYes,
  }) {
    _appConnectivityReactor?.dispose();
    _appConnectivityReactor = AppConnectivityReactor(context: context);
    _appConnectivityReactor?.listenToConnectivityChanged(
      onConnectionYes: onConnectionYes,
      onConnectionNo: () {},
    );
  }

  void _listenNeedUpdate() {
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription =
        _controllerNeedUpdate.stream.listen((needUpdate) {
      if (needUpdate) _refresh();
    });
  }

  void _listenChanges() {
    _streamSubscription?.cancel();
    _streamSubscription = StreamGroup.merge([
      _repository.favoriteStream(),
    ]).listen((event) {
      _refresh();
    });
  }

  Future<void> _refresh() async {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 1000), () async {
      state.isLoaded = false;
      notifyListeners();
      await resetAll();
      state.isLoaded = true;
      notifyListeners();
    });
  }

  Future<void> resetAll() async {
    state.actorsWithHeader.clear();
    await _loadActors();
  }

  Future<void> _loadActors() async {
    if (state.isLoadingProgress) return;
    state.isLoadingProgress = true;

    try {
      await _fillActorsWithHeader();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    state.isLoadingProgress = false;
    notifyListeners();
  }

  Future<void> _fillActorsWithHeader() async {
    final tempActors = <ActorWithHeaderData>[];
    try {
      final actorsFavoriteResult =
          await _repository.fetchFavoritePeople(_locale, 10);
      if (actorsFavoriteResult.isNotEmpty) {
        tempActors.add(ActorWithHeaderData(
          title: S.of(_context).favorite,
          list: actorsFavoriteResult,
          viewFavoriteType: ViewFavoriteType.favorite,
        ));
      }
    } on ApiClientException catch (e) {
      if (e.solution == ExceptionSolution.update) {
        _controllerNeedUpdate.add(true);
      } else if (e.solution == ExceptionSolution.showMessage) {
        DialogWidget.showSnackBar(
          context: _context,
          text: e.asString(_context),
          backgroundColor: AppColors.colorError,
        );
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    final newActors = List<ActorWithHeaderData>.from(state.actorsWithHeader);
    newActors.addAll(tempActors);
    state.actorsWithHeader = newActors;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _streamSubscription?.cancel();
    _streamSubscription = null;
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription = null;
    _appConnectivityReactor?.dispose();
    _appConnectivityReactor = null;
    super.dispose();
  }
}
