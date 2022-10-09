import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/firebase/firebase_dynamic_link.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';
import 'package:movie_night/application/ui/widgets/button_tile_widget.dart';
import 'package:movie_night/application/ui/widgets/icon_button_widget.dart';
import 'package:provider/provider.dart';

import 'package:movie_night/application/resources/resources.dart';
import 'package:movie_night/application/ui/screens/profile/profile_view_model.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/text_button_widget.dart';
import 'package:share_plus/share_plus.dart';

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
            SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const _AvatarImageWidget(),
                  Positioned(
                    right: 24,
                    top: 0,
                    child: Column(
                      children: [
                        IconButtonWidget(
                          icon: const Icon(
                            Icons.share,
                            color: AppColors.colorSecondary,
                            size: 32,
                          ),
                          onPressed: () async {
                            final userId = context.read<ProfileViewModel>().userId;
                            final userName = context.read<ProfileViewModel>().nameFromDB;
                            if (userId == null) return;
                            final url = await FirebaseDynamicLinkService.createDynamicLink(
                              type: FirebaseDynamicLinkType.person,
                              id: userId,
                              short: true,
                              title: userName,
                              description: '',
                            );
                            Share.share(url);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const _NameWidget(),
            const SizedBox(height: 16),
            _ButtonMenuWidget(
              title: S.of(context).about_me,
              onPressed: () => vm.openAboutMe(context),
            ),
            const SizedBox(height: 1),
            const _SubscriberButtonsWidget(),
            const SizedBox(height: 1),
            _ButtonMenuWidget(
              title: S.of(context).find_people,
              onPressed: () => vm.openUsers(context),
            ),
            const SizedBox(height: 1),
            _ButtonMenuWidget(
              title: S.of(context).settings,
              onPressed: () => Navigator.of(context).pushNamed(Screens.settings),
            ),
          ],
        ),
        const RepaintBoundary(child: _CircularProgressIndicatorWidget()),
      ],
    );
  }
}

class _SubscriberButtonsWidget extends StatelessWidget {
  const _SubscriberButtonsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ButtonTileWidget(
            onPressed: () => Navigator.of(context).pushNamed(Screens.subscribers),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).subscribers,
                  style: AppTextStyle.header3,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 1),
        Expanded(
          child: ButtonTileWidget(
            onPressed: () => Navigator.of(context).pushNamed(Screens.subscriptions),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).subscriptions,
                  style: AppTextStyle.header3,
                ),
              ],
            ),
          ),
        )
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
    final isLoadingProgress = context.select((ProfileViewModel vm) => vm.isLoadingProgress);
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
    return SelectableText(
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
    return ButtonTileWidget(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyle.header3,
          ),
        ],
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
