import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_dimensions.dart';
import '../../../domain/api_client/image_downloader.dart';
import '../../../domain/entities/actor/actor.dart';
import '../../navigation/app_navigation.dart';
import '../../screens/main/main_view_model.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';
import '../cached_network_image_widget.dart';
import '../inkwell_material_widget.dart';

class VerticalActorWidget extends StatelessWidget {
  final Actor actor;
  final void Function()? onPressed;

  const VerticalActorWidget({
    Key? key,
    required this.actor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: InkWellMaterialWidget(
        onTap: () async {
          try {
            context.read<MainViewModel>().showAdIfAvailable();
          } catch (e) {}
          await Navigator.of(context)
              .pushNamed(Screens.actorDetails, arguments: actor.id);
          if (onPressed != null) onPressed!();
        },
        color: AppColors.colorSplash,
        borderRadius: AppDimensions.radius5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImageWidget(
              height: 170,
              imageUrl: ImageDownloader.imageUrl(actor.profilePath ?? ''),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.radius5),
                ),
              ),
            ),
            const SizedBox(height: 2),
            Center(
              child: Text(
                actor.name!,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.subheader,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
