import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movie_night/application/constants/app_dimensions.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';
import 'package:movie_night/application/ui/screens/tv_show_details/tv_show_details_view_model.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/widgets/details/chips_with_header_widget.dart';
import 'package:movie_night/application/ui/widgets/details/media_widget.dart';
import 'package:movie_night/application/ui/widgets/details/overview_widget.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/api_client/image_downloader.dart';
import '../../../domain/api_client/media_type.dart';
import '../../../domain/entities/genre.dart';
import '../../../domain/entities/tv_shows/tv_show_details.dart';
import '../../themes/app_text_style.dart';
import '../../widgets/adult_onboarding_widget.dart';
import '../../widgets/cached_network_image_widget.dart';
import '../../widgets/details/buttons_widget.dart';
import '../../widgets/details/external_sources_widget.dart';
import '../../widgets/details/list_credits_complex_widget.dart';
import '../../widgets/details/list_credits_simple_widget.dart';
import '../../widgets/details/row_main_info_widget.dart';
import '../../widgets/details/tagline_widget.dart';
import '../../widgets/details/title_widget.dart';
import '../../widgets/header_poster_widget.dart';
import '../../widgets/inkwell_material_widget.dart';
import '../../widgets/review_sliver_widget.dart';
import '../../widgets/review_text_field_widget.dart';
import '../../widgets/vertical_widgets_with_header/tv_shows_with_header_widget.dart';
import '../view_all_movies/view_all_movies_view_model.dart';
import '../view_movies/view_movies_view_model.dart';

class TvShowDetailsScreen extends StatefulWidget {
  const TvShowDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TvShowDetailsScreen> createState() => _TvShowDetailsScreenState();
}

class _TvShowDetailsScreenState extends State<TvShowDetailsScreen> {
  @override
  void didChangeDependencies() async {
    await context.read<TvShowDetailsViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<TvShowDetailsViewModel>();
    final showAdultContent = context
        .select((TvShowDetailsViewModel vm) => vm.state.showAdultContent);
    final tvShow =
        context.select((TvShowDetailsViewModel vm) => vm.state.tvShowDetails);
    final isLoaded =
        context.select((TvShowDetailsViewModel vm) => vm.state.isLoaded);
    return Scaffold(
      body: SafeArea(
        child: tvShow != null && isLoaded
            ? CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        AdultOnboardingWidget(
                          onPressed: vm.enableAdultContent,
                          show: tvShow.adult && !showAdultContent,
                          child: Column(
                            children: const [
                              _HeaderPosterWidget(),
                              _TvShowDetailsWidget(),
                              SizedBox(height: 8),
                              _MediaWidget(),
                              SizedBox(height: 8),
                              _SeasonsWidget(),
                              _ListCastWidget(),
                              _ListCrewWidget(),
                              _CreatedByWidget(),
                              Divider(
                                height: 1,
                                color: AppColors.colorSecondaryText,
                              ),
                              _SimilarWidget(),
                              _RecommendationWidget(),
                              SizedBox(height: 8),
                              Divider(
                                height: 1,
                                color: AppColors.colorSecondaryText,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                S.of(context).reviews,
                                style: AppTextStyle.header3,
                              ),
                              const SizedBox(height: 8),
                              const _ReviewTextFieldWidget(),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const _ReviewsWidget(),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const _BottomPaddingWidget(),
                      ],
                    ),
                  ),
                ],
              )
            : const Center(
                child: RepaintBoundary(
                  child: CircularProgressIndicator(
                    color: AppColors.colorMainText,
                  ),
                ),
              ),
      ),
    );
  }
}

class _ReviewTextFieldWidget extends StatelessWidget {
  const _ReviewTextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<TvShowDetailsViewModel>();
    final isProgressSending = context
        .select((TvShowDetailsViewModel vm) => vm.state.isProgressSending);
    return ReviewTextFieldWidget(
      isProgressSending: isProgressSending,
      sendReview: vm.sendReview,
      controller: vm.reviewTextController,
    );
  }
}

class _ReviewsWidget extends StatelessWidget {
  const _ReviewsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<TvShowDetailsViewModel>();
    final reviews = context.select((TvShowDetailsViewModel vm) => vm.reviews);
    return ReviewsSliverWidget(
      reviews: reviews,
      timeAgoFromDate: vm.timeAgoFromDate,
      deleteReview: vm.deleteReview,
      complaintReviewTextController: vm.complaintReviewTextController,
      sendComplaintToReview: vm.sendComplaintToReview,
    );
  }
}

class _BottomPaddingWidget extends StatelessWidget {
  const _BottomPaddingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final insetsBottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
        padding: EdgeInsets.only(
            bottom: insetsBottom == 0 ? 32 : insetsBottom + 16));
  }
}

class _ListCrewWidget extends StatelessWidget {
  const _ListCrewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crew = context.select((TvShowDetailsViewModel vm) =>
        vm.state.tvShowDetails!.aggregateCredits.crew);
    final list = crew
        .map(
          (item) => CreditsItemComplexData(
            id: item.id,
            name: item.name,
            posterPath: item.profilePath ?? '',
            list: item.jobs
                .map((job) => MapEntry(job.job, job.episodeCount))
                .toList(),
          ),
        )
        .toList();
    final data = ListCreditsComplexData(
      title: S.of(context).crew,
      list: list,
    );
    return ListCreditsComplexWidget(
      data: data,
    );
  }
}

class _RecommendationWidget extends StatelessWidget {
  const _RecommendationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final details = context.read<TvShowDetailsViewModel>();
    final recommendations = context.select(
        (TvShowDetailsViewModel vm) => vm.state.tvShowDetails?.recommendations);
    return recommendations != null && recommendations.results.isNotEmpty
        ? TvShowsWithHeaderWidget(
            tvShowData: TvShowWithHeaderData(
              title: S.of(context).recommendation,
              list: recommendations.results,
              viewMediaType: ViewMediaType.recommendation,
              tvShowId: details.tvShowId,
            ),
            onPressed: () =>
                context.read<TvShowDetailsViewModel>().showAdIfAvailable(),
          )
        : const SizedBox.shrink();
  }
}

class _SimilarWidget extends StatelessWidget {
  const _SimilarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final details = context.read<TvShowDetailsViewModel>();
    final similar = context
        .select((TvShowDetailsViewModel vm) => vm.state.tvShowDetails?.similar);
    return similar != null && similar.results.isNotEmpty
        ? TvShowsWithHeaderWidget(
            tvShowData: TvShowWithHeaderData(
              title: S.of(context).similar,
              list: similar.results,
              viewMediaType: ViewMediaType.similar,
              tvShowId: details.tvShowId,
            ),
            onPressed: () =>
                context.read<TvShowDetailsViewModel>().showAdIfAvailable(),
          )
        : const SizedBox.shrink();
  }
}

class _TvShowDetailsWidget extends StatelessWidget {
  const _TvShowDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _TitleWidget(),
          SizedBox(height: 8),
          _ButtonsWidget(),
          SizedBox(height: 8),
          _RowMainInfoWidget(),
          SizedBox(height: 8),
          _GenresWidget(),
          SizedBox(height: 8),
          _TaglineWidget(),
          SizedBox(height: 8),
          _OverviewWidget(),
          SizedBox(height: 8),
          _ProductionCountriesWidget(),
          SizedBox(height: 8),
          _ProductionCompaniesWidget(),
          SizedBox(height: 8),
          _KeywordsWidget(),
          SizedBox(height: 8),
          _ExternalSourcesWidget(),
        ],
      ),
    );
  }
}

class _SeasonsWidget extends StatelessWidget {
  const _SeasonsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvShowId = context
        .select((TvShowDetailsViewModel vm) => vm.state.tvShowDetails?.id);
    final seasons = context
        .select((TvShowDetailsViewModel vm) => vm.state.tvShowDetails?.seasons);
    return seasons != null && tvShowId != null && seasons.isNotEmpty == true
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: AppDimensions.mediumPadding),
                child: Text(
                  S.of(context).seasons,
                  style: AppTextStyle.header3,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 230,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.largePadding,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: seasons.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final item = seasons[index];
                    return Align(
                      alignment: Alignment.topCenter,
                      child: SeasonWidget(
                        season: item,
                        tvShowId: tvShowId,
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

class SeasonWidget extends StatelessWidget {
  final int tvShowId;
  final Season season;
  const SeasonWidget({
    Key? key,
    required this.tvShowId,
    required this.season,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWellMaterialWidget(
      onTap: () => Navigator.of(context).pushNamed(Screens.seasonDetails,
          arguments: [season.seasonNumber, tvShowId]),
      borderRadius: AppDimensions.radius5,
      color: AppColors.colorSplash,
      child: SizedBox(
        width: 120,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radius5),
              child: Stack(
                children: [
                  CachedNetworkImageWidget(
                    height: 180,
                    imageUrl: ImageDownloader.imageUrl(season.posterPath ?? ''),
                  ),
                  if (season.airDate?.year != null)
                    Positioned(
                      right: 4,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: AppColors.colorPrimary,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radius5,
                          ),
                        ),
                        child: Text(
                          '${season.airDate?.year ?? ''}',
                          style: AppTextStyle.subheader2,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Text(
              season.name,
              style: AppTextStyle.small.copyWith(
                color: AppColors.colorMainText,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final overview = context.select(
        (TvShowDetailsViewModel vm) => vm.state.tvShowDetails?.overview);
    return LargeTextWithHeaderWidget(
      header: S.of(context).description,
      overview: overview ?? '',
    );
  }
}

class _ExternalSourcesWidget extends StatelessWidget {
  const _ExternalSourcesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final externalIds = context.select(
        (TvShowDetailsViewModel vm) => vm.state.tvShowDetails!.externalIds);
    final allIsNull = (externalIds.facebookId ?? '').isEmpty &&
        (externalIds.instagramId ?? '').isEmpty &&
        (externalIds.twitterId ?? '').isEmpty;
    final data = [
      ExternalSourcesData(
        type: ExternalSourcesType.facebook,
        source: externalIds.facebookId ?? '',
      ),
      ExternalSourcesData(
        type: ExternalSourcesType.instagram,
        source: externalIds.instagramId ?? '',
      ),
      ExternalSourcesData(
        type: ExternalSourcesType.twitter,
        source: externalIds.twitterId ?? '',
      ),
    ];
    return ExternalSourcesWidget(allIsNull: allIsNull, data: data);
  }
}

class _ProductionCompaniesWidget extends StatelessWidget {
  const _ProductionCompaniesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productionCompanies = context.select((TvShowDetailsViewModel vm) =>
        vm.state.tvShowDetails!.productionCompanies);
    return ChipsWithHeaderWidget(
      title: S.of(context).production_companies,
      data: productionCompanies.map((data) => data.name).toList(),
      onPressed: (index) {},
    );
  }
}

class _ProductionCountriesWidget extends StatelessWidget {
  const _ProductionCountriesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productionCountries = context.select((TvShowDetailsViewModel vm) =>
        vm.state.tvShowDetails!.productionCountries);
    return ChipsWithHeaderWidget(
      title: S.of(context).production_countries,
      data: productionCountries.map((data) => data.name).toList(),
      onPressed: (index) {},
    );
  }
}

class _KeywordsWidget extends StatelessWidget {
  const _KeywordsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keywords = context.select(
        (TvShowDetailsViewModel vm) => vm.state.tvShowDetails?.keywords);
    return ChipsWithHeaderWidget(
      title: 'Keywords',
      data: keywords?.keywords?.map((keyword) => keyword.name).toList(),
      onPressed: (index) {},
    );
  }
}

class _TaglineWidget extends StatelessWidget {
  const _TaglineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tagline = context
        .select((TvShowDetailsViewModel vm) => vm.state.tvShowDetails!.tagline);
    return TaglineWidget(
      tagline: tagline,
    );
  }
}

class _MediaWidget extends StatelessWidget {
  const _MediaWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backdrops = context.select(
        (TvShowDetailsViewModel vm) => vm.state.tvShowImages?.backdrops);
    return MediaWidget(
      aspectRatios: backdrops
          ?.map(
            (backdrop) => backdrop.aspectRatio,
          )
          .toList(),
      backdrops: backdrops
          ?.map(
            (backdrop) => backdrop.filePath ?? '',
          )
          .toList(),
    );
  }
}

class _CreatedByWidget extends StatelessWidget {
  const _CreatedByWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final createdBy = context.select(
        (TvShowDetailsViewModel vm) => vm.state.tvShowDetails!.createdBy);
    final list = createdBy
        .map(
          (item) => CreditsItemSimpleData(
            id: item.id,
            name: item.name,
            posterPath: item.profilePath ?? '',
          ),
        )
        .toList();
    final data = ListCreditsSimpleData(
      title: S.of(context).creators,
      list: list,
    );
    return ListCreditsSimpleWidget(
      data: data,
    );
  }
}

class _ListCastWidget extends StatelessWidget {
  const _ListCastWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cast = context.select((TvShowDetailsViewModel vm) =>
        vm.state.tvShowDetails!.aggregateCredits.cast);
    final list = cast
        .map(
          (item) => CreditsItemComplexData(
            id: item.id,
            name: item.name,
            posterPath: item.profilePath ?? '',
            list: item.roles
                .map((job) => MapEntry(job.character, job.episodeCount))
                .toList(),
          ),
        )
        .toList();
    final data = ListCreditsComplexData(
      title: S.of(context).cast,
      list: list,
    );
    return ListCreditsComplexWidget(
      data: data,
    );
  }
}

class _GenresWidget extends StatelessWidget {
  const _GenresWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genres = context
        .select((TvShowDetailsViewModel vm) => vm.state.tvShowDetails!.genres);
    return ChipsWithHeaderWidget(
        title: S.of(context).genres,
        data: genres.map((genre) => genre.name).toList(),
        onPressed: (index) {
          context.read<TvShowDetailsViewModel>().showAdIfAvailable();
          final genre = Genre.fromIdToGenre(genres[index].id);
          Navigator.of(context).pushNamed(Screens.viewAllMovies, arguments: [
            ViewAllMoviesData(
              withGenres: [
                Genre(genre: genre),
              ],
            ),
            MediaType.tv,
          ]);
        });
  }
}

class _RowMainInfoWidget extends StatelessWidget {
  const _RowMainInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<TvShowDetailsViewModel>();
    final tvShow =
        context.select((TvShowDetailsViewModel vm) => vm.state.tvShowDetails);
    final tvShowInfoData = <RowMainInfoData>[
      RowMainInfoData(
        icon: Icons.calendar_month,
        title:
            '${S.of(context).release_date}: ${vm.stringFromDate(tvShow?.firstAirDate)}',
      ),
      if (tvShow?.lastAirDate != null)
        RowMainInfoData(
          icon: Icons.calendar_month,
          title:
              '${S.of(context).last_show}: ${vm.stringFromDate(tvShow?.lastAirDate)}',
        ),
      if (tvShow?.lastEpisodeToAir != null &&
          tvShow!.lastEpisodeToAir!.name.isNotEmpty)
        RowMainInfoData(
          icon: Icons.movie_creation,
          title:
              '${S.of(context).last_episode}: ${tvShow.lastEpisodeToAir?.name}',
        ),
      if (tvShow?.nextEpisodeToAir != null &&
          tvShow!.nextEpisodeToAir!.name.isNotEmpty)
        RowMainInfoData(
          icon: Icons.movie_creation,
          title:
              '${S.of(context).next_episode}: ${tvShow.nextEpisodeToAir!.name}',
        ),
      if (tvShow?.numberOfSeasons != null && tvShow!.numberOfSeasons != 0)
        RowMainInfoData(
          icon: Icons.movie_creation,
          title: '${S.of(context).total_seasons}: ${tvShow.numberOfSeasons}',
        ),
      if (tvShow?.numberOfEpisodes != null && tvShow!.numberOfEpisodes != 0)
        RowMainInfoData(
          icon: Icons.movie_creation,
          title: '${S.of(context).total_episodes}: ${tvShow.numberOfEpisodes}',
        ),
      if (tvShow?.status != null)
        RowMainInfoData(
          icon: Icons.star,
          title: '${S.of(context).status}: ${tvShow!.status}',
        ),
    ];
    return RowMainInfoWidget(data: tvShowInfoData);
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = context
        .select((TvShowDetailsViewModel vm) => vm.state.tvShowDetails!.name);
    return TitleWidget(title: title);
  }
}

class _ButtonsWidget extends StatelessWidget {
  const _ButtonsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<TvShowDetailsViewModel>();
    final videos = context
        .select((TvShowDetailsViewModel vm) => vm.state.tvShowDetails!.videos);
    final isWatched =
        context.select((TvShowDetailsViewModel vm) => vm.state.isWatched);
    return ButtonsWidget(
      videos: videos.results,
      onPressedWatch: vm.watchTvShow,
      isWatched: isWatched,
    );
  }
}

class _HeaderPosterWidget extends StatelessWidget {
  const _HeaderPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<TvShowDetailsViewModel>();
    final isFavorite =
        context.select((TvShowDetailsViewModel vm) => vm.state.isFavorite);
    final tvShow =
        context.select((TvShowDetailsViewModel vm) => vm.state.tvShowDetails!);
    return HeaderPosterWidget(
      data: HeaderPosterData(
        isFavorite: isFavorite,
        onFavoritePressed: vm.favoriteTvShow,
        posterPath: tvShow.posterPath ?? '',
        backdropPath: tvShow.backdropPath ?? '',
        voteAverage: tvShow.voteAverage,
      ),
    );
  }
}
