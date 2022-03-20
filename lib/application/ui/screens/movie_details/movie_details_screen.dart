import 'package:flutter/material.dart';

import 'package:movie_night/application/constants/app_dimensions.dart';
import 'package:movie_night/application/resources/resources.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/back_button_widget.dart';
import 'package:movie_night/application/ui/widgets/circular_progress_indicator_widget.dart';
import 'package:movie_night/application/ui/widgets/dialog_widget.dart';
import 'package:movie_night/application/ui/widgets/icon_button_widget.dart';
import 'package:movie_night/application/ui/widgets/inkwell_material_widget.dart';
import 'package:movie_night/application/ui/widgets/movies_with_header_widget.dart';
import 'package:movie_night/application/ui/widgets/text_button_widget.dart';
import 'package:movie_night/application/ui/widgets/text_more_widget.dart';

import '../../navigation/app_navigation.dart';
import '../../widgets/action_chip_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: const [
            _PosterWidget(),
            _MovieDetailsWidget(),
            SizedBox(height: 8),
            _MediaWidget(),
            SizedBox(height: 8),
            _MainRolesWidget(),
            SizedBox(height: AppDimensions.mediumPadding),
            Divider(
              height: 1,
              color: AppColors.colorSecondaryText,
            ),
            _SeeAlsoWidget(),
          ],
        ),
      ),
    );
  }
}

class _SeeAlsoWidget extends StatelessWidget {
  const _SeeAlsoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        MoviesWithHeaderWidget(header: 'See Also'),
        SizedBox(height: AppDimensions.mediumPadding),
      ],
    );
  }
}

class _MovieDetailsWidget extends StatelessWidget {
  const _MovieDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _TitleWidget(),
          SizedBox(height: 8),
          _ButtonsWidget(),
          SizedBox(height: 8),
          _RowMainInfoWidget(),
          SizedBox(height: 8),
          _ListChipsWidget(),
          SizedBox(height: 8),
          _TaglineWidget(),
          SizedBox(height: 8),
          _DescriptionWidget(),
        ],
      ),
    );
  }
}

class _TaglineWidget extends StatelessWidget {
  const _TaglineWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tagline',
          style: AppTextStyle.header3,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Мультивселенная на свободе',
            style: AppTextStyle.small
                .copyWith(color: AppColors.colorSecondaryText),
          ),
        ),
      ],
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppTextStyle.header3,
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: TextMoreWidget(
            'Мистерио удаётся выяснить истинную личность Человека-паука. С этого момента жизнь Питера Паркера становится невыносимой. Если ранее он мог успешно переключаться между своими амплуа, то сейчас это сделать невозможно. Переворачивается с ног на голову не только жизнь Человека-пауку, но и репутация. Понимая, что так жить невозможно, главный герой фильма «Человек-паук: Нет пути домой» принимает решение обратиться за помощью к своему давнему знакомому Стивену Стрэнджу. Питер Паркер надеется, что с помощью магии он сможет восстановить его анонимность. Стрэндж соглашается помочь.',
          ),
        ),
      ],
    );
  }
}

class _MediaWidget extends StatelessWidget {
  const _MediaWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppDimensions.mediumPadding),
          child: Text(
            'Media',
            style: AppTextStyle.header3,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 110,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.largePadding,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              return Container(
                height: 110,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radius5,
                  ),
                ),
                child: Image.asset(
                  AppImages.movieExample,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MainRolesWidget extends StatelessWidget {
  const _MainRolesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppDimensions.mediumPadding),
          child: Text(
            'Starring',
            style: AppTextStyle.header3,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 174,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.largePadding,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              return _MainRoleWidget(index: index);
            },
          ),
        ),
      ],
    );
  }
}

class _MainRoleWidget extends StatelessWidget {
  final int index;
  const _MainRoleWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWellMaterialWidget(
      onTap: () {
        Navigator.of(context).pushNamed(Screens.actorDetails);
      },
      borderRadius: AppDimensions.radius5,
      color: AppColors.colorSplash,
      child: Column(
        children: [
          Container(
            height: 140,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppDimensions.radius5,
              ),
            ),
            child: Image.asset(
              AppImages.personExample,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Daniel Stisen',
            style: AppTextStyle.subheader,
          ),
          const SizedBox(height: 2),
          Text(
            'John Wood',
            style: AppTextStyle.subheader2.copyWith(
              color: AppColors.colorSecondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

class _ListChipsWidget extends StatelessWidget {
  const _ListChipsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ActionChipWidget(
          onPressed: () {},
          child: Text(
            'Action',
            style: AppTextStyle.small
                .copyWith(color: AppColors.colorSecondaryText),
          ),
        ),
        ActionChipWidget(
          onPressed: () {},
          child: Text(
            'Action',
            style: AppTextStyle.small
                .copyWith(color: AppColors.colorSecondaryText),
          ),
        ),
        ActionChipWidget(
          onPressed: () {},
          child: Text(
            'Action',
            style: AppTextStyle.small
                .copyWith(color: AppColors.colorSecondaryText),
          ),
        ),
        ActionChipWidget(
          onPressed: () {},
          child: Text(
            'Action',
            style: AppTextStyle.small
                .copyWith(color: AppColors.colorSecondaryText),
          ),
        ),
        ActionChipWidget(
          onPressed: () {},
          child: Text(
            'Action',
            style: AppTextStyle.small
                .copyWith(color: AppColors.colorSecondaryText),
          ),
        ),
        ActionChipWidget(
          onPressed: () {},
          child: Text(
            'Action',
            style: AppTextStyle.small
                .copyWith(color: AppColors.colorSecondaryText),
          ),
        ),
      ],
    );
  }
}

class _RowMainInfoWidget extends StatelessWidget {
  const _RowMainInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.calendar_month,
              color: AppColors.colorSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              '17.12.2021',
              style: AppTextStyle.small,
            ),
          ],
        ),
        const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.timer,
              color: AppColors.colorSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              '160 mins',
              style: AppTextStyle.small,
            ),
          ],
        ),
      ],
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Jumanji',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyle.header2.copyWith(
        color: AppColors.colorSecondary,
      ),
    );
  }
}

class _ButtonsWidget extends StatelessWidget {
  const _ButtonsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButtonWidget(
          onPressed: () {},
          backgroundColor: AppColors.colorPrimary,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.play_arrow,
                color: AppColors.colorSecondary,
              ),
              Text(
                'Play',
                style: AppTextStyle.small,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        TextButtonWidget(
          onPressed: () {},
          backgroundColor: AppColors.colorPrimary,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.remove_red_eye,
                color: AppColors.colorSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                'Watched',
                style: AppTextStyle.small,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PosterWidget extends StatelessWidget {
  const _PosterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: Image.asset(
              AppImages.movieExample,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 16,
          bottom: 8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radius5),
            child: Image.asset(
              AppImages.movieExample,
              width: 100,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BackButtonWidget(),
              IconButtonWidget(
                icon: const Icon(
                  Icons.favorite,
                  color: AppColors.colorSecondaryText,
                  size: 32,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 16,
          child: InkWellMaterialWidget(
            onTap: () => DialogWidget.showDialogRateMovie(context),
            borderRadius: 90,
            color: AppColors.colorSplash,
            child: CircularProgressIndicatorWidget(
              child: Text(
                '8.3',
                style: AppTextStyle.medium,
              ),
              width: 45,
              height: 45,
              percent: 0.83,
            ),
          ),
        ),
      ],
    );
  }
}
