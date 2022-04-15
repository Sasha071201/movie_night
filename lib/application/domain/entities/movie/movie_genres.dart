import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../../../generated/l10n.dart';

enum MovieGenres {
  action,
  adventure,
  animation,
  comedy,
  crime,
  documentary,
  drama,
  family,
  fantasy,
  history,
  horror,
  music,
  mystery,
  romance,
  scienceFiction,
  tVMovie,
  thriller,
  war,
  western,
}

extension MovieGenreAsString on MovieGenres {
  String asString(BuildContext context) {
    switch (this) {
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
  }

  int asId() {
    switch (this) {
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
  }

  
}

MovieGenres getRandomGenre() {
  Random random = Random();
  int index = random.nextInt(MovieGenres.values.length);
  return MovieGenres.values[index];
}
