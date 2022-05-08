import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/widgets/inkwell_material_widget.dart';

import '../../../../generated/l10n.dart';
import '../../../constants/app_dimensions.dart';
import '../../../domain/api_client/image_downloader.dart';
import '../../themes/app_text_style.dart';
import '../cached_network_image_widget.dart';

class MediaWidget extends StatelessWidget {
  final List<String>? backdrops;
  final List<double>? aspectRatios;
  final double width;
  const MediaWidget({
    Key? key,
    required this.backdrops,
    this.aspectRatios,
    this.width = 350,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return backdrops != null && backdrops?.isNotEmpty == true
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: AppDimensions.mediumPadding),
                child: Text(
                  S.of(context).media,
                  style: AppTextStyle.header3,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 180,
                child: _ListImagesWidget(
                  backdrops: backdrops,
                  aspectRatios: aspectRatios,
                  width: width,
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

class _ListImagesWidget extends StatefulWidget {
  final List<String>? backdrops;
  final List<double>? aspectRatios;
  final double width;

  const _ListImagesWidget({
    Key? key,
    required this.backdrops,
    required this.aspectRatios,
    required this.width,
  }) : super(key: key);

  @override
  State<_ListImagesWidget> createState() => _ListImagesWidgetState();
}

class _ListImagesWidgetState extends State<_ListImagesWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.largePadding,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: widget.backdrops!.length,
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      itemBuilder: (context, index) {
        return Center(
          child: InkWellMaterialWidget(
            color: AppColors.colorSplash,
            borderRadius: AppDimensions.radius5,
            onTap: () {
              final multiImageProvider = MultiImageProvider(
                widget.backdrops!
                    .map(
                      (e) => Image.network(
                        ImageDownloader.imageHighQualityUrl(e),
                      ).image,
                    )
                    .toList(),
                initialIndex: index,
              );
              showImageViewerPager(
                context,
                multiImageProvider,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radius5),
              child: AspectRatio(
                aspectRatio: widget.aspectRatios?[index] ?? 180 / widget.width,
                child: CachedNetworkImageWidget(
                  imageUrl: ImageDownloader.imageUrl(
                    widget.backdrops![index],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
