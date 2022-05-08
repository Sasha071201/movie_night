import 'package:flutter/cupertino.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show_genres.dart';

import '../../../generated/l10n.dart';
import 'movie/movie_genres.dart';

class Genre {
  final dynamic genre;
  Genre({
    required this.genre,
  });

  int? asIndex() {
    if (genre is MovieGenres) {
      return (genre as MovieGenres).index;
    } else if (genre is TvShowGenres) {
      return (genre as TvShowGenres).index;
    }
    return null;
  }

  String asString(BuildContext context) {
    if (genre is MovieGenres) {
      switch (genre) {
        case MovieGenres.action:
          return S.of(context).action;
        case MovieGenres.adventure:
          return S.of(context).adventure;
        case MovieGenres.animation:
          return S.of(context).animation;
        case MovieGenres.comedy:
          return S.of(context).comedy;
        case MovieGenres.crime:
          return S.of(context).crime;
        case MovieGenres.documentary:
          return S.of(context).documentary;
        case MovieGenres.drama:
          return S.of(context).drama;
        case MovieGenres.family:
          return S.of(context).family;
        case MovieGenres.fantasy:
          return S.of(context).fantasy;
        case MovieGenres.history:
          return S.of(context).history;
        case MovieGenres.horror:
          return S.of(context).horror;
        case MovieGenres.music:
          return S.of(context).music;
        case MovieGenres.mystery:
          return S.of(context).mystery;
        case MovieGenres.romance:
          return S.of(context).romance;
        case MovieGenres.scienceFiction:
          return S.of(context).science_fiction;
        case MovieGenres.tVMovie:
          return S.of(context).tv_movie;
        case MovieGenres.thriller:
          return S.of(context).thriller;
        case MovieGenres.war:
          return S.of(context).war;
        case MovieGenres.western:
          return S.of(context).western;
      }
    } else if (genre is TvShowGenres) {
      switch (genre) {
        case TvShowGenres.actionAndAdventure:
          return S.of(context).action_and_adventure;
        case TvShowGenres.animation:
          return S.of(context).animation;
        case TvShowGenres.comedy:
          return S.of(context).comedy;
        case TvShowGenres.crime:
          return S.of(context).crime;
        case TvShowGenres.documentary:
          return S.of(context).documentary;
        case TvShowGenres.drama:
          return S.of(context).drama;
        case TvShowGenres.family:
          return S.of(context).family;
        case TvShowGenres.news:
          return S.of(context).news;
        case TvShowGenres.mystery:
          return S.of(context).mystery;
        case TvShowGenres.western:
          return S.of(context).western;
        case TvShowGenres.kids:
          return S.of(context).kids;
        case TvShowGenres.reality:
          return S.of(context).reality;
        case TvShowGenres.sciFiAndFantasy:
          return S.of(context).sciFiAndFantasy;
        case TvShowGenres.soap:
          return S.of(context).soap;
        case TvShowGenres.talk:
          return S.of(context).talk;
        case TvShowGenres.warAndPolitics:
          return S.of(context).war_and_politics;
      }
    }
    return '';
  }

  int? asId() {
    if (genre is MovieGenres) {
      switch (genre) {
        case MovieGenres.action:
          return 28;
        case MovieGenres.adventure:
          return 12;
        case MovieGenres.animation:
          return 16;
        case MovieGenres.comedy:
          return 35;
        case MovieGenres.crime:
          return 80;
        case MovieGenres.documentary:
          return 99;
        case MovieGenres.drama:
          return 18;
        case MovieGenres.family:
          return 10751;
        case MovieGenres.fantasy:
          return 14;
        case MovieGenres.history:
          return 36;
        case MovieGenres.horror:
          return 27;
        case MovieGenres.music:
          return 10402;
        case MovieGenres.mystery:
          return 9648;
        case MovieGenres.romance:
          return 10749;
        case MovieGenres.scienceFiction:
          return 878;
        case MovieGenres.tVMovie:
          return 10770;
        case MovieGenres.thriller:
          return 53;
        case MovieGenres.war:
          return 10752;
        case MovieGenres.western:
          return 37;
      }
    } else if (genre is TvShowGenres) {
      switch (genre) {
        case TvShowGenres.actionAndAdventure:
          return 10759;
        case TvShowGenres.animation:
          return 16;
        case TvShowGenres.comedy:
          return 35;
        case TvShowGenres.crime:
          return 80;
        case TvShowGenres.documentary:
          return 99;
        case TvShowGenres.drama:
          return 18;
        case TvShowGenres.family:
          return 10751;
        case TvShowGenres.kids:
          return 10762;
        case TvShowGenres.mystery:
          return 9648;
        case TvShowGenres.news:
          return 10763;
        case TvShowGenres.reality:
          return 10764;
        case TvShowGenres.sciFiAndFantasy:
          return 10765;
        case TvShowGenres.soap:
          return 10766;
        case TvShowGenres.talk:
          return 10767;
        case TvShowGenres.warAndPolitics:
          return 10768;
        case TvShowGenres.western:
          return 37;
      }
    }
    return null;
  }

  static dynamic fromIdToGenre(int id) {
      switch (id) {
        case 28:
          return MovieGenres.action;
        case 12:
          return MovieGenres.adventure;
        case 16:
          return MovieGenres.animation;
        case 35:
          return MovieGenres.comedy;
        case 80:
          return MovieGenres.crime;
        case 99:
          return MovieGenres.documentary;
        case 18:
          return MovieGenres.drama;
        case 10751:
          return MovieGenres.family;
        case 14:
          return MovieGenres.fantasy;
        case 36:
          return MovieGenres.history;
        case 27:
          return MovieGenres.horror;
        case 10402:
          return MovieGenres.music;
        case 9648:
          return MovieGenres.mystery;
        case 10749:
          return MovieGenres.romance;
        case 878:
          return MovieGenres.scienceFiction;
        case 10770:
          return MovieGenres.tVMovie;
        case 53:
          return MovieGenres.thriller;
        case 10752:
          return MovieGenres.war;
        case 37:
          return MovieGenres.western;
        case 10759:
          return TvShowGenres.actionAndAdventure;
        case 16:
          return TvShowGenres.animation;
        case 35:
          return TvShowGenres.comedy;
        case 80:
          return TvShowGenres.crime;
        case 99:
          return TvShowGenres.documentary;
        case 18:
          return TvShowGenres.drama;
        case 10751:
          return TvShowGenres.family;
        case 10762:
          return TvShowGenres.kids;
        case 9648:
          return TvShowGenres.mystery;
        case 10763:
          return TvShowGenres.news;
        case 10764:
          return TvShowGenres.reality;
        case 10765:
          return TvShowGenres.sciFiAndFantasy;
        case 10766:
          return TvShowGenres.soap;
        case 10767:
          return TvShowGenres.talk;
        case 10768:
          return TvShowGenres.warAndPolitics;
        case 37:
          return TvShowGenres.western;
      }
  }
}
