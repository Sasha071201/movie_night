import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/domain/entities/search/multi_search.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';
import 'package:movie_night/application/ui/screens/search/search_view_model.dart';
import 'package:movie_night/application/ui/screens/search/tv_shows/search_tv_shows_screen.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/text_button_widget.dart';
import 'package:movie_night/application/ui/widgets/text_field_widget.dart';

import '../../../../generated/l10n.dart';
import '../../themes/app_colors.dart';
import '../../widgets/appbar/tab_category_iten_widget.dart';
import '../../widgets/overlay_search/actor_suggestion_item_widget.dart';
import '../../widgets/overlay_search/movie_suggestion_item_widget.dart';
import '../../widgets/overlay_search/search_suggestions.dart';
import '../../widgets/overlay_search/tv_show_suggestion_item.dart';
import '../../widgets/sliver_app_bar_delegate.dart';
import 'actors/search_actors_screen.dart';
import 'movies/search_movies_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  static const _children = [
    SearchMoviesScreen(),
    SearchTvShowsScreen(),
    SearchActorsScreen(),
  ];

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void didChangeDependencies() {
    context.read<SearchViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SearchViewModel>();
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        const _AppBar(),
      ],
      body: PageView(
        children: SearchScreen._children,
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
          child: Column(
            children: const [
              SizedBox(height: 24),
              _SearchAppBarWidget(),
              _TabsCategoryWidget(),
            ],
          ),
        ),
        maxHeight: 128,
        minHeight: 128,
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
        dateFormat: vm.dateFormat,
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
        if (type == MediaType.movie) {
          Navigator.of(context)
              .pushNamed(Screens.movieDetails, arguments: result);
        } else if (type == MediaType.tv) {
          Navigator.of(context)
              .pushNamed(Screens.tvShowDetails, arguments: result);
        } else if (type == MediaType.person) {
          Navigator.of(context)
              .pushNamed(Screens.actorDetails, arguments: result);
        }
      },
      onSearch: (result) {
        if (result.isNotEmpty) {
          Navigator.of(context)
              .pushNamed(Screens.viewSearchResult, arguments: result);
        }
      },
      suggestions: (value) => vm.fetchSuggestions(value),
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
            textCapitalization: TextCapitalization.words,
            hintText: S.of(context).enter_movie_tv_show_person,
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
              S.of(context).cancel,
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
  final List<MultiSearchResult> items;
  final void Function(int id, MediaType) onItemTapped;
  final void Function() onViewAllPressed;
  final DateFormat dateFormat;

  const _SuggestionsWidget({
    Key? key,
    required this.items,
    required this.onItemTapped,
    required this.onViewAllPressed,
    required this.dateFormat,
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
                if (items[index].mediaType == MediaType.movie) {
                  child = MovieSuggestionItemWidget(
                      item: items[index], dateFormat: dateFormat);
                } else if (items[index].mediaType == MediaType.tv) {
                  child = TvShowSuggestionItemWidget(
                      item: items[index], dateFormat: dateFormat);
                } else if (items[index].mediaType == MediaType.person) {
                  child = ActorSuggestionItemWidget(item: items[index]);
                }
                return InkWell(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(5),
                      child: child,
                    ),
                    onTap: () {
                      onItemTapped(items[index].id, items[index].mediaType!);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextButtonWidget(
              child: Text(
                S.of(context).view_all,
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
    final listCategory = context.select((SearchViewModel vm) => vm.listCategory);
    return listCategory.isNotEmpty ? SizedBox(
      height: 48,
      child: ListView.separated(
        itemCount: listCategory.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 8.0),
        itemBuilder: (context, index) => Consumer<SearchViewModel>(
          builder: (context, vm, _) => TabCategoryItemWidget(
            index: index,
            currentIndex: vm.currentCategoryIndex,
            items: listCategory,
            selectCategory: vm.selectCategory,
          ),
        ),
      ),
    ) : const SizedBox.shrink();
  }
}
