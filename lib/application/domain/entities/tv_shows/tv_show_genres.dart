import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../../../generated/l10n.dart';

enum TvShowGenres {
  actionAndAdventure,
  animation,
  comedy,
  crime,
  documentary,
  drama,
  family,
  kids,
  mystery,
  news,
  reality,
  sciFiAndFantasy,
  soap,
  talk,
  warAndPolitics,
  western,
}

extension MovieGenreAsString on TvShowGenres {
  String asString(BuildContext context) {
    switch (this) {
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
        return S.of(context).fantasy;
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

  int asId() {
    switch (this) {
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
}

TvShowGenres getRandomGenre() {
  Random random = Random();
  int index = random.nextInt(TvShowGenres.values.length);
  return TvShowGenres.values[index];
}
