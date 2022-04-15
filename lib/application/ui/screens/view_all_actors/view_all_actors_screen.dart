import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/screens/view_all_actors/view_all_actors_view_model.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/vertical_widgets_with_header/vertical_actor_widget.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';

class ViewAllActorsScreen extends StatefulWidget {
  const ViewAllActorsScreen({Key? key}) : super(key: key);

  @override
  State<ViewAllActorsScreen> createState() => _ViewAllActorsScreenState();
}

class _ViewAllActorsScreenState extends State<ViewAllActorsScreen> {
  @override
  void didChangeDependencies() {
    context.read<ViewAllActorsViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: AppColors.colorSecondary),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _HeaderWidget(),
              SizedBox(height: 8.0),
              Expanded(
                child: _ListActorsWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListActorsWidget extends StatelessWidget {
  const _ListActorsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ViewAllActorsViewModel>();
    final isLoadingProgress = context
        .select((ViewAllActorsViewModel vm) => vm.state.isLoadingProgress);
    final actors =
        context.select((ViewAllActorsViewModel vm) => vm.state.actors);
    return actors.isNotEmpty
        ? Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GridView.builder(
                itemCount: actors.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 130 / 265, //188 - height, 130 - width
                ),
                itemBuilder: (context, index) {
                  vm.showedCategoryAtIndex(index);
                  return VerticalActorWidget(
                    actor: actors[index],
                  );
                },
              ),
              if (isLoadingProgress)
                const Positioned(
                  bottom: 16,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.colorMainText,
                    ),
                  ),
                ),
            ],
          )
        : const Center(
            child: CircularProgressIndicator(
              color: AppColors.colorMainText,
            ),
          );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${S.of(context).popular} ${S.of(context).people}',
      style: AppTextStyle.header2,
    );
  }
}
