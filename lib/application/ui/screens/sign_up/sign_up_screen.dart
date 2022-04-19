import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/screens/sign_up/sign_up_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';
import '../../widgets/back_button_widget.dart';
import '../../widgets/background_posters_widget.dart';
import '../../widgets/elevated_button_widget.dart';
import '../../widgets/insets_bottom_widget.dart';
import '../../widgets/sliver_app_bar_delegate.dart';
import '../../widgets/text_field_widget.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
    return CustomScrollView(
      slivers: [
        const _AppBar(),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 19.h),
                Text(
                  S.of(context).sign_up_label,
                  style: AppTextStyle.header1,
                ),
                const SizedBox(height: 70),
                const _NameTextFieldWidget(),
                const SizedBox(height: 16),
                const _EmailTextFiledWidget(),
                const SizedBox(height: 16),
                const _PasswordTextFieldWidget(),
                const SizedBox(height: 16),
                const _ConfirmPasswordTextFieldWidget(),
                const Spacer(),
                const SizedBox(height: 16),
                const _SignUpButtonWidget(),
                const InsetsBottomWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NameTextFieldWidget extends StatelessWidget {
  const _NameTextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SignUpViewModel>();
    return TextFieldWidget(
      controller: vm.nameController,
      hintText: S.of(context).enter_your_name,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      enableSuggestions: true,
      maxLines: 1,
    );
  }
}

class _SignUpButtonWidget extends StatelessWidget {
  const _SignUpButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SignUpViewModel>();
    return ElevatedButtonWidget(
      onPressed: vm.canStartAuth ? () => vm.auth(context) : null,
      backgroundColor: AppColors.colorSecondary,
      overlayColor: AppColors.colorSplash,
      child: vm.isAuthProgress
          ? const RepaintBoundary(child: CircularProgressIndicator())
          : Text(
              S.of(context).sign_up,
              style: AppTextStyle.button.copyWith(
                color: AppColors.colorBackground,
              ),
            ),
    );
  }
}

class _ConfirmPasswordTextFieldWidget extends StatelessWidget {
  const _ConfirmPasswordTextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SignUpViewModel>();
    return TextFieldWidget(
      controller: vm.confirmPasswordTextController,
      hintText: S.of(context).enter_confirm_password,
      textInputAction: TextInputAction.done,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      onSubmitted: vm.canStartAuth ? (text) => vm.auth(context) : null,
      enableSuggestions: true,
      maxLines: 1,
    );
  }
}

class _PasswordTextFieldWidget extends StatelessWidget {
  const _PasswordTextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SignUpViewModel>();
    return TextFieldWidget(
      controller: vm.passwordTextController,
      hintText: S.of(context).enter_password,
      textInputAction: TextInputAction.next,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      enableSuggestions: true,
      maxLines: 1,
    );
  }
}

class _EmailTextFiledWidget extends StatelessWidget {
  const _EmailTextFiledWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SignUpViewModel>();
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
