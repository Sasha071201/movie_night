import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/widgets/actors_with_header_widget.dart';
import 'package:provider/provider.dart';

class HomeActorsScreen extends StatelessWidget {
  const HomeActorsScreen({Key? key}) : super(key: key);

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
            header: 'New',
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          ActorsWithHeaderWidget(
            header: 'Popular',
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          ActorsWithHeaderWidget(
            header: 'Rated',
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          ActorsWithHeaderWidget(
            header: 'Bad',
            onPressed: () {},
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
