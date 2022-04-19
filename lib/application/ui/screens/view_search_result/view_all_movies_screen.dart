import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/domain/entities/tv_shows/tv_show.dart';
import 'package:movie_night/application/ui/screens/view_search_result/view_all_movies_view_model.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/entities/actor/actor.dart';
import '../../../domain/entities/movie/movie.dart';
import '../../widgets/app_grid_view.dart';
import '../../widgets/vertical_widgets_with_header/vertical_actor_widget.dart';
import '../../widgets/vertical_widgets_with_header/vertical_movie_widget.dart';
import '../../widgets/vertical_widgets_with_header/vertical_tv_show_widget.dart';

class ViewSearchResultScreen extends StatefulWidget {
  const ViewSearchResultScreen({Key? key}) : super(key: key);

  @override
  State<ViewSearchResultScreen> createState() => _ViewSearchResultScreenState();
}

class _ViewSearchResultScreenState extends State<ViewSearchResultScreen> {
  @override
  void didChangeDependencies() {
    context.read<ViewSearchResultViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: AppColors.colorSecondary),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _HeaderWidget(),
              SizedBox(height: 8.0),
              Expanded(
                child: _ListMoviesWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListMoviesWidget extends StatelessWidget {
  const _ListMoviesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ViewSearchResultViewModel>();
    final isLoadingProgress = context
        .select((ViewSearchResultViewModel vm) => vm.state.isLoadingProgress);
    final searchResult =
        context.select((ViewSearchResultViewModel vm) => vm.state.searchResult);
    return searchResult.isNotEmpty
        ? Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AppGridView(
                itemBuilder: (context, index) {
                  Widget child = const SizedBox.shrink();
                  if (searchResult[index].mediaType == MediaType.movie) {
                    final movie = Movie(
                      id: searchResult[index].id,
                      posterPath: searchResult[index].posterPath,
                      title: searchResult[index].title,
                      voteAverage: searchResult[index].voteAverage!,
                      releaseDate: searchResult[index].releaseDate,
                    );
                    child = VerticalMovieWidget(
                      movie: movie,
                    );
                  } else if (searchResult[index].mediaType == MediaType.tv) {
                    final tvShow = TvShow(
                      id: searchResult[index].id,
                      posterPath: searchResult[index].posterPath,
                      name: searchResult[index].name,
                      voteAverage: searchResult[index].voteAverage ?? 0,
                      firstAirDate: searchResult[index].firstAirDate,
                    );
                    child = VerticalTvShowWidget(
                      tvShow: tvShow,
                    );
                  } else if (searchResult[index].mediaType ==
                      MediaType.person) {
                    final actor = Actor(
                      id: searchResult[index].id,
                      profilePath: searchResult[index].profilePath,
                      name: searchResult[index].name,
                    );
                    child = VerticalActorWidget(
                      actor: actor,
                    );
                  }
                  vm.showedCategoryAtIndex(index);
                  return child;
                },
                itemCount: searchResult.length,
              ),
              if (isLoadingProgress)
                const Positioned(
                  bottom: 16,
                  child: Center(
                    child: RepaintBoundary(
                      child: CircularProgressIndicator(
                        color: AppColors.colorMainText,
                      ),
                    ),
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
          );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = context.select((ViewSearchResultViewModel vm) => vm.query);
    return Text(
      '${S.of(context).search_result} $query',
      style: AppTextStyle.header2,
    );
  }
}
