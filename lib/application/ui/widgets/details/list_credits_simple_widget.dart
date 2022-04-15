import 'package:flutter/material.dart';

import '../../../constants/app_dimensions.dart';
import '../../../domain/api_client/image_downloader.dart';
import '../../navigation/app_navigation.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';
import '../cached_network_image_widget.dart';
import '../inkwell_material_widget.dart';

class CreditsItemSimpleData {
  final int id;
  final String name;
  final String? value;
  final String posterPath;
  CreditsItemSimpleData({
    required this.id,
    required this.name,
    this.value,
    required this.posterPath,
  });
}

class CreditsItemSimpleWidget extends StatelessWidget {
  final CreditsItemSimpleData data;
  const CreditsItemSimpleWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWellMaterialWidget(
      onTap: () {
        Navigator.of(context).pushNamed(Screens.actorDetails, arguments: data.id);
      },
      borderRadius: AppDimensions.radius5,
      color: AppColors.colorSplash,
      child: SizedBox(
        width: 93,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radius5),
              child: CachedNetworkImageWidget(
                height: 140,
                imageUrl: ImageDownloader.imageUrl(data.posterPath),
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              data.name,
              style: AppTextStyle.subheader,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            if (data.value != null)
              Text(
                data.value!,
                style: AppTextStyle.subheader2.copyWith(
                  color: AppColors.colorSecondaryText,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}

class ListCreditsSimpleData {
  final String title;
  final List<CreditsItemSimpleData> list;
  ListCreditsSimpleData({
    required this.title,
    required this.list,
  });
}

class ListCreditsSimpleWidget extends StatelessWidget {
  final ListCreditsSimpleData data;
  const ListCreditsSimpleWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data.list.isNotEmpty ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppDimensions.mediumPadding),
          child: Text(
            data.title,
            style: AppTextStyle.header3,
          ),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 174,
            maxHeight: 224,
          ),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.largePadding,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: data.list.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final item = data.list[index];
              return Align(
                alignment: Alignment.topCenter,
                child: CreditsItemSimpleWidget(
                  data: CreditsItemSimpleData(
                    id: item.id,
                    name: item.name,
                    value: item.value,
                    posterPath: item.posterPath,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ) : const SizedBox.shrink();
  }
}
