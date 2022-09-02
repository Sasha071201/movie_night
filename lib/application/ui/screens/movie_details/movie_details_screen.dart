import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_night/application/domain/firebase/firebase_dynamic_link.dart';
import 'package:provider/provider.dart';

import 'package:movie_night/application/constants/app_dimensions.dart';
import 'package:movie_night/application/ui/screens/movie_details/movie_details_view_model.dart';
import 'package:movie_night/application/ui/screens/view_movies/view_movies_view_model.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/details/buttons_widget.dart';
import 'package:movie_night/application/ui/widgets/details/tagline_widget.dart';
import 'package:movie_night/application/ui/widgets/details/title_widget.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/api_client/media_type.dart';
import '../../../domain/entities/genre.dart';
import '../../navigation/app_navigation.dart';
import '../../widgets/adult_onboarding_widget.dart';
import '../../widgets/details/chips_with_header_widget.dart';
import '../../widgets/details/external_sources_widget.dart';
import '../../widgets/details/list_credits_simple_widget.dart';
import '../../widgets/details/media_widget.dart';
import '../../widgets/details/overview_widget.dart';
import '../../widgets/details/row_main_info_widget.dart';
import '../../widgets/header_poster_widget.dart';
import '../../widgets/review_sliver_widget.dart';
import '../../widgets/review_text_field_widget.dart';
import '../../widgets/vertical_widgets_with_header/movies_with_header_widget.dart';
import '../view_all_movies/view_all_movies_view_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void didChangeDependencies() async {
    await context.read<MovieDetailsViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MovieDetailsViewModel>();
    final showAdultContent =
        context.select((MovieDetailsViewModel vm) => vm.state.showAdultContent);
    final movie = context.select((MovieDetailsViewModel vm) => vm.state.movieDetails);
    final isLoaded = context.select((MovieDetailsViewModel vm) => vm.state.isLoaded);
    return Scaffold(
      body: SafeArea(
        child: movie != null && isLoaded
            ? CustomScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        AdultOnboardingWidget(
                          onPressed: vm.enableAdultContent,
                          show: movie.adult != null && movie.adult == true && !showAdultContent,
                          child: Column(
                            children: const [
                              _HeaderPosterWidget(),
                              _MovieDetailsWidget(),
                              SizedBox(height: 8),
                              _MediaWidget(),
                              SizedBox(height: 8),
                              _ListCastsWidget(),
                              _ListCrewsWidget(),
                              SizedBox(height: AppDimensions.mediumPadding),
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
    final vm = context.read<MovieDetailsViewModel>();
    final isProgressSending =
        context.select((MovieDetailsViewModel vm) => vm.state.isProgressSending);
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
    final vm = context.read<MovieDetailsViewModel>();
    final reviews = context.select((MovieDetailsViewModel vm) => vm.reviews);
    return ReviewsSliverWidget(
      reviews: reviews,
      timeAgoFromDate: vm.timeAgoFromDate,
      deleteReview: vm.deleteReview,
      sendComplaintToReview: vm.sendComplaintToReview,
      complaintReviewTextController: vm.complaintReviewTextController,
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
    return Padding(padding: EdgeInsets.only(bottom: insetsBottom == 0 ? 32 : insetsBottom + 16));
  }
}

class _RecommendationWidget extends StatelessWidget {
  const _RecommendationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final details = context.read<MovieDetailsViewModel>();
    final recommendations =
        context.select((MovieDetailsViewModel vm) => vm.state.movieDetails?.recommendations);
    return recommendations != null && recommendations.results.isNotEmpty
        ? MoviesWithHeaderWidget(
            movieData: MovieWithHeaderData(
              title: S.of(context).recommendation,
              list: recommendations.results,
              viewMediaType: ViewMediaType.recommendation,
              movieId: details.movieId,
            ),
            onPressed: () => context.read<MovieDetailsViewModel>().showAdIfAvailable(),
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
    final details = context.read<MovieDetailsViewModel>();
    final similar = context.select((MovieDetailsViewModel vm) => vm.state.movieDetails?.similar);
    return similar != null && similar.results.isNotEmpty
        ? MoviesWithHeaderWidget(
            movieData: MovieWithHeaderData(
              title: S.of(context).similar,
              list: similar.results,
              viewMediaType: ViewMediaType.similar,
              movieId: details.movieId,
            ),
            onPressed: () => context.read<MovieDetailsViewModel>().showAdIfAvailable(),
          )
        : const SizedBox.shrink();
  }
}

class _MovieDetailsWidget extends StatelessWidget {
  const _MovieDetailsWidget({
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

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = context.select((MovieDetailsViewModel vm) => vm.state.movieDetails!.title);
    return TitleWidget(title: title ?? 'Unknown');
  }
}

class _TaglineWidget extends StatelessWidget {
  const _TaglineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tagline = context.select((MovieDetailsViewModel vm) => vm.state.movieDetails!.tagline);
    return TaglineWidget(
      tagline: tagline ?? '',
    );
  }
}

class _ExternalSourcesWidget extends StatelessWidget {
  const _ExternalSourcesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final externalIds =
        context.select((MovieDetailsViewModel vm) => vm.state.movieDetails!.externalIds);
    final allIsNull = (externalIds?.facebookId ?? '').isEmpty &&
        (externalIds?.instagramId ?? '').isEmpty &&
        (externalIds?.twitterId ?? '').isEmpty;
    final data = [
      ExternalSourcesData(
        type: ExternalSourcesType.facebook,
        source: externalIds?.facebookId ?? '',
      ),
      ExternalSourcesData(
        type: ExternalSourcesType.instagram,
        source: externalIds?.instagramId ?? '',
      ),
      ExternalSourcesData(
        type: ExternalSourcesType.twitter,
        source: externalIds?.twitterId ?? '',
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
    final productionCompanies =
        context.select((MovieDetailsViewModel vm) => vm.state.movieDetails!.productionCompanies);
    return productionCompanies != null
        ? ChipsWithHeaderWidget(
            title: S.of(context).production_companies,
            data: productionCompanies.map((data) => data.name).toList(),
            onPressed: (index) {},
          )
        : const SizedBox.shrink();
  }
}

class _ProductionCountriesWidget extends StatelessWidget {
  const _ProductionCountriesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productionCountries =
        context.select((MovieDetailsViewModel vm) => vm.state.movieDetails!.productionCountries);
    return productionCountries != null
        ? ChipsWithHeaderWidget(
            title: S.of(context).production_countries,
            data: productionCountries.map((data) => data.name).toList(),
            onPressed: (index) {},
          )
        : const SizedBox.shrink();
  }
}

class _KeywordsWidget extends StatelessWidget {
  const _KeywordsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keywords = context.select((MovieDetailsViewModel vm) => vm.state.movieDetails!.keywords);
    return ChipsWithHeaderWidget(
      title: S.of(context).keywords,
      data: keywords?.keywords.map((keyword) => keyword.name).toList(),
      onPressed: (index) {},
    );
  }
}

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final overview = context.select((MovieDetailsViewModel vm) => vm.state.movieDetails?.overview);
    return LargeTextWithHeaderWidget(
      header: S.of(context).description,
      overview: overview ?? '',
    );
  }
}

class _MediaWidget extends StatelessWidget {
  const _MediaWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backdrops = context.select((MovieDetailsViewModel vm) => vm.state.movieImages?.backdrops);
    return MediaWidget(
      aspectRatios: backdrops
          ?.map(
            (backdrop) => backdrop.aspectRatio,
          )
          .toList(),
      backdrops: backdrops?.map((backdrop) => backdrop.filePath).toList(),
    );
  }
}

class _ListCastsWidget extends StatelessWidget {
  const _ListCastsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cast = context.select((MovieDetailsViewModel vm) => vm.state.movieDetails!.credits?.cast);
    final list = cast
        ?.map(
          (item) => CreditsItemSimpleData(
            id: item.id,
            name: item.name,
            posterPath: item.profilePath ?? '',
            value: item.character,
          ),
        )
        .toList();
    if (list != null) {
      final data = ListCreditsSimpleData(
        title: S.of(context).cast,
        list: list,
      );
      return ListCreditsSimpleWidget(
        data: data,
      );
    }
    return const SizedBox.shrink();
  }
}

class _ListCrewsWidget extends StatelessWidget {
  const _ListCrewsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crew = context.select((MovieDetailsViewModel vm) => vm.state.movieDetails!.credits?.crew);
    final list = crew
        ?.map(
          (item) => CreditsItemSimpleData(
            id: item.id,
            name: item.name,
            posterPath: item.profilePath ?? '',
            value: item.job,
          ),
        )
        .toList();
    if (list != null) {
      final data = ListCreditsSimpleData(
        title: S.of(context).crew,
        list: list,
      );
      return ListCreditsSimpleWidget(
        data: data,
      );
    }
    return const SizedBox.shrink();
  }
}

class _GenresWidget extends StatelessWidget {
  const _GenresWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genres = context.select((MovieDetailsViewModel vm) => vm.state.movieDetails!.genres);
    return genres != null
        ? ChipsWithHeaderWidget(
            title: S.of(context).genres,
            data: genres.map((genre) => genre.name).toList(),
            onPressed: (index) {
              context.read<MovieDetailsViewModel>().showAdIfAvailable();
              final genre = Genre.fromIdToGenre(genres[index].id);
              Navigator.of(context).pushNamed(Screens.viewAllMovies, arguments: [
                ViewAllMoviesData(
                  withGenres: [
                    Genre(genre: genre),
                  ],
                ),
                MediaType.movie,
              ]);
            })
        : const SizedBox.shrink();
  }
}

class _RowMainInfoWidget extends StatelessWidget {
  const _RowMainInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MovieDetailsViewModel>();
    final movie = context.select((MovieDetailsViewModel vm) => vm.state.movieDetails!);

    final movieInfoData = <RowMainInfoData>[
      RowMainInfoData(
        icon: Icons.calendar_month,
        title: vm.stringFromDate(movie.releaseDate),
      ),
      if (movie.runtime != null)
        RowMainInfoData(
          icon: Icons.timer,
          title: '${movie.runtime} ${S.of(context).mins}',
        ),
      if (movie.budget != null && movie.budget != 0)
        RowMainInfoData(
          icon: Icons.monetization_on_outlined,
          title: NumberFormat().format(movie.budget),
        ),
      if (movie.status != null)
        RowMainInfoData(
          icon: Icons.star,
          title: movie.status!,
        ),
    ];
    return RowMainInfoWidget(data: movieInfoData);
  }
}

class _ButtonsWidget extends StatelessWidget {
  const _ButtonsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MovieDetailsViewModel>();
    final videos = context.select((MovieDetailsViewModel vm) => vm.state.movieDetails!.videos);
    final isWatched = context.select((MovieDetailsViewModel vm) => vm.state.isWatched);
    return ButtonsWidget(
      videos: videos?.results ?? [],
      onPressedWatch: vm.watchMovie,
      isWatched: isWatched,
      showShare: true,
      dynamicLinkType: FirebaseDynamicLinkType.movie,
      id: vm.movieId,
    );
  }
}

class _HeaderPosterWidget extends StatelessWidget {
  const _HeaderPosterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MovieDetailsViewModel>();
    final isFavorite = context.select((MovieDetailsViewModel vm) => vm.state.isFavorite);
    final movie = context.select((MovieDetailsViewModel vm) => vm.state.movieDetails!);
    return HeaderPosterWidget(
      data: HeaderPosterData(
        isFavorite: isFavorite,
        onFavoritePressed: vm.favoriteMovie,
        posterPath: movie.posterPath ?? '',
        backdropPath: movie.backdropPath ?? '',
        voteAverage: movie.voteAverage ?? 0,
      ),
    );
  }
}
