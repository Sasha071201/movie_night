import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:movie_night/application/domain/entities/actor/actor_tagged_images.dart';
import 'package:movie_night/application/repository/account_repository.dart';
import 'package:translator/translator.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/api_client/api_client_exception.dart';
import '../../../domain/connectivity/connectivity_helper.dart';
import '../../../domain/entities/actor/actor_details.dart';
import '../../../domain/entities/actor/actor_images.dart';
import '../../../domain/entities/complaint_review.dart';
import '../../../domain/entities/review.dart';
import '../../../repository/actor_repository.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../utils/profanity_filter.dart';
import '../../themes/app_colors.dart';
import '../../widgets/dialog_widget.dart';

class ActorDetailsState {
  ActorDetails? actorDetails;
  ActorImages? actorImages;
  ActorTaggedImages? actorTaggedImages;
  bool showAdultContent;
  bool isFavorite;
  bool isLoaded;
  bool isProgressSending;

  ActorDetailsState({
    this.actorDetails,
    this.actorImages,
    this.actorTaggedImages,
    this.showAdultContent = false,
    this.isFavorite = false,
    this.isLoaded = false,
    this.isProgressSending = false,
  });
}

class ActorDetailsViewModel extends ChangeNotifier {
  final _translator = GoogleTranslator();
  final _actorRepository = ActorRepository();
  final _accountRepository = AccountRepository();
  final state = ActorDetailsState();
  final int _actorId;
  String _locale = '';
  late BuildContext _context;
  late DateFormat _dateFormat;
  Stream<List<Review>>? reviews;
  final _reviewTextController = TextEditingController();
  TextEditingController get reviewTextController => _reviewTextController;
  final _complaintReviewTextController = TextEditingController();
  TextEditingController get complaintReviewTextController =>
      _complaintReviewTextController;
  Timer? _timer;

  final _controllerNeedUpdate = StreamController<bool>();
  StreamSubscription? _streamNeedUpdateSubscription;

  ActorDetailsViewModel(this._actorId) {
    _listenNeedUpdate();
  }

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  String timeAgoFromDate(DateTime date) =>
      timeago.format(date, locale: _locale);

  Future<void> setupLocale(BuildContext context) async {
    _context = context;
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMd(_locale);
    await _loadDetails();
    await _isFavorite();
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
          connectReviewsStream();
          state.isLoaded = true;
          notifyListeners();
        });
      }
    });
  }

  void connectReviewsStream() {
    final id = state.actorDetails?.externalIds.imdbId;
    if (id != null) {
      reviews = _accountRepository.reviewsStream(id);
    }
  }

  Future<void> sendReview() async {
    final hasConnectivity = await ConnectivityHelper.hasConnectivity();
    final id = state.actorDetails?.externalIds.imdbId;
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
    final id = state.actorDetails?.externalIds.imdbId;
    if (reviewId != null && id != null) {
      _accountRepository.deleteReview(mediaId: id, reviewId: reviewId);
    }
  }

  Future<void> _loadDetails() async {
    try {
      ActorDetails actorDetails = await _actorRepository.fetchActorDetails(
        locale: _locale,
        actorId: _actorId,
      );
      try {
        final country = await _translator
            .translate(actorDetails.placeOfBirth ?? '', to: _locale);
        actorDetails = actorDetails.copyWith(placeOfBirth: country.text);
      } catch (e) {
        print(e);
      }
      final actorImages =
          await _actorRepository.fetchActorImages(actorId: _actorId);
      final actorTaggedImages = await _actorRepository.fetchActorTaggedImages(
          actorId: _actorId, page: 1);
      state.actorDetails = actorDetails;
      actorDetails.combinedCredits.cast = actorDetails.combinedCredits.cast
        ..sort((a, b) {
          final date1 = a.releaseDate;
          final date2 = b.releaseDate;
          if (date1 == null && date2 == null) {
            return 0;
          } else if (date1 == null) {
            return 1;
          } else if (date2 == null) {
            return -1;
          }
          return date2.compareTo(date1);
        });
      actorDetails.combinedCredits.crew = actorDetails.combinedCredits.crew
        ..sort((a, b) {
          final date1 = a.releaseDate;
          final date2 = b.releaseDate;
          if (date1 == null && date2 == null) {
            return 0;
          } else if (date1 == null) {
            return 1;
          } else if (date2 == null) {
            return -1;
          }
          return date2.compareTo(date1);
        });
      state.actorImages = actorImages;
      state.actorTaggedImages = actorTaggedImages;
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

  void enableAdultContent() {
    state.showAdultContent = true;
    notifyListeners();
  }

  Future<void> favoritePerson() async {
    final actorId = state.actorDetails?.externalIds.imdbId;
    if (actorId != null) {
      _accountRepository.favoritePerson(actorId);
      state.isFavorite = !state.isFavorite;
      notifyListeners();
    }
  }

  Future<void> _isFavorite() async {
    try {
      final actorId = state.actorDetails?.externalIds.imdbId;
      if (actorId != null) {
        final isFavorite = await _accountRepository.isFavoritePerson(actorId);
        if (isFavorite != null) {
          state.isFavorite = isFavorite;
          notifyListeners();
        }
      }
    } catch (e) {}
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription = null;
    _complaintReviewTextController.dispose();
    _reviewTextController.dispose();
    super.dispose();
  }
}
