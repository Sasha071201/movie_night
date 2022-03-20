import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/screens/favorite/favorite_view_model.dart';
import 'package:movie_night/application/ui/screens/filter_movies/filter_movies_screen.dart';
import 'package:movie_night/application/ui/screens/home/actors/home_actors_view_model.dart';
import 'package:movie_night/application/ui/screens/home/home_view_model.dart';
import 'package:movie_night/application/ui/screens/home/movies/home_movies_view_model.dart';
import 'package:movie_night/application/ui/screens/home/tv_shows/home_tv_shows_view_model.dart';
import 'package:movie_night/application/ui/screens/main/main_screen.dart';
import 'package:movie_night/application/ui/screens/main/main_view_model.dart';
import 'package:movie_night/application/ui/screens/movie_details/movie_details_screen.dart';
import 'package:movie_night/application/ui/screens/movie_details/movie_details_view_model.dart';
import 'package:provider/provider.dart';

import '../screens/actor_details/actor_details_screen.dart';
import '../screens/actor_details/actor_details_view_model.dart';
import '../screens/favorite/actors/favorite_actors_view_model.dart';
import '../screens/favorite/movies/Favorite_movies_view_model.dart';
import '../screens/favorite/tv_shows/favorite_tv_shows_view_model.dart';
import '../screens/filter_movies/filter_movies_view_model.dart';
import '../screens/loader/loader_screen.dart';
import '../screens/loader/loader_view_model.dart';
import '../screens/search/actors/search_actors_view_model.dart';
import '../screens/search/movies/search_movies_view_model.dart';
import '../screens/search/search_view_model.dart';
import '../screens/search/tv_shows/favorite_tv_shows_view_model.dart';
import '../screens/sign_in/sign_in_screen.dart';
import '../screens/sign_in/sign_in_view_model.dart';
import '../screens/sign_up/sign_up_screen.dart';
import '../screens/sign_up/sign_up_view_model.dart';
import '../screens/view_all_movies/view_all_screen.dart';

class ScreenFactory {
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderViewModel(context),
      child: const LoaderScreen(),
      lazy: false,
    );
  }

  Widget makeSignUp() {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: const SignUpScreen(),
    );
  }

  Widget makeSignIn() {
    return ChangeNotifierProvider(
      create: (context) => SignInViewModel(),
      child: const SignInScreen(),
    );
  }

  Widget makeMain() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainViewModel(),
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
          create: (_) => FavoriteMoviesViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteTvShowsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteActorsViewModel(),
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

  Widget makeMovieDetails() {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailsViewModel(),
      child: const MovieDetailsScreen(),
    );
  }

  Widget makeActorDetails() {
    return ChangeNotifierProvider(
      create: (context) => ActorDetailsViewModel(),
      child: const ActorDetailsScreen(),
    );
  }

  Widget makeViewAllMovies() {
    return ChangeNotifierProvider(
      create: (context) => ActorDetailsViewModel(),
      child: const ViewAllMoviesScreen(),
    );
  }

  Widget makeFilterMovies() {
    return ChangeNotifierProvider(
      create: (context) => FilterMoviesViewModel(),
      child: const FilterMoviesScreen(),
    );
  }
}
