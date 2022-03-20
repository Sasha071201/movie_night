import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';

import 'package:movie_night/application/ui/widgets/text_button_widget.dart';
import 'package:movie_night/application/ui/widgets/vertical_movie_widget.dart';
import 'package:movie_night/application/ui/widgets/vertical_view_all_widget.dart';

import '../../constants/app_dimensions.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_style.dart';

class MoviesWithHeaderWidget extends StatelessWidget {
  final String header;
  final void Function()? onPressed;

  const MoviesWithHeaderWidget({
    Key? key,
    required this.header,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.mediumPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                header,
                style: AppTextStyle.header3,
              ),
              TextButtonWidget(
                child: Text(
                  'View All',
                  style: AppTextStyle.button.copyWith(
                    color: AppColors.colorSecondary,
                  ),
                ),
                onPressed: () => Navigator.of(context).pushNamed(
                  Screens.viewAllMovies,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 188,
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.largePadding,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final child = index != 9
                    ? VerticalMovieWidget(
                        onPressed: onPressed,
                      )
                    : VerticalViewAllWidget(
                        width: 130,
                        height: 170,
                        onPressed: () => Navigator.of(context).pushNamed(
                          Screens.viewAllMovies,
                        ),
                      );
                return Align(
                  alignment: Alignment.topCenter,
                  child: child,
                );
              }),
        ),
      ],
    );
  }
}
