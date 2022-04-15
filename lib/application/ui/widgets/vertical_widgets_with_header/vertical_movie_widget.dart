import 'package:flutter/material.dart';

import 'package:movie_night/application/ui/navigation/app_navigation.dart';
import 'package:movie_night/application/ui/screens/main/main_view_model.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/cached_network_image_widget.dart';
import 'package:movie_night/application/ui/widgets/inkwell_material_widget.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_dimensions.dart';
import '../../../domain/api_client/image_downloader.dart';
import '../../../domain/entities/movie/movie.dart';
import '../circular_progress_indicator_widget.dart';

class VerticalMovieWidget extends StatelessWidget {
  final Movie movie;
  final void Function()? onPressed;

  const VerticalMovieWidget({
    Key? key,
    required this.movie,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rating = (movie.voteAverage! * 10).toInt();
    final text = rating == 0 ? 'NR' : '$rating';
    return SizedBox(
      width: 130,
      child: InkWellMaterialWidget(
        onTap: () async {
          try {
            context.read<MainViewModel>().showAdIfAvailable();
          } catch (e) {}
          await Navigator.of(context)
              .pushNamed(Screens.movieDetails, arguments: movie.id);
          if (onPressed != null) onPressed!();
        },
        color: AppColors.colorSplash,
        borderRadius: AppDimensions.radius5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                CachedNetworkImageWidget(
                  height: 170,
                  imageUrl: ImageDownloader.imageUrl(movie.posterPath ?? ''),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radius5),
                    ),
                  ),
                ),
                if (movie.releaseDate?.year != null)
                  Positioned(
                    right: 4,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.colorPrimary,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radius5,
                        ),
                      ),
                      child: Text(
                        '${movie.releaseDate?.year}',
                        style: AppTextStyle.subheader2,
                      ),
                    ),
                  ),
                Positioned(
                  right: 3,
                  top: 3,
                  child: CircularProgressIndicatorWidget(
                    height: 30,
                    width: 30,
                    percent: movie.voteAverage! / 10,
                    child: Text(
                      text,
                      style: AppTextStyle.subheader2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Center(
              child: Text(
                movie.title!,
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
