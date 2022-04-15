import 'package:flutter/cupertino.dart';
import 'package:movie_night/generated/l10n.dart';

enum MediaType { movie, tv , person }

extension MediaTypeAsString on MediaType {
  String asString(BuildContext context) {
    switch (this) {
      case MediaType.movie:
        return S.of(context).movie;
      case MediaType.tv:
        return S.of(context).tv;
      case MediaType.person:
        return S.of(context).person;
    }
  }
}
