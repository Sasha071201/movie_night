import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:movie_night/application/domain/entities/tv_shows/season_details.dart';
import 'package:movie_night/application/domain/entities/tv_shows/season_images.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';

import '../../../domain/api_client/api_client_exception.dart';
import '../../../repository/tv_show_repository.dart';
import '../../themes/app_colors.dart';
import '../../widgets/dialog_widget.dart';

class SeasonDetailsState {
  SeasonDetails? seasonDetails;
  SeasonImages? seasonImages;

  SeasonDetailsState({
    this.seasonDetails,
    this.seasonImages,
  });
}

class SeasonDetailsViewModel extends ChangeNotifier {
  final _repository = TvShowRepository();
  final state = SeasonDetailsState();
  final int _seasonId;
  final int _tvShowId;
  String _locale = '';
  late BuildContext _context;
  late DateFormat _dateFormat;
  Timer? _timer;

  final _controllerNeedUpdate = StreamController<bool>();
  StreamSubscription? _streamNeedUpdateSubscription;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  SeasonDetailsViewModel({
    required int seasonId,
    required int tvShowId,
  })  : _seasonId = seasonId,
        _tvShowId = tvShowId {
    _listenNeedUpdate();
  }

  Future<void> setupLocale(BuildContext context) async {
    _context = context;
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMd(_locale);
    await _loadDetails();
  }

  void _listenNeedUpdate() {
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription =
        _controllerNeedUpdate.stream.listen((needUpdate) {
      if (needUpdate) {
        _timer?.cancel();
        _timer = Timer(const Duration(seconds: 10), () async {
          await _loadDetails();
        });
      }
    });
  }

  Future<void> _loadDetails() async {
    try {
      final seasonDetails = await _repository.fetchSeasonDetails(
        locale: _locale,
        tvShowId: _tvShowId,
        seasonId: _seasonId,
      );
      final seasonImages = await _repository.fetchSeasonImages(
        tvShowId: _tvShowId,
        seasonId: _seasonId,
      );
      state.seasonDetails = seasonDetails;
      state.seasonImages = seasonImages;
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

  void toEpisode(BuildContext context, int episodeId) {
    Navigator.of(context).pushNamed(
      Screens.episodeDetails,
      arguments: [episodeId, _seasonId, _tvShowId],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription = null;
    super.dispose();
  }
}
