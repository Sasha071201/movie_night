import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../themes/app_colors.dart';
import '../../../widgets/vertical_widgets_with_header/actors_with_header_widget.dart';
import 'home_actors_view_model.dart';

class HomeActorsScreen extends StatefulWidget {
  const HomeActorsScreen({Key? key}) : super(key: key);

  @override
  State<HomeActorsScreen> createState() => _HomeActorsScreenState();
}

class _HomeActorsScreenState extends State<HomeActorsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void didChangeDependencies() {
    context.read<HomeActorsViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final actorsWithHeader =
        context.select((HomeActorsViewModel vm) => vm.state.actorsWithHeader);
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
        if (actorsWithHeader.isEmpty)
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

class _ActorsWithCategoryWidget extends StatelessWidget {
  const _ActorsWithCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actorsWithHeader =
        context.select((HomeActorsViewModel vm) => vm.state.actorsWithHeader);
    return SliverList(
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
    );
  }
}
