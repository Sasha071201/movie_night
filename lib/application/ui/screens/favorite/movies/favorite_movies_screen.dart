import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/generated/l10n.dart';
import 'package:provider/provider.dart';

import '../../../themes/app_colors.dart';
import '../../../widgets/vertical_widgets_with_header/movies_with_header_widget.dart';
import 'favorite_movies_view_model.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  const FavoriteMoviesScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteMoviesScreen> createState() => _FavoriteMoviesScreenState();
}

class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void didChangeDependencies() {
    context.read<FavoriteMoviesViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final userId = context.select((FavoriteMoviesViewModel vm) => vm.userId);
    final isLoaded = context.select((FavoriteMoviesViewModel vm) => vm.state.isLoaded);
    return Stack(
      children: [
        CustomScrollView(
          physics: userId != null ? const NeverScrollableScrollPhysics() : null,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const _MoviesWithCategoryWidget(),
          ],
        ),
        if (!isLoaded)
          const Center(
            child: RepaintBoundary(
              child: CircularProgressIndicator(
                color: AppColors.colorMainText,
              ),
            ),
          ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _MoviesWithCategoryWidget extends StatelessWidget {
  const _MoviesWithCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = context.read<FavoriteMoviesViewModel>().userId;
    final moviesWithHeader =
        context.select((FavoriteMoviesViewModel vm) => vm.state.moviesWithHeader);
    final isLoaded = context.select((FavoriteMoviesViewModel vm) => vm.state.isLoaded);
    return isLoaded
        ? moviesWithHeader.isNotEmpty
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Column(
                      children: [
                        MoviesWithHeaderWidget(
                          movieData: moviesWithHeader[index],
                          userId: userId,
                        ),
                      ],
                    );
                  },
                  childCount: moviesWithHeader.length,
                ),
              )
            : SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    S.of(context).empty,
                    style: AppTextStyle.header2,
                  ),
                ),
              )
        : const SliverToBoxAdapter();
  }
}
