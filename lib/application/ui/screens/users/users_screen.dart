import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/entities/user.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/sliver_app_bar_delegate.dart';
import 'package:movie_night/application/ui/widgets/text_button_widget.dart';
import 'package:movie_night/application/ui/widgets/user_item_widget.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../widgets/back_button_widget.dart';
import '../../widgets/text_field_widget.dart';

import 'users_view_model.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const Scaffold(
        body: SafeArea(
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
            const _AppBar(),
            Selector<UsersViewModel, Stream<List<User>>?>(
              selector: (context, vm) => vm.users,
              builder: (context, users, _) => users == null
                  ? const SliverToBoxAdapter(child: SizedBox.shrink())
                  : StreamBuilder<List<User>>(
                      stream: users,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                          case ConnectionState.done:
                            return const SliverToBoxAdapter(child: SizedBox.shrink());
                          case ConnectionState.active:
                            final data = snapshot.data;
                            if (data == null) {
                              return const SliverToBoxAdapter(child: SizedBox.shrink());
                            }
                            return SliverFixedExtentList(
                              itemExtent: 56,
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => Column(
                                  children: [
                                    UserItemWidget(user: data[index]),
                                    const Divider(
                                      color: AppColors.colorMainText,
                                      thickness: 0.1,
                                      height: 0,
                                    ),
                                  ],
                                ),
                                childCount: data.length,
                              ),
                            );
                        }
                      },
                    ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
          ],
        ),
        Consumer<UsersViewModel>(builder: (context, vm, _) {
          return vm.isLoading
              ? progressIndicator
              : vm.users == null
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        S.of(context).enter_name_you_are_looking_for,
                        style: AppTextStyle.header2,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : const SizedBox.shrink();
        }),
      ],
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: SliverAppBarDelegate(
        Container(
          color: AppColors.colorPrimary,
          child: Column(
            children: const [
              SizedBox(height: 16),
              _AppBarRow(),
            ],
          ),
        ),
        maxHeight: 80,
        minHeight: 80,
      ),
    );
  }
}

class _AppBarRow extends StatelessWidget {
  const _AppBarRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<UsersViewModel>(builder: (context, vm, _) {
          return Row(
            children: [
              if (!vm.canCancel) const BackButtonWidget(),
              SizedBox(width: vm.canCancel ? 8 : 0),
            ],
          );
        }),
        const SizedBox(
          width: 290,
          child: _AppBarTextFieldWidget(),
        ),
        Consumer<UsersViewModel>(builder: (context, vm, _) {
          return Row(
            children: [
              if (vm.canCancel) ...[
                TextButtonWidget(
                  child: Text(
                    S.of(context).cancel,
                    style: AppTextStyle.medium,
                  ),
                  onPressed: () {
                    vm.searchController.clear();
                    vm.focusNode.unfocus();
                  },
                ),
              ],
            ],
          );
        }),
      ],
    );
  }
}

class _AppBarTextFieldWidget extends StatefulWidget {
  const _AppBarTextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_AppBarTextFieldWidget> createState() => _AppBarTextFieldWidgetState();
}

class _AppBarTextFieldWidgetState extends State<_AppBarTextFieldWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final vm = context.read<UsersViewModel>();
      vm.init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<UsersViewModel>();
    return TextFieldWidget(
      suffixIcon: GestureDetector(
        onTap: () => vm.searchController.clear(),
        child: const Icon(Icons.clear),
      ),
      showSuffixIcon: vm.searchController.text.isNotEmpty,
      controller: vm.searchController,
      focusNode: vm.focusNode,
      textCapitalization: TextCapitalization.words,
      hintText: S.of(context).enter_name,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      enableSuggestions: true,
      maxLines: 1,
      fillColor: AppColors.colorMainText,
      cursorColor: AppColors.colorPrimary,
      textColor: AppColors.colorBackground,
    );
  }
}
