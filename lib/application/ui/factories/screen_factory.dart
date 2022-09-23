import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/ui/screens/episode_details/episode_details_screen.dart';
import 'package:movie_night/application/ui/screens/favorite/favorite_view_model.dart';
import 'package:movie_night/application/ui/screens/home/actors/home_actors_view_model.dart';
import 'package:movie_night/application/ui/screens/home/home_view_model.dart';
import 'package:movie_night/application/ui/screens/home/movies/home_movies_view_model.dart';
import 'package:movie_night/application/ui/screens/home/tv_shows/home_tv_shows_view_model.dart';
import 'package:movie_night/application/ui/screens/initial/initial_screen.dart';
import 'package:movie_night/application/ui/screens/initial/initial_view_model.dart';
import 'package:movie_night/application/ui/screens/main/main_screen.dart';
import 'package:movie_night/application/ui/screens/main/main_view_model.dart';
import 'package:movie_night/application/ui/screens/movie_details/movie_details_screen.dart';
import 'package:movie_night/application/ui/screens/movie_details/movie_details_view_model.dart';
import 'package:movie_night/application/ui/screens/profile/profile_view_model.dart';
import 'package:movie_night/application/ui/screens/settings/settings_screen.dart';
import 'package:movie_night/application/ui/screens/settings/settings_view_model.dart';
import 'package:movie_night/application/ui/screens/subscribers/subscribers_screen.dart';
import 'package:movie_night/application/ui/screens/subscribers/subscribers_view_model.dart';
import 'package:movie_night/application/ui/screens/subscriptions/subscriptions_screen.dart';
import 'package:movie_night/application/ui/screens/subscriptions/subscriptions_view_model.dart';
import 'package:movie_night/application/ui/screens/trailer/trailer_screen.dart';
import 'package:movie_night/application/ui/screens/trailer/trailer_view_model.dart';
import 'package:movie_night/application/ui/screens/user_details/user_details_screen.dart';
import 'package:movie_night/application/ui/screens/user_details/user_details_view_model.dart';
import 'package:movie_night/application/ui/screens/view_all_actors/view_all_actors_screen.dart';
import 'package:movie_night/application/ui/screens/view_all_actors/view_all_actors_view_model.dart';
import 'package:provider/provider.dart';

import '../screens/about_me/about_me_screen.dart';
import '../screens/about_me/about_me_view_model.dart';
import '../screens/actor_details/actor_details_screen.dart';
import '../screens/actor_details/actor_details_view_model.dart';
import '../screens/episode_details/episode_details_view_model.dart';
import '../screens/favorite/actors/favorite_actors_view_model.dart';
import '../screens/favorite/movies/favorite_movies_view_model.dart';
import '../screens/favorite/tv_shows/favorite_tv_shows_view_model.dart';
import '../screens/filter/filter_screen.dart';
import '../screens/filter/filter_view_model.dart';
import '../screens/reset_password/reset_password_screen.dart';
import '../screens/reset_password/reset_password_view_model.dart';
import '../screens/search/actors/search_actors_view_model.dart';
import '../screens/search/movies/search_movies_view_model.dart';
import '../screens/search/search_view_model.dart';
import '../screens/search/tv_shows/search_tv_shows_view_model.dart';
import '../screens/season_details/season_details_screen.dart';
import '../screens/season_details/season_details_view_model.dart';
import '../screens/sign_in/sign_in_view_model.dart';
import '../screens/sign_up/sign_up_screen.dart';
import '../screens/sign_up/sign_up_view_model.dart';
import '../screens/subscription/subscription_screen.dart';
import '../screens/subscription/subscription_view_model.dart';
import '../screens/tv_show_details/tv_show_details_screen.dart';
import '../screens/tv_show_details/tv_show_details_view_model.dart';
import '../screens/users/users_screen.dart';
import '../screens/users/users_view_model.dart';
import '../screens/view_all_movies/view_all_movies_screen.dart';
import '../screens/view_all_movies/view_all_movies_view_model.dart';
import '../screens/view_favorite/view_favorite_screen.dart';
import '../screens/view_favorite/view_favorite_view_model.dart';
import '../screens/view_movies/view_movies_screen.dart';
import '../screens/view_movies/view_movies_view_model.dart';
import '../screens/view_search_result/view_all_movies_screen.dart';
import '../screens/view_search_result/view_all_movies_view_model.dart';

class ScreenFactory {
  Widget makeInitial() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => InitialViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignInViewModel(context),
        ),
      ],
      child: const InitialScreen(),
    );
  }

  Widget makeMain() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeMoviesViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeTvShowsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeActorsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteMoviesViewModel(context),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteTvShowsViewModel(context),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteActorsViewModel(context),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchMoviesViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchTvShowsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchActorsViewModel(),
        ),
      ],
      child: const MainScreen(),
    );
  }

  Widget makeSignUp() {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(context),
      child: const SignUpScreen(),
    );
  }

  Widget makeUsers() {
    return ChangeNotifierProvider(
      create: (context) => UsersViewModel(),
      child: const UsersScreen(),
    );
  }

  Widget makeSettings() {
    return ChangeNotifierProvider(
      create: (context) => SettingsViewModel(),
      child: const SettingsScreen(),
    );
  }

  Widget makeSubscriptions() {
    return ChangeNotifierProvider(
      create: (context) => SubscriptionsViewModel(),
      child: const SubscriptionsScreen(),
    );
  }

  Widget makeSubscribers() {
    return ChangeNotifierProvider(
      create: (context) => SubscribersViewModel(),
      child: const SubscribersScreen(),
    );
  }

  Widget makeResetPassword() {
    return ChangeNotifierProvider(
      create: (context) => ResetPasswordViewModel(context),
      child: const ResetPasswordScreen(),
    );
  }

  Widget makeAboutMe() {
    return ChangeNotifierProvider(
      create: (context) => AboutMeViewModel(),
      child: const AboutMeScreen(),
    );
  }

  Widget makeSubscription() {
    return ChangeNotifierProvider(
      create: (context) => SubscriptionViewModel(),
      child: const SubscriptionScreen(),
    );
  }

  Widget makeMovieDetails(int movieId) {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailsViewModel(movieId),
      child: const MovieDetailsScreen(),
    );
  }

  Widget makeUserDetails(String userId) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserDetailsViewModel(userId),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteViewModel(userId),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteActorsViewModel(context, userId),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteMoviesViewModel(context, userId),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteTvShowsViewModel(context, userId),
        ),
      ],
      child: const UserDetailsScreen(),
    );
  }

  Widget makeTvShowDetails(int tvShowId) {
    return ChangeNotifierProvider(
      create: (context) => TvShowDetailsViewModel(tvShowId),
      child: const TvShowDetailsScreen(),
    );
  }

  Widget makeViewMovies(ViewMoviesData data) {
    return ChangeNotifierProvider(
      create: (context) => ViewMoviesViewModel(data),
      child: const ViewMoviesScreen(),
    );
  }

  Widget makeViewSearchResult(String query) {
    return ChangeNotifierProvider(
      create: (context) => ViewSearchResultViewModel(query: query),
      child: const ViewSearchResultScreen(),
    );
  }

  Widget makeTrailer(String youtubeKey) {
    return ChangeNotifierProvider(
      create: (context) => TrailerViewModel(youtubeKey),
      child: const TrailerScreen(),
    );
  }

  Widget makeViewAllActors() {
    return ChangeNotifierProvider(
      create: (context) => ViewAllActorsViewModel(),
      child: const ViewAllActorsScreen(),
    );
  }

  Widget makeViewFavorite(ViewFavoriteData data) {
    return ChangeNotifierProvider(
      create: (context) => ViewFavoriteViewModel(data),
      child: const ViewFavoriteScreen(),
    );
  }

  Widget makeSeasonDetails({required int seasonId, required int tvShowId}) {
    return ChangeNotifierProvider(
      create: (context) => SeasonDetailsViewModel(seasonId: seasonId, tvShowId: tvShowId),
      child: const SeasonDetailsScreen(),
    );
  }

  Widget makeEpisodeDetails({
    required int episodeId,
    required int seasonId,
    required int tvShowId,
  }) {
    return ChangeNotifierProvider(
      create: (context) =>
          EpisodeDetailsViewModel(episodeId: episodeId, seasonId: seasonId, tvShowId: tvShowId),
      child: const EpisodeDetailsScreen(),
    );
  }

  Widget makeActorDetails({required int actorId}) {
    return ChangeNotifierProvider(
      create: (context) => ActorDetailsViewModel(actorId),
      child: const ActorDetailsScreen(),
    );
  }

  Widget makeViewAllMovies({
    required ViewAllMoviesData data,
    required MediaType mediaType,
  }) {
    return ChangeNotifierProvider(
      create: (context) => ViewAllMoviesViewModel(data, mediaType),
      child: const ViewAllMoviesScreen(),
    );
  }

  Widget makeFilter({
    required FilterData data,
    required MediaType mediaType,
    required bool openFromMain,
  }) {
    return ChangeNotifierProvider(
      create: (context) => FilterViewModel(
        data: data,
        mediaType: mediaType,
        openFromMain: openFromMain,
      ),
      child: const FilterScreen(),
    );
  }
}
