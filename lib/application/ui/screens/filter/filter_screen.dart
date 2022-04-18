import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/domain/api_client/release_type.dart';
import 'package:movie_night/application/ui/widgets/elevated_button_widget.dart';
import 'package:provider/provider.dart';

import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/widgets/action_chip_widget.dart';
import 'package:movie_night/application/ui/widgets/text_button_widget.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../generated/l10n.dart';
import '../../themes/app_text_style.dart';
import 'filter_view_model.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void didChangeDependencies() {
    context.read<FilterViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final mediaType = context.select((FilterViewModel vm) => vm.mediaType);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: false,
            floating: false,
            leading: BackButton(color: AppColors.colorSecondary),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _HeaderWidget(),
                      const _ResetButtonWidget(),
                      if (mediaType == MediaType.movie) ...[
                        const SizedBox(height: 16),
                        
                      ],
                      const _ReleaseDateWidget(),
                      const _WithGenresWidget(),
                      const SizedBox(height: 16),
                      const _WithoutGenresWidget(),
                      const SizedBox(height: 16),
                      const _RatingWidget(),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButtonWidget(
        child: Text(
          S.of(context).apply,
          style: AppTextStyle.button.copyWith(
            color: AppColors.colorPrimary,
          ),
        ),
        width: 120,
        backgroundColor: AppColors.colorSecondary,
        overlayColor: AppColors.colorSplash,
        onPressed: () => context.read<FilterViewModel>().apply(context),
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
    final vm = context.read<FilterViewModel>();
    final voteAverageBefore =
        context.select((FilterViewModel vm) => vm.state.data.voteAverageBefore);
    final voteAverageFrom =
        context.select((FilterViewModel vm) => vm.state.data.voteAverageFrom);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).vote_average,
          style: AppTextStyle.header3,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: SfRangeSlider(
            min: 0.0,
            max: 100.0,
            showTicks: true,
            showLabels: true,
            enableTooltip: true,
            minorTicksPerInterval: 1,
            activeColor: AppColors.colorSecondary,
            inactiveColor: AppColors.colorPrimary,
            interval: 20,
            stepSize: 5,
            values: SfRangeValues(voteAverageFrom, voteAverageBefore),
            onChanged: vm.onChangedVoteAverage,
          ),
        ),
      ],
    );
  }
}

class _WithGenresWidget extends StatelessWidget {
  const _WithGenresWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectGenre = context.read<FilterViewModel>().selectWithGenre;
    final currentIndicesGenre = context
        .select((FilterViewModel vm) => vm.state.data.currentIndicesWithGenre);
    final listGenres =
        context.select((FilterViewModel vm) => vm.state.data.withGenres);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).with_genres,
          style: AppTextStyle.header3,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Consumer<FilterViewModel>(
            builder: (context, vm, _) {
              return _SelectedWrapWidget(
                currentIndices: currentIndicesGenre,
                onSelected: selectGenre,
                items: listGenres.map((e) => e.asString(context)).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _WithoutGenresWidget extends StatelessWidget {
  const _WithoutGenresWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectGenre = context.read<FilterViewModel>().selectWithoutGenre;
    final currentIndicesGenre = context.select(
        (FilterViewModel vm) => vm.state.data.currentIndicesWithoutGenre);
    final listGenres =
        context.select((FilterViewModel vm) => vm.state.data.withoutGenres);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).without_genres,
          style: AppTextStyle.header3,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Consumer<FilterViewModel>(
            builder: (context, vm, _) {
              return _SelectedWrapWidget(
                currentIndices: currentIndicesGenre,
                onSelected: selectGenre,
                items: listGenres.map((e) => e.asString(context)).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ReleaseDateWidget extends StatelessWidget {
  const _ReleaseDateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaType = context.select((FilterViewModel vm) => vm.mediaType);
    final selectReleaseDateItem =
        context.read<FilterViewModel>().selectReleaseDateItem;
    final currentIndexReleaseDate = context
        .select((FilterViewModel vm) => vm.state.data.currentIndexReleaseDate);
    final rawListReleaseDate =
        context.select((FilterViewModel vm) => vm.state.data.releaseDates);
    final listReleaseDate = rawListReleaseDate.map((date) => date.asString(context)).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).release_date,
          style: AppTextStyle.header3,
        ),
        if (mediaType == MediaType.movie) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _SelectedWrapWidget(
              currentIndex: currentIndexReleaseDate,
              onSelected: selectReleaseDateItem,
              items: listReleaseDate,
            ),
          ),
        ],
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: _RowSelectDateWidget(),
        ),
      ],
    );
  }
}

class _RowSelectDateWidget extends StatelessWidget {
  const _RowSelectDateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<FilterViewModel>();
    final fromReleaseDate =
        context.select((FilterViewModel vm) => vm.state.data.fromReleaseDate);
    final beforeReleaseDate =
        context.select((FilterViewModel vm) => vm.state.data.beforeReleaseDate);
    return Row(
      children: [
        _SelectedDateWidget(
          title: '${S.of(context).from}:',
          value: vm.stringFromDate(fromReleaseDate),
          onPressed: () => vm.pickDate(context, DateTimeType.from),
        ),
        _SelectedDateWidget(
          title: '${S.of(context).before}:',
          value: vm.stringFromDate(beforeReleaseDate),
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
    final vm = context.read<FilterViewModel>();
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButtonWidget(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).reset_filters,
              style: AppTextStyle.button.copyWith(
                color: AppColors.colorSecondary,
              ),
            ),
          ],
        ),
        onPressed: vm.resetFilters,
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
      S.of(context).filter,
      style: AppTextStyle.header2,
    );
  }
}
