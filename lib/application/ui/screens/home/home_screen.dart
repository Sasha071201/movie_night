import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movie_night/application/ui/screens/home/actors/home_actors_screen.dart';
import 'package:movie_night/application/ui/screens/home/movies/home_movies_screen.dart';
import 'package:movie_night/application/ui/screens/home/tv_shows/home_tv_shows_screen.dart';

import '../../themes/app_colors.dart';
import '../../widgets/appbar/tab_category_iten_widget.dart';
import '../../widgets/sliver_app_bar_delegate.dart';
import 'home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  static const _children = [
    HomeMoviesScreen(),
    HomeTvShowsScreen(),
    HomeActorsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeViewModel>();
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
    final length = context.read<HomeViewModel>().listCategory.length;
    return SizedBox(
      height: 21,
      child: ListView.separated(
        itemCount: length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 8.0),
        itemBuilder: (context, index) => Consumer<HomeViewModel>(
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