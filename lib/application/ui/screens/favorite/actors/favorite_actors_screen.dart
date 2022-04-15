import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_text_style.dart';
import '../../../widgets/vertical_widgets_with_header/actors_with_header_widget.dart';
import 'favorite_actors_view_model.dart';

class FavoriteActorsScreen extends StatefulWidget {
  const FavoriteActorsScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteActorsScreen> createState() => _FavoriteActorsScreenState();
}

class _FavoriteActorsScreenState extends State<FavoriteActorsScreen> with AutomaticKeepAliveClientMixin {
  
  @override
  void didChangeDependencies() {
    context.read<FavoriteActorsViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isLoaded =
        context.select((FavoriteActorsViewModel vm) => vm.state.isLoaded);
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
            const _ActorsWithCategoryWidget(),
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

class _ActorsWithCategoryWidget extends StatelessWidget {
  const _ActorsWithCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actorsWithHeader = context
        .select((FavoriteActorsViewModel vm) => vm.state.actorsWithHeader);
    final isLoaded =
        context.select((FavoriteActorsViewModel vm) => vm.state.isLoaded);
    return isLoaded
        ? actorsWithHeader.isNotEmpty
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Column(
                      children: [
                        ActorsWithHeaderWidget(
                          actorData: actorsWithHeader[index],
                        ),
                      ],
                    );
                  },
                  childCount: actorsWithHeader.length,
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
