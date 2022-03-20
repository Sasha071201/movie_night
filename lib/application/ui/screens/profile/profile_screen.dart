import 'package:flutter/material.dart';
import 'package:movie_night/application/resources/resources.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/elevated_button_widget.dart';
import 'package:movie_night/application/ui/widgets/text_button_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SignOutWidget(),
        const _AvatarImageWidget(),
        const SizedBox(height: 8),
        Text(
          'Anastasii',
          style: AppTextStyle.header1.copyWith(
            color: AppColors.colorSecondary,
          ),
        ),
        Text(
          'Free plan',
          style: AppTextStyle.header2.copyWith(
            color: AppColors.colorSecondaryText,
          ),
        ),
        const SizedBox(height: 8.0),
        ElevatedButtonWidget(
          onPressed: () {},
          width: 185,
          child: Text(
            'Upgrade Plan',
            style: AppTextStyle.button,
          ),
        ),
      ],
    );
  }
}

class _AvatarImageWidget extends StatelessWidget {
  const _AvatarImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 75,
      foregroundImage: AssetImage(
        AppImages.profileExample,
      ),
    );
  }
}

class _SignOutWidget extends StatelessWidget {
  const _SignOutWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButtonWidget(
          child: Text(
            'Sign Out',
            style: AppTextStyle.button.copyWith(
              color: AppColors.colorSecondary,
            ),
          ),
          onPressed: () => AppNavigation.resetNavigation(context),
        ),
      ),
    );
  }
}
