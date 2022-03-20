import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/screens/home/tv_shows/home_tv_shows_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_dimensions.dart';
import '../../../../resources/resources.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/movies_with_header_widget.dart';
import 'favorite_tv_shows_view_model.dart';

class FavoriteTvShowsScreen extends StatelessWidget {
  const FavoriteTvShowsScreen({Key? key}) : super(key: key);

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
          const MoviesWithHeaderWidget(
            header: 'Favorite',
          ),
          const SizedBox(height: 16),
          const MoviesWithHeaderWidget(
            header: 'Favorite and not seen',
          ),
          const SizedBox(height: 16),
          const MoviesWithHeaderWidget(
            header: 'Watched',
          ),
        ],
      ),
    );
  }
}