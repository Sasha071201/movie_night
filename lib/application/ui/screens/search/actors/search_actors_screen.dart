import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/widgets/actors_with_header_widget.dart';

class SearchActorsScreen extends StatelessWidget {
  const SearchActorsScreen({Key? key}) : super(key: key);

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
          ActorsWithHeaderWidget(
            header: 'Popular',
            onPressed: () {},
          ),
          ActorsWithHeaderWidget(
            header: 'Rated',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
