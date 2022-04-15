import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../domain/api_client/api_client_exception.dart';
import '../../../../domain/connectivity/app_connectivity_reactor.dart';
import '../../../../repository/actor_repository.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/dialog_widget.dart';
import '../../../widgets/vertical_widgets_with_header/actors_with_header_widget.dart';

class HomeActorsState {
  List<ActorWithHeaderData> actorsWithHeader = [];
}

class HomeActorsViewModel extends ChangeNotifier {
  AppConnectivityReactor? _appConnectivityReactor;
  final _repository = ActorRepository();
  final state = HomeActorsState();
  late BuildContext _context;
  String _locale = '';
  Timer? _timer;

  final _controllerNeedUpdate = StreamController<bool>();
  StreamSubscription? _streamNeedUpdateSubscription;

  HomeActorsViewModel() {
    _listenNeedUpdate();
  }

  Future<void> setupLocale(BuildContext context) async {
    _context = context;
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _listenConnectivity(
        context: _context,
        onConnectionYes: () async {
          state.actorsWithHeader.clear();
          await _loadActors();
        });
  }

  void _listenNeedUpdate() {
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription =
        _controllerNeedUpdate.stream.listen((needUpdate) {
      if (needUpdate) {
        _timer?.cancel();
        _timer = Timer(const Duration(seconds: 10), () async {
          state.actorsWithHeader.clear();
          await _loadActors();
        });
      }
    });
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

  Future<void> _loadActors() async {
    try {
      final actorsResult = <ActorWithHeaderData>[];
      final popularActors =
          await _repository.fetchPopularActors(locale: _locale);
      actorsResult.add(
        ActorWithHeaderData(
          title: S.of(_context).popular,
          list: popularActors.results,
        ),
      );
      state.actorsWithHeader = actorsResult;
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
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription = null;
    _appConnectivityReactor?.dispose();
    _appConnectivityReactor = null;
    super.dispose();
  }
}
