import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/domain/api_client/sort_by_type.dart';
import 'package:movie_night/application/ui/screens/view_all_movies/view_all_movies_view_model.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/dropdown/dropdown_text_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:movie_night/application/domain/api_client/release_type.dart';

import '../../../../generated/l10n.dart';
import '../../widgets/app_grid_view.dart';
import '../../widgets/filter_button_widget.dart';
import '../../widgets/vertical_widgets_with_header/vertical_movie_widget.dart';
import '../../widgets/vertical_widgets_with_header/vertical_tv_show_widget.dart';

class ViewAllMoviesScreen extends StatefulWidget {
  const ViewAllMoviesScreen({Key? key}) : super(key: key);

  @override
  State<ViewAllMoviesScreen> createState() => _ViewAllMoviesScreenState();
}

class _ViewAllMoviesScreenState extends State<ViewAllMoviesScreen> {
  @override
  void didChangeDependencies() {
    context.read<ViewAllMoviesViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: AppColors.colorSecondary),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _HeaderWidget(),
              _RowFilterWidget(),
              SizedBox(height: 8.0),
              _ResultTitleFilterWidget(),
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
    final vm = context.read<ViewAllMoviesViewModel>();
    final mediaType =
        context.select((ViewAllMoviesViewModel vm) => vm.state.media.mediaType);
    final isLoadingProgress = context
        .select((ViewAllMoviesViewModel vm) => vm.state.isLoadingProgress);
    final media =
        context.select((ViewAllMoviesViewModel vm) => vm.state.media.media);
    return media.isNotEmpty
        ? Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AppGridView(
                itemBuilder: (context, index) {
                  Widget child = const SizedBox.shrink();
                  if (mediaType == MediaType.movie) {
                    child = VerticalMovieWidget(
                      movie: media[index],
                    );
                  } else if (mediaType == MediaType.tv) {
                    child = VerticalTvShowWidget(
                      tvShow: media[index],
                    );
                  }
                  vm.showedCategoryAtIndex(index);
                  return child;
                },
                itemCount: media.length,
              ),
              if (isLoadingProgress)
                const Positioned(
                  bottom: 16,
                  child: Center(
                    child: RepaintBoundary(
                      child: CircularProgressIndicator(
                        color: AppColors.colorMainText,
                      ),
                    ),
                  ),
                ),
            ],
          )
        : const Center(
            child: RepaintBoundary(
              child: CircularProgressIndicator(
                color: AppColors.colorMainText,
              ),
            ),
          );
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
        Flexible(
          fit: FlexFit.loose,
          child: _SortButtonWidget(),
        ),
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
    final vm = context.read<ViewAllMoviesViewModel>();
    final indexSortBy =
        context.select((ViewAllMoviesViewModel vm) => vm.state.indexSortBy);
    return DropdownTextButtonWidget(
      hint: 'No Selected',
      index: indexSortBy,
      items: SortBy.values.map((sortBy) => sortBy.asString(context)).toList(),
      onChanged: (index) => vm.selectIndexSortBy(index, context),
    );
  }
}

class _FilterColumnWidget extends StatelessWidget {
  const _FilterColumnWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ViewAllMoviesViewModel>();
    return FilterButtonWidget(
      data: vm.getFilterData(),
      mediaType: vm.state.media.mediaType,
      openFromMain: false,
      pushNamed: (pushNamed) => vm.openFilter(pushNamed, context),
    );
  }
}

class _ResultTitleFilterWidget extends StatelessWidget {
  const _ResultTitleFilterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ViewAllMoviesViewModel>();
    final withGenres = vm.state.data.withGenres;
    final withoutGenres = vm.state.data.withoutGenres;
    String withGenresString =
        withGenres.map((e) => e.asString(context)).join(',');
    String withoutGenresString =
        withoutGenres.map((e) => e.asString(context).toLowerCase()).join(',');
    final sortBy = SortBy.values[vm.state.indexSortBy].asString(context);
    var date = '';
    var voteAverage = '';
    final titleReleaseDate =
        vm.state.data.titleReleaseDate?.asString(context) ?? '';
    if (titleReleaseDate.isNotEmpty) {
      date = titleReleaseDate;
    } else {
      final fromDate = vm.state.data.fromReleaseDate;
      final beforeDate = vm.state.data.beforeReleaseDate;

      date =
          '${fromDate != null ? '${S.of(context).from.toLowerCase()} ${vm.stringFromDate(fromDate)} ' : ''}${beforeDate != null ? '${S.of(context).before.toLowerCase()} ${vm.stringFromDate(beforeDate)}' : ''}';
    }
    final voteAverageFrom = vm.state.data.voteAverageFrom;
    final voteAverageBefore = vm.state.data.voteAverageBefore;
    voteAverage =
        '${voteAverageFrom != null ? '${S.of(context).from.toLowerCase()} ${(voteAverageFrom).toInt()} ' : ''}${voteAverageBefore != null ? '${S.of(context).before.toLowerCase()} ${(voteAverageBefore).toInt()}' : ''}';

    return Text(
      '${withGenresString.isNotEmpty ? '${S.of(context).with_genres} $withGenresString. ' : ''}${withoutGenresString.isNotEmpty ? '${S.of(context).without_genres} $withoutGenresString. ' : ''}${S.of(context).sort_by} $sortBy. ${date.isNotEmpty ? '${S.of(context).date} $date. ' : ''} ${voteAverage.isNotEmpty ? '${S.of(context).vote_average} $voteAverage. ' : ''}', //Include Adult: $includeAdult. ${date.isNotEmpty ? 'Date $date' : ''}',
      style: AppTextStyle.subheader.copyWith(
        color: AppColors.colorSecondaryText,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaType =
        context.select((ViewAllMoviesViewModel vm) => vm.state.media.mediaType);
    final text = mediaType == MediaType.movie
        ? S.of(context).movies
        : S.of(context).tv_shows;
    return Text(
      text,
      style: AppTextStyle.header2,
    );
  }
}
