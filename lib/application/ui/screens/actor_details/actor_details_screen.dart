import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

import 'package:movie_night/application/constants/app_dimensions.dart';
import 'package:movie_night/application/domain/api_client/image_downloader.dart';
import 'package:movie_night/application/domain/firebase/firebase_dynamic_link.dart';
import 'package:movie_night/application/ui/screens/actor_details/actor_details_view_model.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/cached_network_image_widget.dart';
import 'package:movie_night/application/ui/widgets/inkwell_material_widget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../generated/l10n.dart';
import '../../widgets/details/expansion_tile_credits_widget.dart';
import '../../widgets/details/external_sources_widget.dart';
import '../../widgets/details/media_widget.dart';
import '../../widgets/details/overview_widget.dart';
import '../../widgets/details/row_main_info_widget.dart';
import '../../widgets/details/title_widget.dart';
import '../../widgets/icon_button_widget.dart';
import '../../widgets/review_sliver_widget.dart';
import '../../widgets/review_text_field_widget.dart';

class ActorDetailsScreen extends StatefulWidget {
  const ActorDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ActorDetailsScreen> createState() => _ActorDetailsScreenState();
}

class _ActorDetailsScreenState extends State<ActorDetailsScreen> {
  @override
  void didChangeDependencies() {
    context.read<ActorDetailsViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final actorDetails = context.select((ActorDetailsViewModel vm) => vm.state.actorDetails);
    final isLoaded = context.select((ActorDetailsViewModel vm) => vm.state.isLoaded);
    return Scaffold(
      body: actorDetails != null && isLoaded
          ? CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                      const _HeaderWidget(),
                      const SizedBox(height: 16),
                      const _TitleWidget(),
                      const SizedBox(height: 16),
                      const _RowMainInfoWidget(),
                      const SizedBox(height: 16),
                      const _BiographyWidget(),
                      const SizedBox(height: 16),
                      const _MediaWidget(),
                      const SizedBox(height: 16),
                      const _CastExpansionTileWidget(),
                      const SizedBox(height: 16),
                      const _CrewExpansionTileWidget(),
                      const SizedBox(height: 16),
                      const _ExternalSourcesWidget(),
                      const SizedBox(height: 16)
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              S.of(context).reviews,
                              style: AppTextStyle.header3,
                            ),
                            const SizedBox(height: 8),
                            const _ReviewTextFieldWidget(),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const _ReviewsWidget(),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const _BottomPaddingWidget(),
                    ],
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
            ),
    );
  }
}

class _ReviewTextFieldWidget extends StatelessWidget {
  const _ReviewTextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ActorDetailsViewModel>();
    final isProgressSending =
        context.select((ActorDetailsViewModel vm) => vm.state.isProgressSending);
    return ReviewTextFieldWidget(
      isProgressSending: isProgressSending,
      sendReview: vm.sendReview,
      controller: vm.reviewTextController,
    );
  }
}

class _ReviewsWidget extends StatelessWidget {
  const _ReviewsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ActorDetailsViewModel>();
    final reviews = context.select((ActorDetailsViewModel vm) => vm.reviews);
    return ReviewsSliverWidget(
      reviews: reviews,
      timeAgoFromDate: vm.timeAgoFromDate,
      deleteReview: vm.deleteReview,
      complaintReviewTextController: vm.complaintReviewTextController,
      sendComplaintToReview: vm.sendComplaintToReview,
    );
  }
}

class _BottomPaddingWidget extends StatelessWidget {
  const _BottomPaddingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final insetsBottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(padding: EdgeInsets.only(bottom: insetsBottom == 0 ? 32 : insetsBottom + 16));
  }
}

class _MediaWidget extends StatelessWidget {
  const _MediaWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profiles = context.select((ActorDetailsViewModel vm) => vm.state.actorImages?.profiles);
    return MediaWidget(
      aspectRatios: profiles
          ?.map(
            (backdrop) => backdrop.aspectRatio,
          )
          .toList(),
      backdrops: profiles
          ?.map(
            (backdrop) => backdrop.filePath,
          )
          .toList(),
    );
  }
}

class _CastExpansionTileWidget extends StatelessWidget {
  const _CastExpansionTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ActorDetailsViewModel>();
    final cast =
        context.select((ActorDetailsViewModel vm) => vm.state.actorDetails?.combinedCredits.cast);
    return cast != null && cast.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.mediumPadding,
            ),
            child: ExpansionTileCreditsWidget(
              data: ExpansionTileCreditsData(
                header: S.of(context).cast_actor_details,
                credits: cast,
                stringFromDate: vm.stringFromDate,
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}

class _CrewExpansionTileWidget extends StatelessWidget {
  const _CrewExpansionTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ActorDetailsViewModel>();
    final crew =
        context.select((ActorDetailsViewModel vm) => vm.state.actorDetails?.combinedCredits.crew);
    return crew != null && crew.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.mediumPadding,
            ),
            child: ExpansionTileCreditsWidget(
              data: ExpansionTileCreditsData(
                header: S.of(context).crew_actor_details,
                credits: crew,
                stringFromDate: vm.stringFromDate,
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ActorDetailsViewModel>();
    final isFavorite = context.select((ActorDetailsViewModel vm) => vm.state.isFavorite);
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          const _ActorImageWidget(),
          Positioned(
            right: 24,
            top: 0,
            child: Column(
              children: [
                IconButtonWidget(
                  icon: Icon(
                    Icons.favorite,
                    color: isFavorite ? AppColors.colorSecondary : AppColors.colorSecondaryText,
                    size: 32,
                  ),
                  onPressed: vm.favoritePerson,
                ),
                IconButtonWidget(
                  icon: const Icon(
                    Icons.share,
                    color: AppColors.colorSecondary,
                    size: 32,
                  ),
                  onPressed: () async {
                    if (vm.state.actorDetails?.id == null) return;
                    final url = await FirebaseDynamicLinkService.createDynamicLink(
                      type: FirebaseDynamicLinkType.person,
                      id: vm.state.actorDetails!.id.toString(),
                      title: vm.state.actorDetails?.name ?? '',
                      description: vm.state.actorDetails?.biography ?? '',
                    );
                    Share.share(url);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BiographyWidget extends StatelessWidget {
  const _BiographyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final biography =
        context.select((ActorDetailsViewModel vm) => vm.state.actorDetails?.biography);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.mediumPadding,
      ),
      child: LargeTextWithHeaderWidget(
        header: S.of(context).biography,
        overview: biography ?? '',
      ),
    );
  }
}

class _ExternalSourcesWidget extends StatelessWidget {
  const _ExternalSourcesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final externalIds =
        context.select((ActorDetailsViewModel vm) => vm.state.actorDetails!.externalIds);
    final allIsNull = (externalIds.facebookId ?? '').isEmpty &&
        (externalIds.instagramId ?? '').isEmpty &&
        (externalIds.twitterId ?? '').isEmpty;
    final data = [
      ExternalSourcesData(
        type: ExternalSourcesType.facebook,
        source: externalIds.facebookId ?? '',
      ),
      ExternalSourcesData(
        type: ExternalSourcesType.instagram,
        source: externalIds.instagramId ?? '',
      ),
      ExternalSourcesData(
        type: ExternalSourcesType.twitter,
        source: externalIds.twitterId ?? '',
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.mediumPadding,
      ),
      child: ExternalSourcesWidget(allIsNull: allIsNull, data: data),
    );
  }
}

class _RowMainInfoWidget extends StatelessWidget {
  const _RowMainInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ActorDetailsViewModel>();
    final actor = context.select((ActorDetailsViewModel vm) => vm.state.actorDetails!);
    final actorInfoData = <RowMainInfoData>[
      if (actor.birthday != null)
        RowMainInfoData(
          icon: Icons.calendar_month,
          title: '${S.of(context).date_of_birth}: ${vm.stringFromDate(actor.birthday)}',
        ),
      RowMainInfoData(
        icon: Icons.info_rounded,
        title:
            '${S.of(context).gender}: ${actor.gender == 1 ? S.of(context).female : S.of(context).male}',
      ),
      if (actor.birthday != null)
        if (actor.placeOfBirth != null)
          RowMainInfoData(
            icon: Icons.location_city_rounded,
            title: '${S.of(context).place_of_birth}: ${actor.placeOfBirth}',
          ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.mediumPadding,
      ),
      child: RowMainInfoWidget(data: actorInfoData),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = context.select((ActorDetailsViewModel vm) => vm.state.actorDetails!.name);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.mediumPadding,
      ),
      child: TitleWidget(title: title),
    );
  }
}

class _ActorImageWidget extends StatelessWidget {
  const _ActorImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actorDetails = context.select((ActorDetailsViewModel vm) => vm.state.actorDetails);
    return Center(
      child: InkWellMaterialWidget(
        borderRadius: AppDimensions.radius5,
        color: AppColors.colorSplash,
        onTap: () => showImageViewer(
            context,
            Image.network(ImageDownloader.imageHighQualityUrl(actorDetails?.profilePath ?? ''))
                .image),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            AppDimensions.radius5,
          ),
          child: CachedNetworkImageWidget(
            width: 156,
            height: 200,
            imageUrl: ImageDownloader.imageUrl(actorDetails?.profilePath ?? ''),
          ),
        ),
      ),
    );
  }
}
