import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/api_client/image_downloader.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';
import 'package:movie_night/application/ui/screens/home/movies/home_movies_view_model.dart';
import 'package:movie_night/application/ui/screens/main/main_view_model.dart';
import 'package:movie_night/application/ui/widgets/inkwell_material_widget.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_dimensions.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/cached_network_image_widget.dart';
import '../../../widgets/vertical_widgets_with_header/movies_with_header_widget.dart';

class HomeMoviesScreen extends StatefulWidget {
  const HomeMoviesScreen({Key? key}) : super(key: key);

  @override
  State<HomeMoviesScreen> createState() => _HomeMoviesScreenState();
}

class _HomeMoviesScreenState extends State<HomeMoviesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void didChangeDependencies() {
    context.read<HomeMoviesViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final moviesWithHeader =
        context.select((HomeMoviesViewModel vm) => vm.state.moviesWithHeader);
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 16),
                  const _HeaderMovies(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const _MoviesWithCategoryWidget(),
          ],
        ),
        if (moviesWithHeader.isEmpty)
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

class _MoviesWithCategoryWidget extends StatelessWidget {
  const _MoviesWithCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeMoviesViewModel>();
    final isLoadingProgress =
        context.select((HomeMoviesViewModel vm) => vm.state.isLoadingProgress);
    final moviesWithHeader =
        context.select((HomeMoviesViewModel vm) => vm.state.moviesWithHeader);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          vm.showedCategoryAtIndex(index: index);
          return Column(
            children: [
              MoviesWithHeaderWidget(
                movieData: MovieWithHeaderData(
                  title: moviesWithHeader[index].title,
                  list: moviesWithHeader[index].list,
                  movieGenres: moviesWithHeader[index].movieGenres,
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

class _HeaderMovies extends StatelessWidget {
  const _HeaderMovies({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _HeaderPageViewWidget(),
        SizedBox(height: 8),
        _HeaderIndicatorsWidget(),
      ],
    );
  }
}

class _HeaderPageViewWidget extends StatelessWidget {
  const _HeaderPageViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final heightFactor = height / 785;
    final vm = context.read<HomeMoviesViewModel>();
    final headerMovies =
        context.select((HomeMoviesViewModel vm) => vm.state.headerMovies);
    return SizedBox(
      height: 168 * heightFactor,
      child: Swiper(
        curve: Curves.easeInOut,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _HeaderMovieItemWidget(index: index);
        },
        autoplay: headerMovies.isNotEmpty ? true : false,
        onIndexChanged: vm.onIndexChanged,
        itemCount: headerMovies.length,
        viewportFraction: 302 / 390,
      ),
    );
  }
}

class _HeaderIndicatorsWidget extends StatelessWidget {
  const _HeaderIndicatorsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerMovies =
        context.select((HomeMoviesViewModel vm) => vm.state.headerMovies);
    final currentHeaderMovieIndex = context
        .select((HomeMoviesViewModel vm) => vm.state.currentHeaderMovieIndex);
    final indicators = headerMovies
        .asMap()
        .map(
          (indexMovie, value) => MapEntry(
            indexMovie,
            Container(
              width: 6,
              height: 6,
              margin: EdgeInsets.only(
                right: indexMovie != headerMovies.length - 1 ? 9.0 : 0.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radius15),
                color: indexMovie == currentHeaderMovieIndex
                    ? AppColors.colorSecondary
                    : AppColors.colorSecondaryText,
              ),
            ),
          ),
        )
        .values
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }
}

class _HeaderMovieItemWidget extends StatelessWidget {
  final int index;
  const _HeaderMovieItemWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerMovies =
        context.select((HomeMoviesViewModel vm) => vm.state.headerMovies);
    final currentHeaderMovieIndex = context
        .select((HomeMoviesViewModel vm) => vm.state.currentHeaderMovieIndex);
    return headerMovies.isNotEmpty
        ? InkWellMaterialWidget(
            color: AppColors.colorSplash,
            borderRadius: AppDimensions.radius5,
            onTap: () {
              context.read<MainViewModel>().showAdIfAvailable();
              Navigator.of(context).pushNamed(Screens.movieDetails,
                  arguments: headerMovies[index].id);
            },
            child: CachedNetworkImageWidget(
              imageUrl: ImageDownloader.imageUrl(
                  headerMovies[index].backdropPath ?? ''),
              imageBuilder: (context, imageProvider) => Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: index != currentHeaderMovieIndex ? 4.0 : 0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radius5,
                  ),
                  color: index != currentHeaderMovieIndex
                      ? AppColors.colorPrimary.withOpacity(0.7)
                      : Colors.transparent,
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      index != currentHeaderMovieIndex
                          ? AppColors.colorPrimary.withOpacity(0.7)
                          : Colors.transparent,
                      BlendMode.darken,
                    ),
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
