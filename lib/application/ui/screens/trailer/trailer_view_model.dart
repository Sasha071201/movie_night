import 'package:flutter/cupertino.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerViewModel extends ChangeNotifier {
  final String youtubeKey;
  late final YoutubePlayerController controller = YoutubePlayerController(
    initialVideoId: youtubeKey,
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      loop: true,
    ),
  );

  TrailerViewModel(this.youtubeKey) {
    controller.toggleFullScreenMode();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
