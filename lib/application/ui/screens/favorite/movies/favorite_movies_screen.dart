import 'package:flutter/material.dart';
import '../../../widgets/movies_with_header_widget.dart';

class FavoriteMoviesScreen extends StatelessWidget {
  const FavoriteMoviesScreen({Key? key}) : super(key: key);

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