import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/entities/actor/actor.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/api_client/media_type.dart';
import '../../../domain/entities/media.dart';
import '../../../domain/entities/movie/movie.dart';
import '../../../domain/entities/tv_shows/tv_show.dart';
import '../../../repository/account_repository.dart';

enum ViewFavoriteType { favorite, favoriteAndNotWatched, watched }

extension ViewMediaTypeString on ViewFavoriteType {
  asString(BuildContext context) {
    switch (this) {
      case ViewFavoriteType.favorite:
        return S.of(context).favorite;
      case ViewFavoriteType.watched:
        return S.of(context).watched;
      case ViewFavoriteType.favoriteAndNotWatched:
        return S.of(context).favorite_and_not_watched;
    }
  }
}

class ViewFavoriteData {
  final MediaType mediaType;
  final ViewFavoriteType favoriteType;
  ViewFavoriteData({
    required this.mediaType,
    required this.favoriteType,
  });
}

class ViewFavoriteState {
  late Media media;
  bool isLoadingProgress = false;
}

class ViewFavoriteViewModel extends ChangeNotifier {
  final _repository = AccountRepository();
  final ViewFavoriteState state;
  final ViewFavoriteData data;
  String _locale = '';
  StreamSubscription? _streamSubscription;

  ViewFavoriteViewModel(this.data)
      : state = ViewFavoriteState()
          ..media = Media(mediaType: data.mediaType, media: []);

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _streamSubscription?.cancel();
    _streamSubscription = StreamGroup.merge([
      _repository.favoriteStream(),
      _repository.watchedStream(),
    ]).listen((event) {
      _refresh();
    });
  }

  Future<void> _refresh() async {
    await resetAll();
    notifyListeners();
  }

  Future<void> resetAll() async {
    state.media.media.clear();
    await _loadFavorite();
  }

  Future<void> _loadFavorite() async {
    if (state.isLoadingProgress) return;
    state.isLoadingProgress = true;
    notifyListeners();

    try {
      await _fetchFavorite();
      state.isLoadingProgress = false;
    } catch (e) {
      state.isLoadingProgress = false;
    }
    notifyListeners();
  }

  Future<void> _fetchFavorite() async {
    if (state.media.mediaType == MediaType.movie) {
      late final moviesResponse;
      if (data.favoriteType == ViewFavoriteType.favorite) {
        moviesResponse = await _repository.fetchFavoriteMovies(_locale, null);
      } else if (data.favoriteType == ViewFavoriteType.favoriteAndNotWatched) {
        moviesResponse =
            await _repository.fetchFavoriteAndNotWatchedMovies(_locale, null);
      } else if (data.favoriteType == ViewFavoriteType.watched) {
        moviesResponse = await _repository.fetchWatchedMovies(_locale, null);
      }
      final movieNewAndOld = List<Movie>.from(state.media.media);
      movieNewAndOld.addAll(moviesResponse);
      state.media.media = movieNewAndOld;
    } else if (state.media.mediaType == MediaType.tv) {
      late final tvShowsResponse;
      if (data.favoriteType == ViewFavoriteType.favorite) {
        tvShowsResponse = await _repository.fetchFavoriteTvShows(_locale, null);
      } else if (data.favoriteType == ViewFavoriteType.favoriteAndNotWatched) {
        tvShowsResponse =
            await _repository.fetchFavoriteAndNotWatchedTvShows(_locale, null);
      } else if (data.favoriteType == ViewFavoriteType.watched) {
        tvShowsResponse = await _repository.fetchWatchedTvShows(_locale, null);
      }
      final mediaNewAndOld = List<TvShow>.from(state.media.media);
      mediaNewAndOld.addAll(tvShowsResponse);
      state.media.media = mediaNewAndOld;
    } else if (state.media.mediaType == MediaType.person) {
      final peopleResponse = await _repository.fetchFavoritePeople(_locale, null);
      final mediaNewAndOld = List<Actor>.from(state.media.media);
      mediaNewAndOld.addAll(peopleResponse);
      state.media.media = mediaNewAndOld;
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
    super.dispose();
  }
}
