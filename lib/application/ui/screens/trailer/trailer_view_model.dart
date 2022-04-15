import 'package:flutter/cupertino.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerViewModel extends ChangeNotifier {
  final String youtubeKey;
  late final YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: youtubeKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: true,
      ));

  TrailerViewModel(this.youtubeKey){
    controller.toggleFullScreenMode();
  }
}
