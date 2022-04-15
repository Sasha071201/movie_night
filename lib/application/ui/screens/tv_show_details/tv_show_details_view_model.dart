import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:movie_night/application/domain/entities/tv_shows/tv_show_images.dart';
import 'package:translator/translator.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/ad_mob/ad_helper.dart';
import '../../../domain/api_client/api_client_exception.dart';
import '../../../domain/connectivity/connectivity_helper.dart';
import '../../../domain/entities/complaint_review.dart';
import '../../../domain/entities/review.dart';
import '../../../domain/entities/tv_shows/tv_show_details.dart';
import '../../../repository/account_repository.dart';
import '../../../repository/tv_show_repository.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../utils/profanity_filter.dart';
import '../../themes/app_colors.dart';
import '../../widgets/dialog_widget.dart';

class TvShowDetailsState {
  TvShowDetails? tvShowDetails;
  TvShowImages? tvShowImages;
  bool showAdultContent;
  bool isFavorite;
  bool isWatched;
  bool isLoaded;
  bool isProgressSending;

  TvShowDetailsState({
    this.tvShowDetails,
    this.tvShowImages,
    this.showAdultContent = false,
    this.isFavorite = false,
    this.isWatched = false,
    this.isLoaded = false,
    this.isProgressSending = false,
  });
}

class TvShowDetailsViewModel extends ChangeNotifier {
  final _translator = GoogleTranslator();
  final _tvShowRepository = TvShowRepository();
  final _accountRepository = AccountRepository();
  final state = TvShowDetailsState();
  final int tvShowId;
  String _locale = '';
  late DateFormat _dateFormat;
  late AdHelper adHelper;
  late BuildContext _context;
  Stream<List<Review>>? reviews;
  final _reviewTextController = TextEditingController();
  TextEditingController get reviewTextController => _reviewTextController;
  final _complaintReviewTextController = TextEditingController();
  TextEditingController get complaintReviewTextController =>
      _complaintReviewTextController;
  Timer? _timer;

  final _controllerNeedUpdate = StreamController<bool>();
  StreamSubscription? _streamNeedUpdateSubscription;

  TvShowDetailsViewModel(this.tvShowId) {
    adHelper = AdHelper()..loadAd();
    _listenNeedUpdate();
  }

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  String timeAgoFromDate(DateTime date) =>
      timeago.format(date, locale: _locale);

  void showAdIfAvailable() {
    adHelper.showAdIfAvailable();
  }

  Future<void> setupLocale(BuildContext context) async {
    _context = context;
    final locale = Localizations.localeOf(_context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMd(_locale);
    await _loadDetails();
    await _isFavorite();
    await _isWatched();
    connectReviewsStream();
    state.isLoaded = true;
    notifyListeners();
  }

  void _listenNeedUpdate() {
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription =
        _controllerNeedUpdate.stream.listen((needUpdate) {
      if (needUpdate) {
        _timer?.cancel();
        _timer = Timer(const Duration(seconds: 10), () async {
          await _loadDetails();
          await _isFavorite();
          await _isWatched();
          connectReviewsStream();
          state.isLoaded = true;
          notifyListeners();
        });
      }
    });
  }

  void connectReviewsStream() {
    final id = state.tvShowDetails?.externalIds.imdbId;
    if (id != null) {
      reviews = _accountRepository.reviewsStream(id);
    }
  }

  Future<void> sendReview() async {
    final hasConnectivity = await ConnectivityHelper.hasConnectivity();
    final id = state.tvShowDetails?.externalIds.imdbId;
    final text = _reviewTextController.text.trim();
    _reviewTextController.text = text;
    if (text.isNotEmpty && id != null && hasConnectivity) {
      state.isProgressSending = true;
      notifyListeners();
      final filteredText = ProfanityFilterHelper.filter(text);
      final review = Review(review: filteredText, date: DateTime.now());
      _accountRepository.sendReview(mediaId: id, review: review);
      state.isProgressSending = false;
      _reviewTextController.clear();
      FocusManager.instance.primaryFocus?.unfocus();
    }
    notifyListeners();
  }

  Future<void> sendComplaintToReview(Review review) async {
    final hasConnectivity = await ConnectivityHelper.hasConnectivity();
    final text = _complaintReviewTextController.text.trim();
    _complaintReviewTextController.text = text;
    if (hasConnectivity) {
      notifyListeners();
      final complaintReview = ComplaintReview(
        reviewId: review.id!,
        accusedUserId: review.userId!,
        complaintMessage: text,
        reviewMessage: review.review,
      );
      _accountRepository.sendComplaintToReview(complaintReview).then((success) {
        String result = success
            ? S.of(_context).sent_successfully
            : S.of(_context).something_went_wrong;

        DialogWidget.showSnackBar(
          context: _context,
          text: result,
        );
      });
      _complaintReviewTextController.clear();
      FocusManager.instance.primaryFocus?.unfocus();
    }
    notifyListeners();
  }

  void deleteReview(String? reviewId) {
    final id = state.tvShowDetails?.externalIds.imdbId;
    if (reviewId != null && id != null) {
      _accountRepository.deleteReview(mediaId: id, reviewId: reviewId);
    }
  }

  Future<void> _loadDetails() async {
    try {
      TvShowDetails tvShowDetails = await _tvShowRepository.fetchTvShowDetails(
        locale: _locale,
        tvShowId: tvShowId,
      );
      await _updateTvShow(tvShowDetails);
      final tvShowImages =
          await _tvShowRepository.fetchTvShowImages(tvShowId: tvShowId);
      state.tvShowImages = tvShowImages;
      notifyListeners();
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
  }

  Future<void> _updateTvShow(TvShowDetails tvShowDetails) async {
    try {
      final status =
          await _translator.translate(tvShowDetails.status, to: _locale);

      final productionCountries = <ProductionCountrie>[];
      final productionCountriesLength =
          tvShowDetails.productionCountries.length;
      for (var i = 0; i < productionCountriesLength; i++) {
        final countryText = await _translator.translate(
          tvShowDetails.productionCountries[i].name,
          to: _locale,
        );
        productionCountries.add(
          tvShowDetails.productionCountries[i].copyWith(
            name: countryText.text,
          ),
        );
      }

      final keywords = Keywords(keywords: []);
      final keywordsLength = tvShowDetails.keywords.keywords?.length ?? 0;
      for (var i = 0; i < keywordsLength; i++) {
        final keywordText = await _translator.translate(
          tvShowDetails.keywords.keywords![i].name,
          to: _locale,
        );
        keywords.keywords?.add(
          tvShowDetails.keywords.keywords![i].copyWith(
            name: keywordText.text,
          ),
        );
      }

      tvShowDetails = tvShowDetails.copyWith(
        status: status.text,
        productionCountries: productionCountries,
        keywords: keywords,
      );
    } catch (e) {
      print(e);
    }
    state.tvShowDetails = tvShowDetails;
  }

  void enableAdultContent() {
    state.showAdultContent = true;
    notifyListeners();
  }

  Future<void> favoriteTvShow() async {
    final tvShowId = state.tvShowDetails?.externalIds.imdbId;
    if (tvShowId != null) {
      _accountRepository.favoriteTvShow(tvShowId);
      state.isFavorite = !state.isFavorite;
      notifyListeners();
    }
  }

  Future<void> watchTvShow() async {
    final tvShowId = state.tvShowDetails?.externalIds.imdbId;
    if (tvShowId != null) {
      _accountRepository.watchTvShow(tvShowId);
      state.isWatched = !state.isWatched;
      notifyListeners();
    }
  }

  Future<void> _isFavorite() async {
    final tvShowId = state.tvShowDetails?.externalIds.imdbId;
    if (tvShowId != null) {
      final isFavorite = await _accountRepository.isFavoriteTvShow(tvShowId);
      if (isFavorite != null) {
        state.isFavorite = isFavorite;
        notifyListeners();
      }
    }
  }

  Future<void> _isWatched() async {
    final tvShowId = state.tvShowDetails?.externalIds.imdbId;
    if (tvShowId != null) {
      final isWatched = await _accountRepository.isWatchedTvShow(tvShowId);
      if (isWatched != null) {
        state.isWatched = isWatched;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription = null;
    _reviewTextController.dispose();
    _complaintReviewTextController.dispose();
    super.dispose();
  }
}
