import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/entities/user.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/user_item_widget.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';

import 'subscriptions_view_model.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SubscriptionsViewModel>().setupLocale(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.colorPrimary,
          leading: const BackButton(color: AppColors.colorSecondary),
          title: Text(
            S.of(context).subscriptions,
            style: AppTextStyle.header3,
          ),
        ),
        body: const SafeArea(
          child: _BodyWidget(),
        ),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const progressIndicator = Center(
        child: CircularProgressIndicator(
      color: AppColors.colorMainText,
    ));

    return Stack(
      alignment: Alignment.center,
      children: [
        CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            Selector<SubscriptionsViewModel, List<User>>(
              selector: (context, vm) => vm.subscriptions,
              builder: (context, users, _) => users.isEmpty
                  ? const SliverToBoxAdapter(child: SizedBox.shrink())
                  : SliverFixedExtentList(
                      itemExtent: 56,
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Column(
                          children: [
                            UserItemWidget(user: users[index]),
                            const Divider(
                              color: AppColors.colorMainText,
                              thickness: 0.1,
                              height: 0,
                            ),
                          ],
                        ),
                        childCount: users.length,
                      ),
                    ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
          ],
        ),
        Consumer<SubscriptionsViewModel>(builder: (context, vm, _) {
          return vm.isLoadingProgress
              ? progressIndicator
              : vm.subscriptions.isEmpty
                  ? Center(
                      child: Text(
                        S.of(context).empty,
                        style: AppTextStyle.header2,
                      ),
                    )
                  : const SizedBox.shrink();
        }),
      ],
    );
  }
}
