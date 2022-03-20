import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/back_button_widget.dart';
import 'package:movie_night/application/ui/widgets/dropdown/custom_dropdown_widget.dart';
import 'package:movie_night/application/ui/widgets/dropdown/dropdown_text_button_widget.dart';
import 'package:movie_night/application/ui/widgets/text_button_widget.dart';
import 'package:movie_night/application/ui/widgets/vertical_movie_widget.dart';

import '../../widgets/filter_button_widget.dart';

class ViewAllMoviesScreen extends StatelessWidget {
  const ViewAllMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              BackButtonWidget(),
              _HeaderWidget(),
              _RowFilterWidget(),
              SizedBox(height: 8.0),
              Expanded(
                child: _ListMoviesWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListMoviesWidget extends StatelessWidget {
  const _ListMoviesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 130 / 215, //188 - height, 130 - width
        ),
        itemBuilder: (context, index) => const VerticalMovieWidget());
  }
}

class _RowFilterWidget extends StatelessWidget {
  const _RowFilterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _FilterColumnWidget(),
        _SortButtonWidget(),
      ],
    );
  }
}

class _SortButtonWidget extends StatelessWidget {
  const _SortButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  DropdownTextButtonWidget(
      hint: 'No Selected',
      index: 0,
      titleDropdpwn: 'Сортировать',
      items: const [
        'By popularity',
        'By rating',
        'By release date',
      ],
      onChanged: (index){},
    );
  }
}

class _FilterColumnWidget extends StatelessWidget {
  const _FilterColumnWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FilterButtonWidget(),
        Text(
          'Drama, United States, 2022',
          style: AppTextStyle.subheader.copyWith(
            color: AppColors.colorSecondaryText,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Drama movies',
      style: AppTextStyle.header2,
    );
  }
}
