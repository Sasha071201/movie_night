import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:movie_night/application/domain/api_client/api_client_exception.dart';
import 'package:movie_night/application/domain/connectivity/connectivity_helper.dart';
import 'package:movie_night/application/domain/entities/complaint_review.dart';

import 'package:movie_night/application/domain/entities/movie/movie_images.dart';
import 'package:movie_night/application/domain/entities/review.dart';
import 'package:movie_night/application/repository/movie_repository.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';
import 'package:movie_night/application/ui/widgets/dialog_widget.dart';
import 'package:translator/translator.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/ad_mob/ad_helper.dart';
import '../../../domain/entities/movie/movie_details.dart';
import '../../../repository/account_repository.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../utils/profanity_filter.dart';
import '../../themes/app_colors.dart';

class MovieDetailsState {
  MovieDetails? movieDetails;
  MovieImages? movieImages;
  bool showAdultContent;
  bool isFavorite;
  bool isWatched;
  bool isLoaded;
  bool isProgressSending;

  MovieDetailsState({
    this.movieDetails,
    this.movieImages,
    this.showAdultContent = false,
    this.isFavorite = false,
    this.isWatched = false,
    this.isLoaded = false,
    this.isProgressSending = false,
  });
}

class MovieDetailsViewModel extends ChangeNotifier {
  final _movieRepository = MovieRepository();
  final _accountRepository = AccountRepository();
  final _translator = GoogleTranslator();
  final state = MovieDetailsState();
  final int movieId;
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

  MovieDetailsViewModel(this.movieId) {
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
        _controllerNeedUpdate.stream.listen((needUpdate) async {
      if (needUpdate) {
        await _loadDetails();
        await _isFavorite();
        await _isWatched();
        connectReviewsStream();
        state.isLoaded = true;
        notifyListeners();
      }
    });
  }

  void connectReviewsStream() {
    final id = state.movieDetails?.externalIds?.imdbId;
    if (id != null) {
      reviews = _accountRepository.reviewsStream(id);
    }
  }

  Future<void> _loadDetails() async {
    try {
      MovieDetails movieDetails = await _movieRepository.fetchMovieDetails(
        locale: _locale,
        movieId: movieId,
      );
      await _updateMovie(movieDetails);
      final movieImages =
          await _movieRepository.fetchMovieImages(movieId: movieId);
      state.movieImages = movieImages;
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

  Future<void> _updateMovie(MovieDetails movieDetails) async {
    try {
      final status =
          await _translator.translate(movieDetails.status ?? '', to: _locale);

      final productionCountries = <ProductionCountrie>[];
      final productionCountriesLength =
          movieDetails.productionCountries?.length ?? 0;
      for (var i = 0; i < productionCountriesLength; i++) {
        final countryText = await _translator.translate(
          movieDetails.productionCountries![i].name,
          to: _locale,
        );
        productionCountries.add(
          movieDetails.productionCountries![i].copyWith(
            name: countryText.text,
          ),
        );
      }

      final keywords = Keywords(keywords: []);
      final keywordsLength = movieDetails.keywords?.keywords.length ?? 0;
      for (var i = 0; i < keywordsLength; i++) {
        final keywordText = await _translator.translate(
          movieDetails.keywords?.keywords[i].name ?? '',
          to: _locale,
        );
        keywords.keywords.add(
          movieDetails.keywords!.keywords[i].copyWith(name: keywordText.text),
        );
      }
      movieDetails = movieDetails.copyWith(
        status: status.text,
        productionCountries: productionCountries,
        keywords: keywords,
      );
    } catch (e) {
      print(e);
    }
    state.movieDetails = movieDetails;
  }

  void enableAdultContent() {
    state.showAdultContent = true;
    notifyListeners();
  }

  Future<void> sendReview() async {
    final hasConnectivity = await ConnectivityHelper.hasConnectivity();
    final id = state.movieDetails?.externalIds?.imdbId;
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
    final id = state.movieDetails?.externalIds?.imdbId;
    if (reviewId != null && id != null) {
      _accountRepository.deleteReview(mediaId: id, reviewId: reviewId);
    }
  }

  void playTrailer(BuildContext context) {
    final trailer = state.movieDetails?.videos?.results.firstWhere((element) =>
        element != null && element.site == 'YouTube' && element.key.isNotEmpty);
    if (trailer != null) {
      Navigator.of(context).pushNamed(
        Screens.trailer,
        arguments: trailer.key,
      );
    }
  }

  Future<void> favoriteMovie() async {
    final movieId = state.movieDetails?.externalIds?.imdbId;
    if (movieId != null) {
      _accountRepository.favoriteMovie(movieId);
      state.isFavorite = !state.isFavorite;
      notifyListeners();
    }
  }

  Future<void> watchMovie() async {
    final movieId = state.movieDetails?.externalIds?.imdbId;
    if (movieId != null) {
      _accountRepository.watchMovie(movieId);
      state.isWatched = !state.isWatched;
      notifyListeners();
    }
  }

  Future<void> _isFavorite() async {
    final movieId = state.movieDetails?.externalIds?.imdbId;
    if (movieId != null) {
      final isFavorite = await _accountRepository.isFavoriteMovie(movieId);
      if (isFavorite != null) {
        state.isFavorite = isFavorite;
        notifyListeners();
      }
    }
  }

  Future<void> _isWatched() async {
    final movieId = state.movieDetails?.externalIds?.imdbId;
    if (movieId != null) {
      final isWatched = await _accountRepository.isWatchedMovie(movieId);
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
