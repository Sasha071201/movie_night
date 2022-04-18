import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../themes/app_colors.dart';
import '../../../widgets/vertical_widgets_with_header/actors_with_header_widget.dart';
import 'search_actors_view_model.dart';

class SearchActorsScreen extends StatefulWidget {
  const SearchActorsScreen({Key? key}) : super(key: key);

  @override
  State<SearchActorsScreen> createState() => _SearchActorsScreenState();
}

class _SearchActorsScreenState extends State<SearchActorsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void didChangeDependencies() {
    context.read<SearchActorsViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final actorsWithHeader =
        context.select((SearchActorsViewModel vm) => vm.state.actorsWithHeader);
    return Stack(
      children: [
        CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
        context.select((SearchActorsViewModel vm) => vm.state.actorsWithHeader);
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
