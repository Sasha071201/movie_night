import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/widgets/action_chip_widget.dart';
import 'package:movie_night/application/ui/widgets/dropdown/dropdown_text_button_widget.dart';
import 'package:movie_night/application/ui/widgets/text_button_widget.dart';

import '../../themes/app_text_style.dart';
import '../../widgets/back_button_widget.dart';
import 'filter_movies_view_model.dart';

class FilterMoviesScreen extends StatelessWidget {
  const FilterMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: const [
            Align(
              alignment: Alignment.centerLeft,
              child: BackButtonWidget(),
            ),
            _HeaderWidget(),
            _ResetButtonWidget(),
            _ShowMeWidget(),
            SizedBox(height: 16),
            _ReleaseDateWidget(),
            _CountryWidget(),
            _GenresWidget(),
            SizedBox(height: 16),
            _CertificationWidget(),
            SizedBox(height: 16),
            _LanguageWidget(),
            _RatingWidget(),
          ],
        ),
      ),
    );
  }
}

class _RatingWidget extends StatelessWidget {
  const _RatingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rating',
          style: AppTextStyle.header3,
        ),
        const SizedBox(height: 8),
         Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text('Cooming..', style: AppTextStyle.medium,),
        ),
      ],
    );
  }
}

class _LanguageWidget extends StatelessWidget {
  const _LanguageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Language',
          style: AppTextStyle.header3,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: _DropdownLanguageWidget(),
        ),
      ],
    );
  }
}

class _CertificationWidget extends StatelessWidget {
  const _CertificationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Certification',
          style: AppTextStyle.header3,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Consumer<FilterMoviesViewModel>(
            builder: (context, vm, _) {
              return _SelectedWrapWidget(
                currentIndex: vm.currentIndexCertification,
                onSelected: vm.selectCertificationItem,
                items: vm.listCertification,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _GenresWidget extends StatelessWidget {
  const _GenresWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Genres',
          style: AppTextStyle.header3,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Consumer<FilterMoviesViewModel>(
            builder: (context, vm, _) {
              return _SelectedWrapWidget(
                currentIndices: vm.currentIndicesGenre,
                onSelected: vm.selectGenre,
                items: vm.listGenres,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CountryWidget extends StatelessWidget {
  const _CountryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Country',
          style: AppTextStyle.header3,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: const [
              _ChipAllCountryWidget(),
              SizedBox(width: 21),
              _DropdownCountryWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class _DropdownCountryWidget extends StatelessWidget {
  const _DropdownCountryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FilterMoviesViewModel>();
    return DropdownTextButtonWidget(
      hint: 'No selected',
      items: vm.listCountries,
      onChanged: vm.selectCountry,
      index: vm.currentIndexCountry,
      manageCurrentIndex: true,
    );
  }
}

class _DropdownLanguageWidget extends StatelessWidget {
  const _DropdownLanguageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FilterMoviesViewModel>();
    return DropdownTextButtonWidget(
      hint: 'No selected',
      items: vm.listLanguage,
      onChanged: vm.selectLanguageItem,
      index: vm.currentIndexLanguage,
    );
  }
}

class _ChipAllCountryWidget extends StatelessWidget {
  const _ChipAllCountryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FilterMoviesViewModel>();
    return ActionChipWidget(
      child: Text(
        'All countries',
        style: AppTextStyle.small.copyWith(
          color: vm.isAllCountriesSelected
              ? AppColors.colorPrimary
              : AppColors.colorSecondaryText,
        ),
      ),
      backgroundColor: vm.isAllCountriesSelected
          ? AppColors.colorSecondary
          : AppColors.colorPrimary,
      onPressed: vm.selectAllCountries,
    );
  }
}

class _ReleaseDateWidget extends StatelessWidget {
  const _ReleaseDateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Release Date',
          style: AppTextStyle.header3,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Consumer<FilterMoviesViewModel>(
            builder: (context, vm, _) {
              return _SelectedWrapWidget(
                currentIndex: vm.currentIndexReleaseDate,
                onSelected: vm.selectReleaseDateItem,
                items: vm.listReleaseDate,
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: _RowSelectDateWidget(),
        ),
      ],
    );
  }
}

class _RowSelectDateWidget extends StatefulWidget {
  const _RowSelectDateWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_RowSelectDateWidget> createState() => _RowSelectDateWidgetState();
}

class _RowSelectDateWidgetState extends State<_RowSelectDateWidget> {
  @override
  void didChangeDependencies() {
    context.read<FilterMoviesViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FilterMoviesViewModel>();
    return Row(
      children: [
        _SelectedDateWidget(
          title: 'From:',
          value: vm.fromReleaseDate,
          onPressed: () => vm.pickDate(context, DateTimeType.from),
        ),
        _SelectedDateWidget(
          title: 'Before:',
          value: vm.beforeReleaseDate,
          onPressed: () => vm.pickDate(context, DateTimeType.before),
        ),
      ],
    );
  }
}

class _SelectedDateWidget extends StatelessWidget {
  final String title;
  final String value;
  final void Function() onPressed;
  const _SelectedDateWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle.small.copyWith(
            color: AppColors.colorMainText,
          ),
        ),
        TextButtonWidget(
          child: Column(
            children: [
              Text(
                value,
                style: AppTextStyle.subheader.copyWith(
                  color: AppColors.colorSecondary,
                ),
              ),
              Container(
                height: 1,
                width: 70,
                color: AppColors.colorSecondary,
              ),
            ],
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}

class _ShowMeWidget extends StatelessWidget {
  const _ShowMeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Show me',
          style: AppTextStyle.header3,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Consumer<FilterMoviesViewModel>(
            builder: (context, vm, _) {
              return _SelectedWrapWidget(
                currentIndex: vm.currentIndexShowMe,
                onSelected: vm.selectShowMeItem,
                items: vm.listShowMe,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SelectedWrapWidget extends StatelessWidget {
  final List<String> items;
  final int currentIndex;
  final List<int>? currentIndices;
  final void Function(int) onSelected;

  const _SelectedWrapWidget({
    Key? key,
    required this.items,
    this.currentIndex = -1,
    this.currentIndices,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items
          .asMap()
          .map((index, value) => MapEntry(
              index,
              ActionChipWidget(
                child: Text(
                  value,
                  style: AppTextStyle.small.copyWith(
                    color: currentIndices != null &&
                                currentIndices!.contains(index) ||
                            currentIndex == index
                        ? AppColors.colorPrimary
                        : AppColors.colorSecondaryText,
                  ),
                ),
                backgroundColor:
                    currentIndices != null && currentIndices!.contains(index) ||
                            currentIndex == index
                        ? AppColors.colorSecondary
                        : AppColors.colorPrimary,
                onPressed: () => onSelected(index),
              )))
          .values
          .toList(),
    );
  }
}

class _ResetButtonWidget extends StatelessWidget {
  const _ResetButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButtonWidget(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Reset filters',
              style: AppTextStyle.button.copyWith(
                color: AppColors.colorSecondary,
              ),
            ),
            const SizedBox(width: 2),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: AppColors.colorPrimary,
              ),
              child: Center(
                child: Text(
                  '9',
                  style: AppTextStyle.small.copyWith(
                    color: AppColors.colorSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
        onPressed: () {},
      ),
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
      'Filter',
      style: AppTextStyle.header2,
    );
  }
}
