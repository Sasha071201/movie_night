import 'package:flutter/cupertino.dart';

import '../../../generated/l10n.dart';

enum SortBy {
  popularityAsc,
  popularityDesc,
  releaseDateAsc,
  releaseDateDesc,
  revenueAsc,
  revenueDesc,
  primaryReleaseDateAsc,
  primaryReleaseDateDesc,
  originalTitleAsc,
  originalTitleDesc,
  voteAverageAsc,
  voteAverageDesc,
  voteCountAsc,
  voteCountDesc,
}

extension SortByAsString on SortBy {
  String asString(BuildContext context) {
    switch (this) {
      case SortBy.popularityAsc:
        return S.of(context).popularity_asc;
      case SortBy.popularityDesc:
        return S.of(context).popularity_desc;
      case SortBy.releaseDateAsc:
        return S.of(context).release_date_asc;
      case SortBy.releaseDateDesc:
        return S.of(context).release_date_desc;
      case SortBy.revenueAsc:
        return S.of(context).revenue_asc;
      case SortBy.revenueDesc:
        return S.of(context).revenue_desc;
      case SortBy.primaryReleaseDateAsc:
        return S.of(context).primary_release_date_asc;
      case SortBy.primaryReleaseDateDesc:
        return S.of(context).primary_release_date_desc;
      case SortBy.originalTitleAsc:
        return S.of(context).original_title_asc;
      case SortBy.originalTitleDesc:
        return S.of(context).original_title_desc;
      case SortBy.voteAverageAsc:
        return S.of(context).vote_average_asc;
      case SortBy.voteAverageDesc:
        return S.of(context).vote_average_desc;
      case SortBy.voteCountAsc:
        return S.of(context).vote_count_asc;
      case SortBy.voteCountDesc:
        return S.of(context).vote_count_desc;
    }
  }
  
  String asApiString() {
    switch (this) {
      case SortBy.popularityAsc:
        return 'popularity.asc';
      case SortBy.popularityDesc:
        return 'popularity.desc';
      case SortBy.releaseDateAsc:
        return 'release_date.asc';
      case SortBy.releaseDateDesc:
        return 'release_date.desc';
      case SortBy.revenueAsc:
        return 'revenue.asc';
      case SortBy.revenueDesc:
        return 'revenue.desc';
      case SortBy.primaryReleaseDateAsc:
        return 'primary_release_date.asc';
      case SortBy.primaryReleaseDateDesc:
        return 'primary_release_date.desc';
      case SortBy.originalTitleAsc:
        return 'original_title.asc';
      case SortBy.originalTitleDesc:
        return 'original_title.desc';
      case SortBy.voteAverageAsc:
        return 'vote_average.asc';
      case SortBy.voteAverageDesc:
        return 'vote_average.desc';
      case SortBy.voteCountAsc:
        return 'vote_count.asc';
      case SortBy.voteCountDesc:
        return 'vote_count.desc';
    }
  }
}
