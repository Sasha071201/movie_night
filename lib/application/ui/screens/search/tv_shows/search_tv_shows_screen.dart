import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../domain/api_client/media_type.dart';
import '../../../../domain/entities/genre.dart';
import '../../../../domain/entities/tv_shows/tv_show_genres.dart';
import '../../../navigation/app_navigation.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_style.dart';
import '../../../widgets/action_chip_widget.dart';
import '../../../widgets/filter_button_widget.dart';
import '../../../widgets/vertical_widgets_with_header/tv_shows_with_header_widget.dart';
import '../../filter/filter_view_model.dart';
import '../../view_all_movies/view_all_movies_view_model.dart';
import 'search_tv_shows_view_model.dart';

class SearchTvShowsScreen extends StatefulWidget {
  const SearchTvShowsScreen({Key? key}) : super(key: key);

  @override
  State<SearchTvShowsScreen> createState() => _SearchTvShowsScreenState();
}

class _SearchTvShowsScreenState extends State<SearchTvShowsScreen> with AutomaticKeepAliveClientMixin {

  @override
  void didChangeDependencies() {
    context.read<SearchTvShowsViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final tvShowsWithHeader = context
        .select((SearchTvShowsViewModel vm) => vm.state.tvShowsWithHeader);
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
        if (tvShowsWithHeader.isEmpty)
          const Center(
            child: CircularProgressIndicator(
              color: AppColors.colorMainText,
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
        .select((SearchTvShowsViewModel vm) => vm.state.isLoadingProgress);
    final moviesWithHeader = context
        .select((SearchTvShowsViewModel vm) => vm.state.tvShowsWithHeader);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              TvShowsWithHeaderWidget(
                tvShowData: TvShowWithHeaderData(
                  title: moviesWithHeader[index].title,
                  list: moviesWithHeader[index].list,
                  viewMediaType: moviesWithHeader[index].viewMediaType,
                  tvShowId: moviesWithHeader[index].tvShowId,
                ),
              ),
              if (isLoadingProgress &&
                  index == moviesWithHeader.length - 1) ...[
                const SizedBox(
                  height: 8,
                ),
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.colorMainText,
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
    final vm = context.read<SearchTvShowsViewModel>();
    final isLoadingProgress = context
        .select((SearchTvShowsViewModel vm) => vm.state.isLoadingProgress);
    final moviesWithGenres = context
        .select((SearchTvShowsViewModel vm) => vm.state.tvShowsWithGenres);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          vm.showedCategoryAtIndex(context: context, index: index);
          return Column(
            children: [
              TvShowsWithHeaderWidget(
                tvShowData: TvShowWithHeaderData(
                  title: moviesWithGenres[index].title,
                  list: moviesWithGenres[index].list,
                  tvShowGenres: moviesWithGenres[index].tvShowGenres,
                ),
              ),
              if (isLoadingProgress &&
                  index == moviesWithGenres.length - 1) ...[
                const SizedBox(
                  height: 8,
                ),
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.colorMainText,
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
          mediaType: MediaType.tv,
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
        Consumer<SearchTvShowsViewModel>(
          builder: (context, vm, _) => SizedBox(
            height: 25 + 30,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: TvShowGenres.values.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) => Column(
                children: [
                  const SizedBox(height: 12),
                  ActionChipWidget(
                    child: Text(TvShowGenres.values[index].asString(context)),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(Screens.viewAllMovies, arguments: [
                      ViewAllMoviesData(
                        withGenres: [Genre(genre: TvShowGenres.values[index])],
                      ),
                      MediaType.tv,
                    ]),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
