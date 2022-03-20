import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/screens/search/movies/search_movies_view_model.dart';
import 'package:movie_night/application/ui/widgets/action_chip_widget.dart';
import 'package:provider/provider.dart';
import '../../../navigation/app_navigation.dart';
import '../../../themes/app_text_style.dart';
import '../../../widgets/filter_button_widget.dart';
import '../../../widgets/movies_with_header_widget.dart';

class SearchMoviesScreen extends StatelessWidget {
  const SearchMoviesScreen({Key? key}) : super(key: key);

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
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 8.0,
                top: 8.0,
              ),
              child: FilterButtonWidget(),
            ),
          ),
          const _GenresWidget(),
          const SizedBox(height: 4),
          const MoviesWithHeaderWidget(
            header: 'Popular',
          ),
          const SizedBox(height: 16),
          const MoviesWithHeaderWidget(
            header: 'Rated',
          ),
          const SizedBox(height: 16),
          const MoviesWithHeaderWidget(
            header: 'New',
          ),
        ],
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
            'Genres',
            style: AppTextStyle.header3,
          ),
        ),
        Consumer<SearchMoviesViewModel>(
          builder: (context, vm, _) => SizedBox(
            height: 25+24,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: vm.listGenres.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) => Column(
                children: [
                  const SizedBox(height: 12),
                  ActionChipWidget(
                    child: Text(vm.listGenres[index]),
                    onPressed: () =>
                        Navigator.of(context).pushNamed(Screens.viewAllMovies),
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
