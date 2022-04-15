import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/ui/widgets/inkwell_material_widget.dart';

import '../../constants/app_dimensions.dart';
import '../../domain/api_client/image_downloader.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_style.dart';
import 'back_button_widget.dart';
import 'cached_network_image_widget.dart';
import 'circular_progress_indicator_widget.dart';
import 'icon_button_widget.dart';

class HeaderPosterData {
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final void Function()? onFavoritePressed;
  final bool showVoteAverage;
  final bool showFavorite;
  final bool isFavorite;
  HeaderPosterData({
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    this.onFavoritePressed,
    this.showVoteAverage = true,
    this.showFavorite = true,
    this.isFavorite = false,
  });
}

class HeaderPosterWidget extends StatelessWidget {
  final HeaderPosterData data;
  const HeaderPosterWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rating = (data.voteAverage * 10).toInt();
    final text = rating == 0 ? 'NR' : '$rating';
  
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 389 / 218,
          child: DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.colorBackground,
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.1, 0.5],
              ),
            ),
            child: CachedNetworkImageWidget(
              imageUrl: ImageDownloader.imageUrl(data.backdropPath),
            ),
          ),
        ),
        Positioned(
          left: 16,
          bottom: 8,
          child: InkWellMaterialWidget(
            color: AppColors.colorSplash,
            borderRadius: AppDimensions.radius5,
            onTap: () =>
                showImageViewer(context, Image.network(ImageDownloader.imageHighQualityUrl(data.posterPath)).image),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radius5),
              child: CachedNetworkImageWidget(
                imageUrl: ImageDownloader.imageUrl(data.posterPath),
                width: 100,
                height: 140,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BackButtonWidget(),
              if (data.showFavorite)
                IconButtonWidget(
                  icon: Icon(
                    Icons.favorite,
                    color: data.isFavorite
                        ? AppColors.colorSecondary
                        : AppColors.colorSecondaryText,
                    size: 32,
                  ),
                  onPressed: data.onFavoritePressed!,
                ),
            ],
          ),
        ),
        if (data.showVoteAverage)
          Positioned(
            bottom: 0,
            right: 16,
            child: CircularProgressIndicatorWidget(
              child: Text(
                text,
                style: AppTextStyle.medium,
              ),
              width: 45,
              height: 45,
              percent: data.voteAverage / 10,
            ),
          ),
      ],
    );
  }
}
