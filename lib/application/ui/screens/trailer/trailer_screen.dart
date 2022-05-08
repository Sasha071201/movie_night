import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/screens/trailer/trailer_view_model.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../generated/l10n.dart';

class TrailerScreen extends StatelessWidget {
  const TrailerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = context.read<TrailerViewModel>().controller;
    final player = YoutubePlayer(
      progressIndicatorColor: AppColors.colorSecondary,
      progressColors: const ProgressBarColors(
        handleColor: AppColors.colorSecondary,
        playedColor: AppColors.colorSecondary,
      ),
      actionsPadding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 8,
      ),
      onEnded: (meta) {
        _controller.toggleFullScreenMode();
      },
      controller: _controller,
      showVideoProgressIndicator: true,
    );
    return YoutubePlayerBuilder(
      player: player,
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.colorPrimary,
            title: Text(
              S.of(context).trailer,
              style: AppTextStyle.header3,
            ),
            centerTitle: true,
          ),
          body: Center(
            child: player,
          ),
        );
      },
    );
  }
}
