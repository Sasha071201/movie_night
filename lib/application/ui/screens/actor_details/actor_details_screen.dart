import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:movie_night/application/constants/app_dimensions.dart';
import 'package:movie_night/application/resources/resources.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/back_button_widget.dart';
import 'package:movie_night/application/ui/widgets/movies_with_header_widget.dart';

import '../../widgets/text_more_widget.dart';

class ActorDetailsScreen extends StatelessWidget {
  const ActorDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: const [
            _BackButtonWidget(),
            _ActorImageWidget(),
            SizedBox(height: 16),
            _RowActorInfoWidget(),
            SizedBox(height: 16),
            _PersonalInformationWidget(),
            SizedBox(height: 16),
            _BiographyWidget(),
            SizedBox(height: 16),
            MoviesWithHeaderWidget(header: 'Fame For'),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _BiographyWidget extends StatelessWidget {
  const _BiographyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Biography',
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
      ),
    );
  }
}

class _PersonalInformationWidget extends StatelessWidget {
  const _PersonalInformationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal information',
            style: AppTextStyle.header3,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _PersonalInformationItemWidget(
                  title: 'Fame For: ',
                  value: 'Acting art',
                ),
                _PersonalInformationItemWidget(
                  title: 'Gender: ',
                  value: 'Female',
                ),
                _PersonalInformationItemWidget(
                  title: 'Date of birth: ',
                  value: '30.04.1988 (aged 33)',
                ),
                _PersonalInformationItemWidget(
                  title: 'Place of Birth: ',
                  value: 'Santa Cruz del Norte, Cuba',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonalInformationItemWidget extends StatelessWidget {
  final String title;
  final String value;
  const _PersonalInformationItemWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: AppTextStyle.medium.copyWith(
              color: AppColors.colorMainText,
            ),
          ),
          TextSpan(
              text: value,
              style: AppTextStyle.medium.copyWith(
                color: AppColors.colorSecondaryText,
              )),
        ],
      ),
    );
  }
}

class _RowActorInfoWidget extends StatelessWidget {
  const _RowActorInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 24,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Daniel Stisen',
              style: AppTextStyle.header2.copyWith(
                color: AppColors.colorSecondary,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const SizedBox(width: 16),
          SvgPicture.asset(AppIcons.instagram),
          const SizedBox(width: 16),
          const Icon(
            Icons.favorite,
            color: AppColors.colorMainText,
          ),
        ],
      ),
    );
  }
}

class _ActorImageWidget extends StatelessWidget {
  const _ActorImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          AppDimensions.radius5,
        ),
        child: Image.asset(
          AppImages.personExample,
          width: 156,
          height: 156,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _BackButtonWidget extends StatelessWidget {
  const _BackButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: BackButtonWidget(),
      ),
    );
  }
}
