import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/ui/screens/filter/filter_view_model.dart';
import 'package:movie_night/application/ui/screens/view_all_movies/view_all_movies_view_model.dart';

import '../factories/screen_factory.dart';
import '../screens/view_favorite/view_favorite_view_model.dart';
import '../screens/view_movies/view_movies_view_model.dart';

abstract class Screens {
  Screens._();
  static const initial = "/";
  static const aboutMe = "/about_me";
  static const subscription = "/subscription";
  static const signUp = "/sign_in/sign_up";
  static const resetPassword = "/sign_in/reset_password";
  static const viewAllMovies = "/view_all_movies";
  static const viewFavorite = "/view_favorite";
  static const viewSearchResult = "/view_search_result";
  static const viewAllActors = "/view_all_actors";
  static const filter = "/view_all_movies/filter";
  static const movieDetails = "/movie_details";
  static const trailer = "/movie_details/trailer";
  static const viewMovies = "/movie_details/view_movies";
  static const tvShowDetails = "/tv_show_details";
  static const seasonDetails = "/tv_show_details/season_details";
  static const episodeDetails = "/tv_show_details/episode_details";
  static const actorDetails = "/actor_details";
}

class AppNavigation {
  static final _screenFactory = ScreenFactory();
  static const initial = Screens.initial;

  static Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Screens.initial:
        return _getScreenRoute(_screenFactory.makeInitial());
      case Screens.signUp:
        return _getScreenRoute(_screenFactory.makeSignUp());
      case Screens.resetPassword:
        return _getScreenRoute(_screenFactory.makeResetPassword());
      case Screens.aboutMe:
        return _getScreenRoute(_screenFactory.makeAboutMe());
      case Screens.subscription:
        return _getScreenRoute(_screenFactory.makeSubscription());
      case Screens.movieDetails:
        final movieId = settings.arguments as int;
        return _getScreenRoute(_screenFactory.makeMovieDetails(movieId));
      case Screens.tvShowDetails:
        final tvShowId = settings.arguments as int;
        return _getScreenRoute(_screenFactory.makeTvShowDetails(tvShowId));
      case Screens.viewMovies:
        final data = settings.arguments as ViewMoviesData;
        return _getScreenRoute(_screenFactory.makeViewMovies(data));
      case Screens.viewSearchResult:
        final query = settings.arguments as String;
        return _getScreenRoute(_screenFactory.makeViewSearchResult(query));
      case Screens.trailer:
        final youtubeKey = settings.arguments as String;
        return _getScreenRoute(_screenFactory.makeTrailer(youtubeKey));
      case Screens.viewAllActors:
        return _getScreenRoute(_screenFactory.makeViewAllActors());
      case Screens.viewFavorite:
        final data = settings.arguments as ViewFavoriteData;
        return _getScreenRoute(_screenFactory.makeViewFavorite(data));
      case Screens.seasonDetails:
        final listId = settings.arguments as List<int>;
        return _getScreenRoute(_screenFactory.makeSeasonDetails(
          seasonId: listId[0],
          tvShowId: listId[1],
        ));
      case Screens.episodeDetails:
        final listId = settings.arguments as List<int>;
        return _getScreenRoute(_screenFactory.makeEpisodeDetails(
          episodeId: listId[0],
          seasonId: listId[1],
          tvShowId: listId[2],
        ));
      case Screens.actorDetails:
        final actorId = settings.arguments as int;
        return _getScreenRoute(
            _screenFactory.makeActorDetails(actorId: actorId));
      case Screens.viewAllMovies:
        final listData = settings.arguments as List;
        final data = listData[0] as ViewAllMoviesData;
        final mediaType = listData[1] as MediaType;
        return _getScreenRoute(_screenFactory.makeViewAllMovies(
          data: data,
          mediaType: mediaType,
        ));
      case Screens.filter:
        final listData = settings.arguments as List;
        final data = listData[0] as FilterData;
        final mediaType = listData[1] as MediaType;
        final openFromMain = listData[2] as bool;
        return _getScreenRoute(_screenFactory.makeFilter(
          data: data,
          mediaType: mediaType,
          openFromMain: openFromMain,
        ));
      default:
        return _getScreenRoute(
          const Scaffold(
            body: Center(
              child: Text("What?"),
            ),
          ),
        );
    }
  }

  static void pop(BuildContext context, int count) {
    int number = 0;
    Navigator.of(context).popUntil((route) {
      return number++ == count;
    });
  }

  static Route<Object> _getScreenRoute(Widget child) => PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1),
        pageBuilder: (context, animation, _) => FadeTransition(
          opacity: animation,
          child: child,
        ),
      );

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      Screens.initial,
      (route) => false,
    );
  }
}
