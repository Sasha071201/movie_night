import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:movie_night/application/domain/entities/tv_shows/episode_details.dart';
import 'package:movie_night/application/domain/entities/tv_shows/episode_images.dart';

import '../../../domain/api_client/api_client_exception.dart';
import '../../../repository/tv_show_repository.dart';
import '../../themes/app_colors.dart';
import '../../widgets/dialog_widget.dart';

class EpisodeDetailsState {
  EpisodeDetails? episodeDetails;
  EpisodeImages? episodeImages;

  EpisodeDetailsState({
    this.episodeDetails,
    this.episodeImages,
  });
}

class EpisodeDetailsViewModel extends ChangeNotifier {
  final _repository = TvShowRepository();
  final state = EpisodeDetailsState();
  final int _episodeId;
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

  EpisodeDetailsViewModel({
    required int episodeId,
    required int seasonId,
    required int tvShowId,
  })  : _seasonId = seasonId,
        _tvShowId = tvShowId,
        _episodeId = episodeId {
    _listenNeedUpdate();
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

  Future<void> setupLocale(BuildContext context) async {
    _context = context;
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMd(_locale);
    await _loadDetails();
  }

  Future<void> _loadDetails() async {
    try {
      final episodeDetails = await _repository.fetchEpisodeDetails(
        locale: _locale,
        episodeId: _episodeId,
        tvShowId: _tvShowId,
        seasonId: _seasonId,
      );
      final episodeImages = await _repository.fetchEpisodeImages(
        episodeId: _episodeId,
        tvShowId: _tvShowId,
        seasonId: _seasonId,
      );
      state.episodeDetails = episodeDetails;
      state.episodeImages = episodeImages;
    } on ApiClientException catch (e) {
      _controllerNeedUpdate.add(true);
      DialogWidget.showSnackBar(
        context: _context,
        text: e.asString(_context),
        backgroundColor: AppColors.colorError,
      );
    } catch (e) {
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription = null;
    super.dispose();
  }
}
