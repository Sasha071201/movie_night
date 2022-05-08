import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../resources/resources.dart';
import '../themes/app_colors.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String? imageUrl;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const CachedNetworkImageWidget({
    Key? key,
    required this.imageUrl,
    this.imageBuilder,
    this.fit,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => Image.asset(
        AppImages.placeholder,
        color: AppColors.colorMainText,
      ),
      errorWidget: (context, url, error) => Image.asset(
        AppImages.placeholder,
        color: AppColors.colorMainText,
      ),
      imageUrl: imageUrl ?? '',
      imageBuilder: imageBuilder,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      cacheManager: CacheManager(
        Config(
          'CachedNetworkImageKey',
          stalePeriod: const Duration(hours: 3),
        ),
      ),
    );
  }
}
