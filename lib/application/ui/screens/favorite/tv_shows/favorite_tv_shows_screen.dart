import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_text_style.dart';
import '../../../widgets/vertical_widgets_with_header/tv_shows_with_header_widget.dart';
import 'favorite_tv_shows_view_model.dart';

class FavoriteTvShowsScreen extends StatefulWidget {
  const FavoriteTvShowsScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteTvShowsScreen> createState() => _FavoriteTvShowsScreenState();
}

class _FavoriteTvShowsScreenState extends State<FavoriteTvShowsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void didChangeDependencies() {
    context.read<FavoriteTvShowsViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isLoaded =
        context.select((FavoriteTvShowsViewModel vm) => vm.state.isLoaded);
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const _TvShowsWithCategoryWidget(),
          ],
        ),
        if (!isLoaded)
          const Center(
            child: CircularProgressIndicator(
              color: AppColors.colorMainText,
            ),
          ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _TvShowsWithCategoryWidget extends StatelessWidget {
  const _TvShowsWithCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvShowsWithHeader = context
        .select((FavoriteTvShowsViewModel vm) => vm.state.tvShowsWithHeader);
    final isLoaded =
        context.select((FavoriteTvShowsViewModel vm) => vm.state.isLoaded);
    return isLoaded
        ? tvShowsWithHeader.isNotEmpty
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Column(
                      children: [
                        TvShowsWithHeaderWidget(
                          tvShowData: tvShowsWithHeader[index],
                        ),
                      ],
                    );
                  },
                  childCount: tvShowsWithHeader.length,
                ),
              )
            : SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    'Пусто',
                    style: AppTextStyle.header2,
                  ),
                ),
              )
        : const SliverToBoxAdapter();
  }
}
