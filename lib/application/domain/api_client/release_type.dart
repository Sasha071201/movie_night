import 'package:flutter/cupertino.dart';

import '../../../generated/l10n.dart';

enum ReleaseType {
  premier,
  theatricalLimited,
  theatrical,
  digital,
  physical,
  tv
}

extension AsString on ReleaseType {
  String asString(BuildContext context) {
    switch (this) {
      case ReleaseType.premier:
        return S.of(context).premier;
      case ReleaseType.theatricalLimited:
        return S.of(context).theatrical_limited;
      case ReleaseType.theatrical:
        return S.of(context).theatrical;
      case ReleaseType.digital:
        return S.of(context).digital;
      case ReleaseType.physical:
        return S.of(context).physical;
      case ReleaseType.tv:
        return S.of(context).tv;
    }
  }

  String asApiString() {
    switch (this) {
      case ReleaseType.premier:
        return '1';
      case ReleaseType.theatricalLimited:
        return '2';
      case ReleaseType.theatrical:
        return '3';
      case ReleaseType.digital:
        return '4';
      case ReleaseType.physical:
        return '5';
      case ReleaseType.tv:
        return '6';
    }
  }
}
