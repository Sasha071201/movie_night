import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';
import '../../widgets/back_button_widget.dart';
import '../../widgets/background_posters_widget.dart';
import '../../widgets/elevated_button_widget.dart';
import '../../widgets/sliver_app_bar_delegate.dart';
import '../../widgets/text_button_widget.dart';
import '../../widgets/text_field_widget.dart';

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
                  S.of(context).sign_up_label,
                  style: AppTextStyle.header1,
                ),
                const SizedBox(height: 70),
                TextFieldWidget(
                  hintText: S.of(context).enter_email,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  enableSuggestions: true,
                  maxLines: 1,
                ),
                const SizedBox(height: 16),
                TextFieldWidget(
                  hintText: S.of(context).enter_password,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  enableSuggestions: true,
                  maxLines: 1,
                ),
                const SizedBox(height: 16),
                TextFieldWidget(
                  hintText: S.of(context).enter_confirm_password,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  enableSuggestions: true,
                  maxLines: 1,
                ),
                const Spacer(),
                const SizedBox(height: 16),
                ElevatedButtonWidget(
                  onPressed: () {},
                  backgroundColor: AppColors.colorSecondary,
                  overlayColor: AppColors.colorSplash,
                  child: Text(
                    S.of(context).sign_up,
                    style: AppTextStyle.button.copyWith(
                      color: AppColors.colorBackground,
                    ),
                  ),
                ),
                SizedBox(height: insetsBottom == 0 ? 32 : insetsBottom + 16),
              ],
            ),
          ),
        ),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: const [
              BackButtonWidget(),
              Spacer(),
              _LaterButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LaterButtonWidget extends StatelessWidget {
  const _LaterButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButtonWidget(
      child: Text(
        S.of(context).later,
        style: AppTextStyle.button.copyWith(
          color: AppColors.colorSecondary,
        ),
      ),
      onPressed: () {},
    );
  }
}
