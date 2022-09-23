import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movie_night/application/ui/screens/favorite/tv_shows/favorite_tv_shows_screen.dart';

import '../../themes/app_colors.dart';
import '../../widgets/appbar/tab_category_iten_widget.dart';
import '../../widgets/sliver_app_bar_delegate.dart';
import 'actors/favorite_actors_screen.dart';
import 'favorite_view_model.dart';
import 'movies/favorite_movies_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    Key? key,
  }) : super(key: key);

  static const _children = [
    FavoriteMoviesScreen(),
    FavoriteTvShowsScreen(),
    FavoriteActorsScreen(),
  ];

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void didChangeDependencies() {
    context.read<FavoriteViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<FavoriteViewModel>();
    final userId = context.select((FavoriteViewModel vm) => vm.userId);
    return userId != null
        ? Column(
            children: [
              _AppBar(userId: userId),
              Expanded(
                child: Consumer<FavoriteViewModel>(
                  builder: (context, vm, _) => FavoriteScreen._children[vm.currentCategoryIndex],
                ),
              ),
            ],
          )
        : NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [const _AppBar()],
            body: PageView(
              children: FavoriteScreen._children,
              onPageChanged: (index) => vm.selectCategory(index, context),
              controller: vm.categoryController,
            ),
          );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
    this.userId,
  }) : super(key: key);

  final String? userId;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      color: AppColors.colorPrimary,
      child: const Center(
        child: _TabsCategoryWidget(),
      ),
    );
    return userId != null
        ? content
        : SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: SliverAppBarDelegate(
              content,
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
    final listCategory = context.select((FavoriteViewModel vm) => vm.listCategory);
    return listCategory.isNotEmpty
        ? SizedBox(
            height: 48,
            child: ListView.separated(
              itemCount: listCategory.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 8.0),
              itemBuilder: (context, index) => Consumer<FavoriteViewModel>(
                builder: (context, vm, _) => TabCategoryItemWidget(
                  index: index,
                  currentIndex: vm.currentCategoryIndex,
                  items: listCategory,
                  selectCategory: vm.selectCategory,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
