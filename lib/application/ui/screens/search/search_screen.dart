import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movie_night/application/domain/entities/actor.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';
import 'package:movie_night/application/ui/screens/search/search_view_model.dart';
import 'package:movie_night/application/ui/screens/search/tv_shows/favorite_tv_shows_screen.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/text_button_widget.dart';
import 'package:movie_night/application/ui/widgets/text_field_widget.dart';

import '../../../domain/entities/movie.dart';
import '../../themes/app_colors.dart';
import '../../widgets/appbar/tab_category_iten_widget.dart';
import '../../widgets/overlay_search/actor_suggestion_item_widget.dart';
import '../../widgets/overlay_search/movie_suggestion_item_widget.dart';
import '../../widgets/overlay_search/search_suggestions.dart';
import '../../widgets/sliver_app_bar_delegate.dart';
import 'actors/search_actors_screen.dart';
import 'movies/search_movies_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  static const _children = [
    SearchMoviesScreen(),
    SearchTvShowsScreen(),
    SearchActorsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SearchViewModel>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const _AppBar(),
        ],
        body: PageView(
          children: _children,
          onPageChanged: (index) => vm.selectCategory(index, context),
          controller: vm.categoryController,
        ),
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
          child: Column(
            children: const [
              Spacer(flex: 24),
              _SearchAppBarWidget(),
              Spacer(flex: 10),
              _TabsCategoryWidget(),
              Spacer(flex: 18),
            ],
          ),
        ),
        maxHeight: 100,
        minHeight: 100,
      ),
    );
  }
}

class _SearchAppBarWidget extends StatelessWidget {
  const _SearchAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SearchViewModel>();
    return SearchSuggestions(
      builderSuggestions: (items, onItemTapped, onViewAllPressed) =>
          _SuggestionsWidget(
        items: items,
        onItemTapped: onItemTapped,
        onViewAllPressed: onViewAllPressed,
      ),
      builderTextField: (
        controller,
        focusNode,
        onSubmitted,
        onClose,
        canCancel,
      ) =>
          _AppBarTextFieldWidget(
        controller: controller,
        focusNode: focusNode,
        onSubmitted: onSubmitted,
        onClose: onClose,
        canCancel: canCancel,
      ),
      suggestionBackgroundColor: AppColors.colorPrimary,
      onTapped: (result, type) {
        if (type == Movie) {
          Navigator.of(context).pushNamed(Screens.movieDetails);
        } else if (type == Actor) {
          Navigator.of(context).pushNamed(Screens.actorDetails);
        }
      },
      onSearch: (result, type) {
        if (type == Movie) {
          Navigator.of(context).pushNamed(Screens.viewAllMovies);
        } else if (type == Actor) {
          Navigator.of(context)
              .pushNamed(Screens.viewAllMovies); //TODO create viewAllActors
        }
      },
      suggestions: (value) async => await vm.fetchSuggestions(value),
    );
  }
}

class _AppBarTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String value) onSubmitted;
  final void Function() onClose;
  final bool canCancel;
  const _AppBarTextFieldWidget({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onSubmitted,
    required this.onClose,
    required this.canCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(flex: 16),
        Flexible(
          flex: 301,
          child: TextFieldWidget(
            suffixIcon: GestureDetector(
              onTap: () => controller.clear(),
              child: const Icon(Icons.clear),
            ),
            showSuffixIcon: controller.text.isNotEmpty,
            controller: controller,
            focusNode: focusNode,
            hintText: 'Enter movies, TV shows, actors',
            textInputAction: TextInputAction.search,
            keyboardType: TextInputType.text,
            enableSuggestions: true,
            maxLines: 1,
            fillColor: AppColors.colorMainText,
            cursorColor: AppColors.colorPrimary,
            textColor: AppColors.colorBackground,
            onSubmitted: onSubmitted,
          ),
        ),
        if (canCancel) ...[
          const Spacer(flex: 8),
          TextButtonWidget(
            child: Text(
              'Cancel',
              style: AppTextStyle.medium,
            ),
            onPressed: onClose,
          ),
        ],
        const Spacer(flex: 16),
      ],
    );
  }
}

class _SuggestionsWidget extends StatelessWidget {
  final List<dynamic> items;
  final void Function(String itemName) onItemTapped;
  final void Function() onViewAllPressed;

  const _SuggestionsWidget({
    Key? key,
    required this.items,
    required this.onItemTapped,
    required this.onViewAllPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: items.length,
              itemBuilder: (context, index) {
                Widget child = const CircularProgressIndicator();
                if (items[index] is Movie) {
                  Movie item = items[index] as Movie;
                  child = MovieSuggestionItemWidget(item: item);
                } else if (items[index] is Actor) {
                  Actor item = items[index] as Actor;
                  child = ActorSuggestionItemWidget(item: item);
                }
                return InkWell(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(5),
                      child: child,
                    ),
                    onTap: () {
                      if (items[index] is Movie) {
                        final item = items[index] as Movie;
                        onItemTapped(item.title);
                      } else if (items[index] is Actor) {
                        final item = items[index] as Actor;
                        onItemTapped(item.name);
                      }
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextButtonWidget(
              child: Text(
                'View All',
                style: AppTextStyle.medium.copyWith(
                  color: AppColors.colorSecondary,
                ),
              ),
              onPressed: onViewAllPressed,
            ),
          ),
        ],
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
    final length = context.read<SearchViewModel>().listCategory.length;
    return SizedBox(
      height: 21,
      child: ListView.separated(
        itemCount: length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 8.0),
        itemBuilder: (context, index) => Consumer<SearchViewModel>(
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
