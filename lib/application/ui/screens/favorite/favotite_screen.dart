import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/screens/favorite/tv_shows/favorite_tv_shows_screen.dart';
import 'package:provider/provider.dart';

import '../../themes/app_colors.dart';
import '../../widgets/appbar/tab_category_iten_widget.dart';
import '../../widgets/sliver_app_bar_delegate.dart';
import 'actors/favorite_actors_screen.dart';
import 'favorite_view_model.dart';
import 'movies/favorite_movies_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({
    Key? key,
  }) : super(key: key);

  static const _children = [
    FavoriteMoviesScreen(),
    FavoriteTvShowsScreen(),
    FavoriteActorsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final vm = context.read<FavoriteViewModel>();
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        const _AppBar(),
      ],
      body: PageView(
        children: _children,
        onPageChanged: (index) => vm.selectCategory(index, context),
        controller: vm.categoryController,
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: SliverAppBarDelegate(
        Container(
          color: AppColors.colorPrimary,
          child: const Center(
            child: _TabsCategoryWidget(),
          ),
        ),
      ),
    );
  }
}

class _TabsCategoryWidget extends StatelessWidget {
  const _TabsCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final length = context.read<FavoriteViewModel>().listCategory.length;
    return SizedBox(
      height: 21,
      child: ListView.separated(
        itemCount: length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 8.0),
        itemBuilder: (context, index) => Consumer<FavoriteViewModel>(
          builder: (context, vm, _) => TabCategoryItemWidget(
            index: index,
            currentIndex: vm.currentCategoryIndex,
            items: vm.listCategory,
            selectCategory: vm.selectCategory,
          ),
        ),
      ),
    );
  }
}