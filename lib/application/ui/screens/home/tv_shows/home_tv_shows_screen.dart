import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_dimensions.dart';
import '../../../../domain/api_client/image_downloader.dart';
import '../../../navigation/app_navigation.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/cached_network_image_widget.dart';
import '../../../widgets/inkwell_material_widget.dart';
import '../../../widgets/vertical_widgets_with_header/tv_shows_with_header_widget.dart';
import '../../main/main_view_model.dart';
import 'home_tv_shows_view_model.dart';

class HomeTvShowsScreen extends StatefulWidget {
  const HomeTvShowsScreen({Key? key}) : super(key: key);

  @override
  State<HomeTvShowsScreen> createState() => _HomeTvShowsScreenState();
}

class _HomeTvShowsScreenState extends State<HomeTvShowsScreen> with AutomaticKeepAliveClientMixin {
  @override
  void didChangeDependencies() {
    context.read<HomeTvShowsViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final mapTvShows =
        context.select((HomeTvShowsViewModel vm) => vm.state.tvShowsWithHeader);
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 16),
                  const _HeaderTvShows(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const _TvShowsWithCategoryWidget(),
          ],
        ),
        if (mapTvShows.isEmpty)
          const Center(
            child: CircularProgressIndicator(
              color: AppColors.colorMainText,
            ),
          ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _TvShowsWithCategoryWidget extends StatelessWidget {
  const _TvShowsWithCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeTvShowsViewModel>();
    final isLoadingProgress =
        context.select((HomeTvShowsViewModel vm) => vm.state.isLoadingProgress);
    final tvShowsWithHeader =
        context.select((HomeTvShowsViewModel vm) => vm.state.tvShowsWithHeader);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          vm.showedCategoryAtIndex(context: context, index: index);
          return Column(
            children: [
              TvShowsWithHeaderWidget(
                tvShowData: tvShowsWithHeader.toList()[index],
              ),
              if (isLoadingProgress &&
                  index == tvShowsWithHeader.length - 1) ...[
                const SizedBox(
                  height: 8,
                ),
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.colorMainText,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ],
          );
        },
        childCount: tvShowsWithHeader.length,
      ),
    );
  }
}

class _HeaderTvShows extends StatelessWidget {
  const _HeaderTvShows({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _HeaderPageViewWidget(),
        SizedBox(height: 8),
        _HeaderIndicatorsWidget(),
      ],
    );
  }
}

class _HeaderPageViewWidget extends StatelessWidget {
  const _HeaderPageViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeTvShowsViewModel>();
    final headerTvShows =
        context.select((HomeTvShowsViewModel vm) => vm.state.headerTvShows);
    return SizedBox(
      height: 168,
      child: Swiper(
        curve: Curves.easeInOut,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _HeaderTvShowsItemWidget(index: index);
        },
        autoplay: true,
        onIndexChanged: vm.onIndexChanged,
        itemCount: headerTvShows.length,
        viewportFraction: 302 / 390,
      ),
    );
  }
}

class _HeaderIndicatorsWidget extends StatelessWidget {
  const _HeaderIndicatorsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerTvShows =
        context.select((HomeTvShowsViewModel vm) => vm.state.headerTvShows);
    final currentHeaderTvShowIndex = context
        .select((HomeTvShowsViewModel vm) => vm.state.currentHeaderTvShowIndex);
    final indicators = headerTvShows
        .asMap()
        .map(
          (indexTvShow, value) => MapEntry(
            indexTvShow,
            Container(
              width: 6,
              height: 6,
              margin: EdgeInsets.only(
                right: indexTvShow != headerTvShows.length - 1 ? 9.0 : 0.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radius15),
                color: indexTvShow == currentHeaderTvShowIndex
                    ? AppColors.colorSecondary
                    : AppColors.colorSecondaryText,
              ),
            ),
          ),
        )
        .values
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }
}

class _HeaderTvShowsItemWidget extends StatelessWidget {
  final int index;
  const _HeaderTvShowsItemWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerTvShows =
        context.select((HomeTvShowsViewModel vm) => vm.state.headerTvShows);
    final currentHeaderTvShowIndex = context
        .select((HomeTvShowsViewModel vm) => vm.state.currentHeaderTvShowIndex);
    return headerTvShows.isNotEmpty ? InkWellMaterialWidget(
      color: AppColors.colorSplash,
      borderRadius: AppDimensions.radius5,
      onTap: () {
        context.read<MainViewModel>().showAdIfAvailable();
        Navigator.of(context).pushNamed(Screens.tvShowDetails,
            arguments: headerTvShows[index].id);
      },
      child: CachedNetworkImageWidget(
        imageUrl:
            ImageDownloader.imageUrl(headerTvShows[index].backdropPath ?? ''),
        imageBuilder: (context, imageProvider) => Container(
          margin: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: index != currentHeaderTvShowIndex ? 4.0 : 0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppDimensions.radius5,
            ),
            color: index != currentHeaderTvShowIndex
                ? AppColors.colorPrimary.withOpacity(0.7)
                : Colors.transparent,
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                index != currentHeaderTvShowIndex
                    ? AppColors.colorPrimary.withOpacity(0.7)
                    : Colors.transparent,
                BlendMode.darken,
              ),
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ) : const SizedBox.shrink();
  }
}
