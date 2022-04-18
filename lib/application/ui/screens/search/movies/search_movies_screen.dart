import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/ui/screens/filter/filter_view_model.dart';
import 'package:movie_night/application/ui/screens/search/movies/search_movies_view_model.dart';
import 'package:movie_night/application/ui/widgets/action_chip_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../generated/l10n.dart';
import '../../../../domain/entities/genre.dart';
import '../../../../domain/entities/movie/movie_genres.dart';
import '../../../navigation/app_navigation.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_style.dart';
import '../../../widgets/filter_button_widget.dart';
import '../../../widgets/vertical_widgets_with_header/movies_with_header_widget.dart';
import '../../view_all_movies/view_all_movies_view_model.dart';

class SearchMoviesScreen extends StatefulWidget {
  const SearchMoviesScreen({Key? key}) : super(key: key);

  @override
  State<SearchMoviesScreen> createState() => _SearchMoviesScreenState();
}

class _SearchMoviesScreenState extends State<SearchMoviesScreen> with AutomaticKeepAliveClientMixin {
  @override
  void didChangeDependencies() {
    context.read<SearchMoviesViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final moviesWithHeader =
        context.select((SearchMoviesViewModel vm) => vm.state.moviesWithHeader);
    return Stack(
      children: [
        CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const _FilterButtonWidget(),
                  const _GenresWidget(),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            const _MoviesWithHeaderWidget(),
            const _MoviesWithGenresWidget(),
          ],
        ),
        if (moviesWithHeader.isEmpty)
          const Center(
            child: RepaintBoundary(
              child: CircularProgressIndicator(
                color: AppColors.colorMainText,
              ),
            ),
          ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _MoviesWithHeaderWidget extends StatelessWidget {
  const _MoviesWithHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoadingProgress = context
        .select((SearchMoviesViewModel vm) => vm.state.isLoadingProgress);
    final moviesWithHeader =
        context.select((SearchMoviesViewModel vm) => vm.state.moviesWithHeader);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              MoviesWithHeaderWidget(
                movieData: MovieWithHeaderData(
                  title: moviesWithHeader[index].title,
                  list: moviesWithHeader[index].list,
                  viewMediaType: moviesWithHeader[index].viewMediaType,
                  movieId: moviesWithHeader[index].movieId,
                ),
              ),
              if (isLoadingProgress &&
                  index == moviesWithHeader.length - 1) ...[
                const SizedBox(
                  height: 8,
                ),
                const Center(
                  child: RepaintBoundary(
                    child: CircularProgressIndicator(
                      color: AppColors.colorMainText,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ],
          );
        },
        childCount: moviesWithHeader.length,
      ),
    );
  }
}

class _MoviesWithGenresWidget extends StatelessWidget {
  const _MoviesWithGenresWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SearchMoviesViewModel>();
    final isLoadingProgress = context
        .select((SearchMoviesViewModel vm) => vm.state.isLoadingProgress);
    final moviesWithGenres =
        context.select((SearchMoviesViewModel vm) => vm.state.moviesWithGenres);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          vm.showedCategoryAtIndex(context: context, index: index);
          return Column(
            children: [
              MoviesWithHeaderWidget(
                movieData: MovieWithHeaderData(
                  title: moviesWithGenres[index].title,
                  list: moviesWithGenres[index].list,
                  movieGenres: moviesWithGenres[index].movieGenres,
                ),
              ),
              if (isLoadingProgress &&
                  index == moviesWithGenres.length - 1) ...[
                const SizedBox(
                  height: 8,
                ),
                const Center(
                  child: RepaintBoundary(
                    child: CircularProgressIndicator(
                      color: AppColors.colorMainText,
                    ),
                  ),
                ),
              ],
            ],
          );
        },
        childCount: moviesWithGenres.length,
      ),
    );
  }
}

class _FilterButtonWidget extends StatelessWidget {
  const _FilterButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          top: 8.0,
        ),
        child: FilterButtonWidget(
          pushNamed: (pushNamed) async {},
          data: FilterData(),
          mediaType: MediaType.movie,
          openFromMain: true,
        ),
      ),
    );
  }
}

class _GenresWidget extends StatelessWidget {
  const _GenresWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            S.of(context).genres,
            style: AppTextStyle.header3,
          ),
        ),
        Consumer<SearchMoviesViewModel>(
          builder: (context, vm, _) => SizedBox(
            height: 25 + 30,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: MovieGenres.values.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) => Column(
                children: [
                  const SizedBox(height: 8),
                  ActionChipWidget(
                    child: Text(MovieGenres.values[index].asString(context)),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(Screens.viewAllMovies, arguments: [
                      ViewAllMoviesData(
                        withGenres: [Genre(genre: MovieGenres.values[index])],
                      ),
                      MediaType.movie,
                    ]),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
