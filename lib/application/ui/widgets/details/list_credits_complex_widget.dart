import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../constants/app_dimensions.dart';
import '../../../domain/api_client/image_downloader.dart';
import '../../navigation/app_navigation.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';
import '../cached_network_image_widget.dart';
import '../inkwell_material_widget.dart';

class CreditsItemComplexData {
  final int id;
  final String name;
  final List<MapEntry> list;
  final String posterPath;
  CreditsItemComplexData({
    required this.id,
    required this.name,
    required this.list,
    required this.posterPath,
  });
}

class CreditsItemComplexWidget extends StatelessWidget {
  final CreditsItemComplexData data;
  const CreditsItemComplexWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rolesWidget = data.list
        .map(
          (item) => RichText(
            maxLines: 3,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: item.key,
                  style: AppTextStyle.small.copyWith(
                    color: AppColors.colorMainText,
                  ),
                ),
                TextSpan(
                  text: ' ${item.value} ${S.of(context).episodes_v1}',
                  style: AppTextStyle.small.copyWith(
                    color: AppColors.colorSecondaryText,
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
    return InkWellMaterialWidget(
      onTap: () {
        Navigator.of(context).pushNamed(Screens.actorDetails, arguments: data.id);
      },
      borderRadius: AppDimensions.radius5,
      color: AppColors.colorSplash,
      child: Container(
        height: 200,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.radius5),
          color: AppColors.colorPrimary,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(AppDimensions.radius5),
              ),
              child: CachedNetworkImageWidget(
                width: 133,
                imageUrl: ImageDownloader.imageUrl(data.posterPath),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      data.name,
                      style: AppTextStyle.header2,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Expanded(
                    child: ListView.builder(
                      itemCount: rolesWidget.length,
                      itemBuilder: (context, index) => rolesWidget[index],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListCreditsComplexData {
  final String title;
  final List<CreditsItemComplexData> list;
  ListCreditsComplexData({
    required this.title,
    required this.list,
  });
}

class ListCreditsComplexWidget extends StatelessWidget {
  final ListCreditsComplexData data;
  const ListCreditsComplexWidget({
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
        SizedBox(
          height: 210,
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
                child: CreditsItemComplexWidget(
                  data: CreditsItemComplexData(
                    id: item.id,
                    name: item.name,
                    list: item.list,
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