import 'package:flutter/material.dart';
import 'package:movie_night/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'package:movie_night/application/constants/app_dimensions.dart';
import 'package:movie_night/application/domain/entities/tv_shows/season_details.dart';
import 'package:movie_night/application/ui/screens/season_details/season_details_view_model.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/widgets/details/media_widget.dart';
import 'package:movie_night/application/ui/widgets/details/overview_widget.dart';

import '../../../domain/api_client/image_downloader.dart';
import '../../themes/app_text_style.dart';
import '../../widgets/cached_network_image_widget.dart';
import '../../widgets/details/buttons_widget.dart';
import '../../widgets/details/list_credits_complex_widget.dart';
import '../../widgets/details/row_main_info_widget.dart';
import '../../widgets/details/title_widget.dart';
import '../../widgets/header_poster_widget.dart';
import '../../widgets/inkwell_material_widget.dart';

class SeasonDetailsScreen extends StatefulWidget {
  const SeasonDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SeasonDetailsScreen> createState() => _SeasonDetailsScreenState();
}

class _SeasonDetailsScreenState extends State<SeasonDetailsScreen> {
  @override
  void didChangeDependencies() async {
    await context.read<SeasonDetailsViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final tvShow =
        context.select((SeasonDetailsViewModel vm) => vm.state.seasonDetails);
    return Scaffold(
      body: SafeArea(
        child: tvShow != null
            ? ListView(
                children: const [
                  _HeaderPosterWidget(),
                  _TvShowDetailsWidget(),
                  SizedBox(height: 8),
                  _MediaWidget(),
                  SizedBox(height: 8),
                  _EpisodesWidget(),
                  _ListCastWidget(),
                  _ListCrewWidget(),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: AppColors.colorMainText,
                ),
              ),
      ),
    );
  }
}

class _ListCrewWidget extends StatelessWidget {
  const _ListCrewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crew = context.select((SeasonDetailsViewModel vm) =>
        vm.state.seasonDetails!.aggregateCredits.crew);
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
          _OverviewWidget(),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _EpisodesWidget extends StatelessWidget {
  const _EpisodesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final seasons = context.select(
        (SeasonDetailsViewModel vm) => vm.state.seasonDetails?.episodes);
    return seasons != null && seasons.isNotEmpty == true
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: AppDimensions.mediumPadding),
                child: Text(
                  S.of(context).episodes_v2,
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
                      child: EpisodeWidget(episode: item),
                    );
                  },
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

class EpisodeWidget extends StatelessWidget {
  final Episode episode;
  const EpisodeWidget({
    Key? key,
    required this.episode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SeasonDetailsViewModel>();
    return InkWellMaterialWidget(
      onTap: () => vm.toEpisode(context, episode.episodeNumber),
      borderRadius: AppDimensions.radius5,
      color: AppColors.colorSplash,
      child: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radius5),
              child: Stack(
                children: [
                  CachedNetworkImageWidget(
                    height: 180,
                    imageUrl: ImageDownloader.imageUrl(episode.stillPath ?? ''),
                  ),
                  if (episode.airDate?.year != null)
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
                        child: Center(
                          child: Text(
                            '${episode.airDate?.year ?? ''}',
                            style: AppTextStyle.subheader2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Text(
              episode.name,
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
        (SeasonDetailsViewModel vm) => vm.state.seasonDetails?.overview);
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
    final backdrops = context
        .select((SeasonDetailsViewModel vm) => vm.state.seasonImages?.posters);
    return MediaWidget(
      aspectRatios: backdrops
          ?.map(
            (backdrop) => backdrop.aspectRatio,
          )
          .toList(),
      
      backdrops: backdrops?.map((backdrop) => backdrop.filePath ?? '').toList(),
    );
  }
}

class _ListCastWidget extends StatelessWidget {
  const _ListCastWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cast = context.select((SeasonDetailsViewModel vm) =>
        vm.state.seasonDetails!.aggregateCredits.cast);
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

class _RowMainInfoWidget extends StatelessWidget {
  const _RowMainInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SeasonDetailsViewModel>();
    final seasonDetails =
        context.select((SeasonDetailsViewModel vm) => vm.state.seasonDetails);
    final tvShowInfoData = <RowMainInfoData>[
      RowMainInfoData(
        icon: Icons.calendar_month,
        title: '${S.of(context).release_date}: ${vm.stringFromDate(seasonDetails?.airDate)}',
      ),
    ];
    return RowMainInfoWidget(data: tvShowInfoData);
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final seasonDetails =
        context.select((SeasonDetailsViewModel vm) => vm.state.seasonDetails);
    return TitleWidget(
        title: seasonDetails?.name ?? 'Сезон ${seasonDetails?.seasonNumber}');
  }
}

class _ButtonsWidget extends StatelessWidget {
  const _ButtonsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videos = context
        .select((SeasonDetailsViewModel vm) => vm.state.seasonDetails!.videos);
    return ButtonsWidget(
      videos: videos.results,
      showWatched: false,
    );
  }
}

class _HeaderPosterWidget extends StatelessWidget {
  const _HeaderPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvShow =
        context.select((SeasonDetailsViewModel vm) => vm.state.seasonDetails!);
    return HeaderPosterWidget(
      data: HeaderPosterData(
        posterPath: tvShow.posterPath ?? '',
        backdropPath: tvShow.posterPath ?? '',
        voteAverage: 0,
        showFavorite: false,
        showVoteAverage: false,
      ),
    );
  }
}
