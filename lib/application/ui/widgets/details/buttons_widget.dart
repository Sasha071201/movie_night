import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/firebase/firebase_dynamic_link.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../generated/l10n.dart';
import '../../navigation/app_navigation.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';
import '../text_button_widget.dart';

class ButtonsWidget extends StatelessWidget {
  final List<dynamic> videos;
  final void Function()? onPressedWatch;
  final bool isWatched;
  final bool showWatched;
  final bool showShare;
  final FirebaseDynamicLinkType? dynamicLinkType;
  final int id;
  const ButtonsWidget({
    Key? key,
    required this.videos,
    this.onPressedWatch,
    this.isWatched = false,
    this.showWatched = true,
    this.showShare = false,
    this.dynamicLinkType,
    this.id = -1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: [
        if (videos.isNotEmpty) ...[
          TextButtonWidget(
            onPressed: () {
              String? trailer;
              try {
                trailer = videos
                    .firstWhere((element) => element.site == 'YouTube' && element.key.isNotEmpty)
                    .key;
              } catch (e) {
                trailer = videos.first['key'];
              }
              if (trailer != null) {
                Navigator.of(context).pushNamed(
                  Screens.trailer,
                  arguments: trailer,
                );
              }
            },
            backgroundColor: AppColors.colorPrimary,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.play_arrow,
                  color: AppColors.colorSecondary,
                ),
                Text(
                  S.of(context).trailer,
                  style: AppTextStyle.small,
                ),
              ],
            ),
          ),
        ],
        if (showWatched)
          TextButtonWidget(
            onPressed: onPressedWatch!,
            backgroundColor: AppColors.colorPrimary,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isWatched ? Icons.visibility : Icons.visibility_off,
                  color: isWatched ? AppColors.colorSecondary : AppColors.colorSecondaryText,
                ),
                const SizedBox(width: 4),
                Text(
                  isWatched ? S.of(context).watched : S.of(context).not_watched,
                  style: AppTextStyle.small,
                ),
              ],
            ),
          ),
        if (showShare)
          TextButtonWidget(
            onPressed: () async {
              if (id != -1 && dynamicLinkType == null) return;
              final url = await FirebaseDynamicLinkService.createDynamicLink(
                type: dynamicLinkType!,
                id: id,
                short: true,
              );
              Share.share(url);
            },
            backgroundColor: AppColors.colorPrimary,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.share,
                  color: AppColors.colorSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  S.of(context).share,
                  style: AppTextStyle.small,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
