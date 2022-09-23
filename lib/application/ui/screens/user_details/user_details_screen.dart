import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/entities/user.dart';
import 'package:movie_night/application/domain/firebase/firebase_dynamic_link.dart';
import 'package:movie_night/application/resources/resources.dart';
import 'package:movie_night/application/ui/screens/favorite/favotite_screen.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/icon_button_widget.dart';
import 'package:movie_night/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'user_details_view_model.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<UserDetailsViewModel>().setupLocale(context);
    });
    super.initState();
  }

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
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButton(color: AppColors.colorSecondary),
                const _HeaderWidget(),
                const SizedBox(height: 8),
                const Center(child: _NameWidget()),
                const SizedBox(height: 16),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 90,
                  child: const FavoriteScreen(),
                ),
              ],
            ),
          ),
        ),
        const RepaintBoundary(child: _CircularProgressIndicatorWidget()),
      ],
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<UserDetailsViewModel>();
    final isFavorite = context.select((UserDetailsViewModel vm) => vm.isFavorite);
    return SizedBox(
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
                  icon: Icon(
                    Icons.favorite,
                    color: isFavorite ? AppColors.colorSecondary : AppColors.colorSecondaryText,
                    size: 32,
                  ),
                  onPressed: vm.favoriteUser,
                ),
                IconButtonWidget(
                  icon: const Icon(
                    Icons.share,
                    color: AppColors.colorSecondary,
                    size: 32,
                  ),
                  onPressed: () async {
                    final userId = context.read<UserDetailsViewModel>().userId;
                    final userName = context.read<UserDetailsViewModel>().userName;
                    final url = await FirebaseDynamicLinkService.createDynamicLink(
                      type: FirebaseDynamicLinkType.person,
                      id: userId,
                      short: true,
                      title: userName ?? S.of(context).user,
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
    );
  }
}

class _NameWidget extends StatelessWidget {
  const _NameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((UserDetailsViewModel vm) => vm.user);
    return StreamBuilder<User>(
        stream: user,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.done:
              return const SizedBox.shrink();
            case ConnectionState.active:
              final data = snapshot.data;
              Future.microtask(() => context.read<UserDetailsViewModel>().userName = data?.name);
              if (data == null) {
                return const SizedBox.shrink();
              }
              return SelectableText(
                snapshot.data?.name ?? '',
                style: AppTextStyle.header2.copyWith(
                  color: AppColors.colorSecondary,
                ),
              );
          }
        });
  }
}

class _CircularProgressIndicatorWidget extends StatelessWidget {
  const _CircularProgressIndicatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoadingProgress = context.select((UserDetailsViewModel vm) => vm.isLoadingProgress);
    return isLoadingProgress
        ? const CircularProgressIndicator(
            color: AppColors.colorMainText,
          )
        : const SizedBox.shrink();
  }
}

class _AvatarImageWidget extends StatelessWidget {
  const _AvatarImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((UserDetailsViewModel vm) => vm.user);
    return StreamBuilder<User>(
        stream: user,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.done:
              return const SizedBox.shrink();
            case ConnectionState.active:
              final data = snapshot.data;
              if (data == null) {
                return const SizedBox.shrink();
              }
              final image = data.urlProfileImage != null && data.urlProfileImage?.isNotEmpty == true
                  ? Image.network(
                      data.urlProfileImage!,
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
        });
  }
}
