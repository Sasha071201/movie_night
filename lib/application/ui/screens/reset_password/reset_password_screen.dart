import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/screens/reset_password/reset_password_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';
import '../../widgets/back_button_widget.dart';
import '../../widgets/background_posters_widget.dart';
import '../../widgets/elevated_button_widget.dart';
import '../../widgets/sliver_app_bar_delegate.dart';
import '../../widgets/text_field_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        body: BackgroundPostersWidget(
          child: SafeArea(
            child: _BodyWidget(),
          ),
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
    final insetsBottom = MediaQuery.of(context).viewInsets.bottom;
    return CustomScrollView(
      slivers: [
        const _AppBar(),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 159),
                Text(
                  S.of(context).reset_password,
                  style: AppTextStyle.header1,
                ),
                const SizedBox(height: 70),
                const _EmailTextFiledWidget(),
                const Spacer(),
                const SizedBox(height: 16),
                const _ResetButtonWidget(),
                SizedBox(height: insetsBottom == 0 ? 32 : insetsBottom + 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ResetButtonWidget extends StatelessWidget {
  const _ResetButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ResetPasswordViewModel>();
    return ElevatedButtonWidget(
      onPressed: vm.canStartAuth ? () => vm.reset(context) : null,
      backgroundColor: AppColors.colorSecondary,
      overlayColor: AppColors.colorSplash,
      child: vm.isAuthProgress ? const RepaintBoundary(child: CircularProgressIndicator()) : Text(
        S.of(context).send_request,
        style: AppTextStyle.button.copyWith(
          color: AppColors.colorBackground,
        ),
      ),
    );
  }
}

class _EmailTextFiledWidget extends StatelessWidget {
  const _EmailTextFiledWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ResetPasswordViewModel>();
    return TextFieldWidget(
      controller: vm.emailTextController,
      hintText: S.of(context).enter_email,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      enableSuggestions: true,
      maxLines: 1,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical:8 ),
          child: Row(
            children: const [
              BackButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
