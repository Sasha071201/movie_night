import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movie_night/application/resources/resources.dart';
import 'package:movie_night/application/ui/screens/profile/profile_view_model.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/inkwell_material_widget.dart';
import 'package:movie_night/application/ui/widgets/text_button_widget.dart';

import '../../../../generated/l10n.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ProfileViewModel>();
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            const _SignOutButtonWidget(),
            const _AvatarImageWidget(),
            const SizedBox(height: 8),
            const _NameWidget(),
            const SizedBox(height: 8),
            _ButtonMenuWidget(
              title: S.of(context).about_me,
              onPressed: () => vm.openAboutMe(context),
            ),
            const SizedBox(height: 1),
            // _ButtonMenuWidget(
            //   title: 'Subscription',
            //   onPressed: () => vm.openSubscription(context),
            // ),
          ],
        ),
        const RepaintBoundary(child: _CircularProgressIndicatorWidget()),
      ],
    );
  }
}

class _CircularProgressIndicatorWidget extends StatelessWidget {
  const _CircularProgressIndicatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoadingProgress =
        context.select((ProfileViewModel vm) => vm.isLoadingProgress);
    return isLoadingProgress
        ? const CircularProgressIndicator(
            color: AppColors.colorMainText,
          )
        : const SizedBox.shrink();
  }
}

class _NameWidget extends StatelessWidget {
  const _NameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = context.select((ProfileViewModel vm) => vm.nameFromDB);
    return Text(
      name,
      style: AppTextStyle.header2.copyWith(
        color: AppColors.colorSecondary,
      ),
    );
  }
}

class _ButtonMenuWidget extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const _ButtonMenuWidget({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWellMaterialWidget(
      borderRadius: 0,
      color: AppColors.colorSplash,
      onTap: onPressed,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: AppColors.colorPrimary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyle.header3,
            ),
            const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.colorSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarImageWidget extends StatelessWidget {
  const _AvatarImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final url = context.select((ProfileViewModel vm) => vm.profileImageUrl);
    final image = url.isNotEmpty
        ? Image.network(
            url,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, object, stacktrace) => Image.asset(
              AppImages.placeholder,
              width: 150,
              height: 150,
              color: AppColors.colorMainText,
              fit: BoxFit.cover,
            ),
          )
        : Image.asset(
            AppImages.placeholder,
            width: 150,
            height: 150,
            color: AppColors.colorMainText,
            fit: BoxFit.cover,
          );
    return ClipRRect(
      borderRadius: BorderRadius.circular(90),
      child: image,
    );
  }
}

class _SignOutButtonWidget extends StatelessWidget {
  const _SignOutButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ProfileViewModel>();
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButtonWidget(
            child: Text(
              S.of(context).sign_out,
              style: AppTextStyle.button.copyWith(
                color: AppColors.colorSecondary,
              ),
            ),
            onPressed: () => vm.signOut(context)),
      ),
    );
  }
}
