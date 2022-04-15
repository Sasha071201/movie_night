import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/screens/episode_details/episode_details_view_model.dart';
import 'package:provider/provider.dart';

import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/widgets/details/media_widget.dart';
import 'package:movie_night/application/ui/widgets/details/overview_widget.dart';

import '../../../../generated/l10n.dart';
import '../../widgets/details/buttons_widget.dart';
import '../../widgets/details/list_credits_simple_widget.dart';
import '../../widgets/details/row_main_info_widget.dart';
import '../../widgets/details/title_widget.dart';
import '../../widgets/header_poster_widget.dart';

class EpisodeDetailsScreen extends StatefulWidget {
  const EpisodeDetailsScreen({Key? key}) : super(key: key);

  @override
  State<EpisodeDetailsScreen> createState() => _EpisodeDetailsScreenState();
}

class _EpisodeDetailsScreenState extends State<EpisodeDetailsScreen> {
  @override
  void didChangeDependencies() async {
    await context.read<EpisodeDetailsViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final tvShow =
        context.select((EpisodeDetailsViewModel vm) => vm.state.episodeDetails);
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
    final crew = context
        .select((EpisodeDetailsViewModel vm) => vm.state.episodeDetails!.crew);
    final list = crew
        .map(
          (item) => CreditsItemSimpleData(
            id: item.id,
            name: item.name,
            posterPath: item.profilePath ?? '',
            value: item.job,
          ),
        )
        .toList();
    final data = ListCreditsSimpleData(
      title: S.of(context).crew,
      list: list,
    );
    return ListCreditsSimpleWidget(
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

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final overview = context.select(
        (EpisodeDetailsViewModel vm) => vm.state.episodeDetails?.overview);
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
        .select((EpisodeDetailsViewModel vm) => vm.state.episodeImages?.stills);
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

class _ListCastWidget extends StatelessWidget {
  const _ListCastWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cast = context.select(
        (EpisodeDetailsViewModel vm) => vm.state.episodeDetails!.credits.cast);
    final list = cast
        .map(
          (item) => CreditsItemSimpleData(
            id: item.id,
            name: item.name,
            posterPath: item.profilePath ?? '',
            value: item.character,
          ),
        )
        .toList();
    final data = ListCreditsSimpleData(
      title: S.of(context).cast,
      list: list,
    );
    return ListCreditsSimpleWidget(
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
    final vm = context.read<EpisodeDetailsViewModel>();
    final episodeDetails =
        context.select((EpisodeDetailsViewModel vm) => vm.state.episodeDetails);
    final tvShowInfoData = <RowMainInfoData>[
      RowMainInfoData(
        icon: Icons.calendar_month,
        title: '${S.of(context).release_date}: ${vm.stringFromDate(episodeDetails?.airDate)}',
      ),
    ];
    return RowMainInfoWidget(data: tvShowInfoData);
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final episodeDetails =
        context.select((EpisodeDetailsViewModel vm) => vm.state.episodeDetails);
    return TitleWidget(
        title: episodeDetails?.name ?? 'Сезон ${episodeDetails?.seasonNumber}');
  }
}

class _ButtonsWidget extends StatelessWidget {
  const _ButtonsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videos = context.select(
        (EpisodeDetailsViewModel vm) => vm.state.episodeDetails!.videos);
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
    final episode = context
        .select((EpisodeDetailsViewModel vm) => vm.state.episodeDetails!);
    return HeaderPosterWidget(
      data: HeaderPosterData(
        posterPath: episode.stillPath ?? '',
        backdropPath: episode.stillPath ?? '',
        voteAverage: episode.voteAverage,
        showFavorite: false,
      ),
    );
  }
}
