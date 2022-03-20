import 'package:flutter/material.dart';

import '../../../widgets/movies_with_header_widget.dart';

class SearchTvShowsScreen extends StatelessWidget {
  const SearchTvShowsScreen({Key? key}) : super(key: key);

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
            header: 'Popular',
          ),
          const SizedBox(height: 16),
          const MoviesWithHeaderWidget(
            header: 'Rated',
          ),
          const SizedBox(height: 16),
          const MoviesWithHeaderWidget(
            header: 'Drama',
          ),
        ],
      ),
    );
  }
}