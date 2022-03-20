import 'package:flutter/material.dart';

import 'package:movie_night/application/ui/navigation/app_navigation.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/inkwell_material_widget.dart';

import '../../constants/app_dimensions.dart';
import '../../resources/resources.dart';
import 'circular_progress_indicator_widget.dart';

class VerticalMovieWidget extends StatelessWidget {
  final void Function()? onPressed;

  const VerticalMovieWidget({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: InkWellMaterialWidget(
        onTap: () {
          if (onPressed != null) onPressed!();
          Navigator.of(context).pushNamed(Screens.movieDetails);
        },
        color: AppColors.colorSplash,
        borderRadius: AppDimensions.radius5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(AppImages.movieExample),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radius5),
                  ),
                ),
                Positioned(
                  right: 4,
                  bottom: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      color: AppColors.colorPrimary,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radius5,
                      ),
                    ),
                    child: Text(
                      '2021',
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
                    percent: 0.6,
                    child: Text(
                      '9.5',
                      style: AppTextStyle.subheader2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              'Jumanji',
              style: AppTextStyle.subheader,
            ),
          ],
        ),
      ),
    );
  }
}
