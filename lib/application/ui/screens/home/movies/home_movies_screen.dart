import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/screens/home/movies/home_movies_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_dimensions.dart';
import '../../../../resources/resources.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/movies_with_header_widget.dart';

class HomeMoviesScreen extends StatelessWidget {
  const HomeMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        _BodyWidget(),
      ],
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeMoviesViewModel>();
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          const SizedBox(height: 16),
          const _HeaderMovies(),
          const SizedBox(height: 16),
          MoviesWithHeaderWidget(
            header: 'New Movies',
            onPressed: vm.onMoviePressed,
          ),
          const SizedBox(height: 16),
          MoviesWithHeaderWidget(
            header: 'Drama',
            onPressed: vm.onMoviePressed,
          ),
          const SizedBox(height: 16),
        ],
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
    final vm = context.read<HomeMoviesViewModel>();
    final controller = vm.headerMoviesPageController;
    return Column(
      children: [
        SizedBox(
          height: 168,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: controller,
            itemCount: vm.listHeaderMovies.length,
            onPageChanged: (index) => vm.onHeaderChanged(index, controller),
            itemBuilder: (context, index) {
              return _HeaderMovieItemWidget(index: index);
            },
          ),
        ),
        const SizedBox(height: 8),
        const _HeaderIndicatorsWidget(),
      ],
    );
  }
}

class _HeaderIndicatorsWidget extends StatelessWidget {
  const _HeaderIndicatorsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeMoviesViewModel>();
    final indicators = vm.listHeaderMovies
        .asMap()
        .map(
          (indexMovie, value) => MapEntry(
            indexMovie,
            Container(
              width: 6,
              height: 6,
              margin: EdgeInsets.only(
                right: indexMovie != vm.listHeaderMovies.length - 1 ? 9.0 : 0.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radius15),
                color: indexMovie == vm.currentHeaderMovieIndex
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
    final vm = context.watch<HomeMoviesViewModel>();
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: index != vm.currentHeaderMovieIndex ? 4.0 : 0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppDimensions.radius5,
            ),
            color: index != vm.currentHeaderMovieIndex
                ? AppColors.colorPrimary.withOpacity(0.7)
                : Colors.transparent,
            image: const DecorationImage(
              image: AssetImage(
                AppImages.movieExample,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: index != vm.currentHeaderMovieIndex
                ? AppColors.colorPrimary.withOpacity(0.7)
                : Colors.transparent,
          ),
        ),
      ],
    );
  }
}
