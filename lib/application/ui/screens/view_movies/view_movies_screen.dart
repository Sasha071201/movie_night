import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../widgets/vertical_widgets_with_header/vertical_movie_widget.dart';
import '../../widgets/vertical_widgets_with_header/vertical_tv_show_widget.dart';
import 'view_movies_view_model.dart';

class ViewMoviesScreen extends StatefulWidget {
  const ViewMoviesScreen({Key? key}) : super(key: key);

  @override
  State<ViewMoviesScreen> createState() => _ViewMoviesScreenState();
}

class _ViewMoviesScreenState extends State<ViewMoviesScreen> {
  @override
  void didChangeDependencies() {
    context.read<ViewMoviesViewModel>().setupLocale(context);
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: const [
              _HeaderWidget(),
              SizedBox(height: 8.0),
              Expanded(
                child: _ListMoviesWidget(),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
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
    final vm = context.read<ViewMoviesViewModel>();
    final mediaType =
        context.select((ViewMoviesViewModel vm) => vm.state.media.mediaType);
    final isLoadingProgress =
        context.select((ViewMoviesViewModel vm) => vm.state.isLoadingProgress);
    final media =
        context.select((ViewMoviesViewModel vm) => vm.state.media.media);
    return media.isNotEmpty
        ? Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GridView.builder(
                itemCount: media.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 130 / 240, //188 - height, 130 - width
                ),
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

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewMediaType =
        context.select((ViewMoviesViewModel vm) => vm.data.viewMoviesType);
    final mediaType =
        context.select((ViewMoviesViewModel vm) => vm.state.media.mediaType);
    final text = mediaType == MediaType.movie
        ? '${viewMediaType.asString(context)} ${S.of(context).movies}'
        : '${viewMediaType.asString(context)} ${S.of(context).tv_shows}';
    return Text(
      text,
      style: AppTextStyle.header2,
    );
  }
}
