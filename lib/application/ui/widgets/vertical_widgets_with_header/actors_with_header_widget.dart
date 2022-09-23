import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';
import 'package:movie_night/application/ui/screens/main/main_view_model.dart';

import 'package:movie_night/application/ui/widgets/vertical_widgets_with_header/vertical_actor_widget.dart';
import 'package:provider/provider.dart';

import '../../../domain/api_client/media_type.dart';
import '../../../domain/entities/actor/actor.dart';
import '../../screens/view_favorite/view_favorite_view_model.dart';
import 'vertical_widget_with_header.dart';

class ActorWithHeaderData {
  final String title;
  final List<Actor> list;
  final ViewFavoriteType? viewFavoriteType;

  ActorWithHeaderData({
    required this.title,
    required this.list,
    this.viewFavoriteType,
  });
}

class ActorsWithHeaderWidget extends StatelessWidget {
  final ActorWithHeaderData actorData;
  final void Function()? onPressed;
  final String? userId;

  const ActorsWithHeaderWidget({
    Key? key,
    required this.actorData,
    this.onPressed,
    this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalWidgetWithHeaderWidget(
        title: actorData.title,
        dataLength: actorData.list.length,
        itemBuilder: (index) => VerticalActorWidget(
              actor: actorData.list[index],
              onPressed: onPressed,
            ),
        onPressedViewAll: () async {
          try {
            context.read<MainViewModel>().showAdIfAvailable();
          } catch (e) {}
          if (actorData.viewFavoriteType != null) {
            await Navigator.of(context).pushNamed(
              Screens.viewFavorite,
              arguments: ViewFavoriteData(
                mediaType: MediaType.person,
                favoriteType: actorData.viewFavoriteType!,
                userId: userId,
              ),
            );
            if (onPressed != null) onPressed!();
          } else {
            await Navigator.of(context).pushNamed(
              Screens.viewAllActors,
            );
            if (onPressed != null) onPressed!();
          }
        });
  }
}
