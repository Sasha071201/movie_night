import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';
import 'package:movie_night/application/ui/screens/sign_in/sign_in_view_model.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/widgets/background_posters_widget.dart';
import 'package:movie_night/application/ui/widgets/elevated_button_widget.dart';
import 'package:movie_night/application/ui/widgets/insets_bottom_widget.dart';
import 'package:movie_night/application/ui/widgets/text_button_widget.dart';
import 'package:movie_night/application/ui/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../generated/l10n.dart';
import '../../themes/app_text_style.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

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
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 27.h),
                Text(
                  S.of(context).sign_in_label,
                  style: AppTextStyle.header1,
                ),
                const SizedBox(height: 70),
                const _EmailTextFieldWidget(),
                const SizedBox(height: 16),
                const _PasswordTextFieldWidget(),
                const ForgotPasswordWidget(),
                const Spacer(),
                const SizedBox(height: 16),
                const _AuthButtonWigdet(),
                TextButtonWidget(
                  child: Text(
                    S.of(context).sign_up,
                    style: AppTextStyle.button.copyWith(
                      color: AppColors.colorSecondary,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pushNamed(Screens.signUp),
                ),
                const InsetsBottomWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButtonWidget(
        child: Text(
          S.of(context).forgot_password,
          style: AppTextStyle.button.copyWith(
            color: AppColors.colorSecondary,
          ),
        ),
        onPressed: () => Navigator.of(context).pushNamed(Screens.resetPassword),
      ),
    );
  }
}

class _AuthButtonWigdet extends StatelessWidget {
  const _AuthButtonWigdet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SignInViewModel>();
    return ElevatedButtonWidget(
      onPressed: vm.canStartAuth ? () => vm.auth(context) : null,
      backgroundColor: AppColors.colorSecondary,
      overlayColor: AppColors.colorSplash,
      child: vm.isAuthProgress
          ? const RepaintBoundary(child: CircularProgressIndicator())
          : Text(
              S.of(context).sign_in,
              style: AppTextStyle.button.copyWith(
                color: AppColors.colorBackground,
              ),
            ),
    );
  }
}

class _PasswordTextFieldWidget extends StatelessWidget {
  const _PasswordTextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SignInViewModel>();
    return TextFieldWidget(
      controller: vm.passwordTextController,
      hintText: S.of(context).enter_password,
      textInputAction: TextInputAction.done,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      enableSuggestions: true,
      onSubmitted: vm.canStartAuth ? (text) => vm.auth(context) : null,
      maxLines: 1,
    );
  }
}

class _EmailTextFieldWidget extends StatelessWidget {
  const _EmailTextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SignInViewModel>();
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
