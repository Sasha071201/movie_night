import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../widgets/app_grid_view.dart';
import '../../widgets/vertical_widgets_with_header/vertical_actor_widget.dart';
import '../../widgets/vertical_widgets_with_header/vertical_movie_widget.dart';
import '../../widgets/vertical_widgets_with_header/vertical_tv_show_widget.dart';
import 'view_favorite_view_model.dart';

class ViewFavoriteScreen extends StatefulWidget {
  const ViewFavoriteScreen({Key? key}) : super(key: key);

  @override
  State<ViewFavoriteScreen> createState() => _ViewFavoriteScreenState();
}

class _ViewFavoriteScreenState extends State<ViewFavoriteScreen> {
  @override
  void didChangeDependencies() {
    context.read<ViewFavoriteViewModel>().setupLocale(context);
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
    final isLoadingProgress = context
        .select((ViewFavoriteViewModel vm) => vm.state.isLoadingProgress);
    final media =
        context.select((ViewFavoriteViewModel vm) => vm.state.media.media);
    final mediaType =
        context.select((ViewFavoriteViewModel vm) => vm.state.media.mediaType);
    return !isLoadingProgress
        ? media.isNotEmpty
            ? AppGridView(
                itemBuilder: (context, index) {
                  Widget child = const SizedBox.shrink();
                  if (mediaType == MediaType.movie) {
                    child = Align(
                      alignment: Alignment.topCenter,
                      child: VerticalMovieWidget(
                        movie: media[index],
                      ),
                    );
                  } else if (mediaType == MediaType.tv) {
                    child = VerticalTvShowWidget(
                      tvShow: media[index],
                    );
                  } else if (mediaType == MediaType.person) {
                    child = VerticalActorWidget(
                      actor: media[index],
                    );
                  }
                  return child;
                },
                itemCount: media.length,
              )
            : Center(
                child: Text(
                  S.of(context).no_data,
                  style: AppTextStyle.header1,
                ),
              )
        : const Center(
            child: CircularProgressIndicator(
              color: AppColors.colorMainText,
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
    final viewMediaType =
        context.select((ViewFavoriteViewModel vm) => vm.data.favoriteType);
    final mediaType =
        context.select((ViewFavoriteViewModel vm) => vm.state.media.mediaType);
    String text = '';
    if (mediaType == MediaType.movie) {
      text = '${viewMediaType.asString(context)} ${S.of(context).movies}';
    } else if (mediaType == MediaType.tv) {
      text = '${viewMediaType.asString(context)} ${S.of(context).tv_shows}';
    } else if (mediaType == MediaType.person) {
      text = '${viewMediaType.asString(context)} ${S.of(context).people}';
    }
    return Text(
      text,
      style: AppTextStyle.header2,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
