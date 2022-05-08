// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign In`
  String get sign_in {
    return Intl.message(
      'Sign In',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get sign_in_label {
    return Intl.message(
      'Sign In',
      name: 'sign_in_label',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message(
      'Sign Up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up_label {
    return Intl.message(
      'Sign Up',
      name: 'sign_up_label',
      desc: '',
      args: [],
    );
  }

  /// `Enter email`
  String get enter_email {
    return Intl.message(
      'Enter email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enter_password {
    return Intl.message(
      'Enter password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the mail`
  String get fill_in_the_mail {
    return Intl.message(
      'Fill in the mail',
      name: 'fill_in_the_mail',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the password`
  String get fill_in_the_password {
    return Intl.message(
      'Fill in the password',
      name: 'fill_in_the_password',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwords_do_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'passwords_do_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Enter confirm password`
  String get enter_confirm_password {
    return Intl.message(
      'Enter confirm password',
      name: 'enter_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `later`
  String get later {
    return Intl.message(
      'later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Confirm mail`
  String get confirm_mail {
    return Intl.message(
      'Confirm mail',
      name: 'confirm_mail',
      desc: '',
      args: [],
    );
  }

  /// `No such user`
  String get no_such_user {
    return Intl.message(
      'No such user',
      name: 'no_such_user',
      desc: '',
      args: [],
    );
  }

  /// `Email entered incorrectly`
  String get email_entered_incorrectly {
    return Intl.message(
      'Email entered incorrectly',
      name: 'email_entered_incorrectly',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error. Write to support`
  String get unknown_error_write_to_support {
    return Intl.message(
      'Unknown error. Write to support',
      name: 'unknown_error_write_to_support',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get incorrect_password {
    return Intl.message(
      'Incorrect password',
      name: 'incorrect_password',
      desc: '',
      args: [],
    );
  }

  /// `Too simple password. Requires at least 6 characters`
  String get too_simple_password {
    return Intl.message(
      'Too simple password. Requires at least 6 characters',
      name: 'too_simple_password',
      desc: '',
      args: [],
    );
  }

  /// `This email is already in use`
  String get this_email_is_already_in_use {
    return Intl.message(
      'This email is already in use',
      name: 'this_email_is_already_in_use',
      desc: '',
      args: [],
    );
  }

  /// `Too many requests. Try another time`
  String get too_many_requests_try_another_time {
    return Intl.message(
      'Too many requests. Try another time',
      name: 'too_many_requests_try_another_time',
      desc: '',
      args: [],
    );
  }

  /// `Network error. Check your internet connection`
  String get network_error_check_your_internet_connection {
    return Intl.message(
      'Network error. Check your internet connection',
      name: 'network_error_check_your_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Movie details not saved`
  String get movie_details_not_saved {
    return Intl.message(
      'Movie details not saved',
      name: 'movie_details_not_saved',
      desc: '',
      args: [],
    );
  }

  /// `Actor details not saved`
  String get actor_details_not_saved {
    return Intl.message(
      'Actor details not saved',
      name: 'actor_details_not_saved',
      desc: '',
      args: [],
    );
  }

  /// `Serial details not saved`
  String get serial_details_not_saved {
    return Intl.message(
      'Serial details not saved',
      name: 'serial_details_not_saved',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get no_internet_connection {
    return Intl.message(
      'No internet connection',
      name: 'no_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Nothing to see?`
  String get nothing_to_see {
    return Intl.message(
      'Nothing to see?',
      name: 'nothing_to_see',
      desc: '',
      args: [],
    );
  }

  /// `See what others are currently watching at on the search page`
  String get see_what_others_watching_on_search_page {
    return Intl.message(
      'See what others are currently watching at on the search page',
      name: 'see_what_others_watching_on_search_page',
      desc: '',
      args: [],
    );
  }

  /// `Can't sleep?`
  String get cannot_sleep {
    return Intl.message(
      'Can\'t sleep?',
      name: 'cannot_sleep',
      desc: '',
      args: [],
    );
  }

  /// `See what movies are out today`
  String get see_what_movies_are_out_today {
    return Intl.message(
      'See what movies are out today',
      name: 'see_what_movies_are_out_today',
      desc: '',
      args: [],
    );
  }

  /// `Checking data for updates`
  String get checking_data_for_updates {
    return Intl.message(
      'Checking data for updates',
      name: 'checking_data_for_updates',
      desc: '',
      args: [],
    );
  }

  /// `Click to open the application`
  String get click_to_open_the_application {
    return Intl.message(
      'Click to open the application',
      name: 'click_to_open_the_application',
      desc: '',
      args: [],
    );
  }

  /// `Description has changed`
  String get description_has_changed {
    return Intl.message(
      'Description has changed',
      name: 'description_has_changed',
      desc: '',
      args: [],
    );
  }

  /// `Release date has changed`
  String get release_date_has_changed {
    return Intl.message(
      'Release date has changed',
      name: 'release_date_has_changed',
      desc: '',
      args: [],
    );
  }

  /// `Status changed to`
  String get status_changed_to {
    return Intl.message(
      'Status changed to',
      name: 'status_changed_to',
      desc: '',
      args: [],
    );
  }

  /// `A trailer has appeared`
  String get trailer_has_appeared {
    return Intl.message(
      'A trailer has appeared',
      name: 'trailer_has_appeared',
      desc: '',
      args: [],
    );
  }

  /// `Season`
  String get season {
    return Intl.message(
      'Season',
      name: 'season',
      desc: '',
      args: [],
    );
  }

  /// `Episode`
  String get episode {
    return Intl.message(
      'Episode',
      name: 'episode',
      desc: '',
      args: [],
    );
  }

  /// `Appeared`
  String get appeared {
    return Intl.message(
      'Appeared',
      name: 'appeared',
      desc: '',
      args: [],
    );
  }

  /// `Biography has changed`
  String get biography_has_changed {
    return Intl.message(
      'Biography has changed',
      name: 'biography_has_changed',
      desc: '',
      args: [],
    );
  }

  /// `Movie`
  String get movie {
    return Intl.message(
      'Movie',
      name: 'movie',
      desc: '',
      args: [],
    );
  }

  /// `Series`
  String get series {
    return Intl.message(
      'Series',
      name: 'series',
      desc: '',
      args: [],
    );
  }

  /// `Crop image`
  String get crop_image {
    return Intl.message(
      'Crop image',
      name: 'crop_image',
      desc: '',
      args: [],
    );
  }

  /// `Cast`
  String get cast {
    return Intl.message(
      'Cast',
      name: 'cast',
      desc: '',
      args: [],
    );
  }

  /// `Crew`
  String get crew {
    return Intl.message(
      'Crew',
      name: 'crew',
      desc: '',
      args: [],
    );
  }

  /// `Acting art`
  String get cast_actor_details {
    return Intl.message(
      'Acting art',
      name: 'cast_actor_details',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get crew_actor_details {
    return Intl.message(
      'Other',
      name: 'crew_actor_details',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get date_of_birth {
    return Intl.message(
      'Date of Birth',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Place of Birth`
  String get place_of_birth {
    return Intl.message(
      'Place of Birth',
      name: 'place_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `You can cancel your subscription at any time in your Play Store`
  String get you_can_cancel_your_subscription_at_any_time_in_your_play_store {
    return Intl.message(
      'You can cancel your subscription at any time in your Play Store',
      name: 'you_can_cancel_your_subscription_at_any_time_in_your_play_store',
      desc: '',
      args: [],
    );
  }

  /// `This purchase can only be used on Android system. Payment will be charged to your Google Play Store account at confirmation of purchase. Subscription automatically renews under the same terms unless renewal is turned off at least 24 hours before the end of the current period. The renewal fee is debited from your account according to the chosen tariff. You can cancel the subscription at any time in the settings of your Google Play Store, while you will be able to enjoy all the benefits of the subscription until the end of the paid period.`
  String get this_purchase_can_only_be_used_on_android_system {
    return Intl.message(
      'This purchase can only be used on Android system. Payment will be charged to your Google Play Store account at confirmation of purchase. Subscription automatically renews under the same terms unless renewal is turned off at least 24 hours before the end of the current period. The renewal fee is debited from your account according to the chosen tariff. You can cancel the subscription at any time in the settings of your Google Play Store, while you will be able to enjoy all the benefits of the subscription until the end of the paid period.',
      name: 'this_purchase_can_only_be_used_on_android_system',
      desc: '',
      args: [],
    );
  }

  /// `There are ads`
  String get there_are_ads {
    return Intl.message(
      'There are ads',
      name: 'there_are_ads',
      desc: '',
      args: [],
    );
  }

  /// `No ads`
  String get no_ads {
    return Intl.message(
      'No ads',
      name: 'no_ads',
      desc: '',
      args: [],
    );
  }

  /// `Creators`
  String get creators {
    return Intl.message(
      'Creators',
      name: 'creators',
      desc: '',
      args: [],
    );
  }

  /// `Release`
  String get release {
    return Intl.message(
      'Release',
      name: 'release',
      desc: '',
      args: [],
    );
  }

  /// `Last show`
  String get last_show {
    return Intl.message(
      'Last show',
      name: 'last_show',
      desc: '',
      args: [],
    );
  }

  /// `Last episode`
  String get last_episode {
    return Intl.message(
      'Last episode',
      name: 'last_episode',
      desc: '',
      args: [],
    );
  }

  /// `Next episode`
  String get next_episode {
    return Intl.message(
      'Next episode',
      name: 'next_episode',
      desc: '',
      args: [],
    );
  }

  /// `Total seasons`
  String get total_seasons {
    return Intl.message(
      'Total seasons',
      name: 'total_seasons',
      desc: '',
      args: [],
    );
  }

  /// `Total episodes`
  String get total_episodes {
    return Intl.message(
      'Total episodes',
      name: 'total_episodes',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Empty. Write a review first!`
  String get empty_write_review_first {
    return Intl.message(
      'Empty. Write a review first!',
      name: 'empty_write_review_first',
      desc: '',
      args: [],
    );
  }

  /// `You can't write reviews here yet.`
  String get you_cannot_write_reviews_here_yet {
    return Intl.message(
      'You can\'t write reviews here yet.',
      name: 'you_cannot_write_reviews_here_yet',
      desc: '',
      args: [],
    );
  }

  /// `Write your review`
  String get write_your_review {
    return Intl.message(
      'Write your review',
      name: 'write_your_review',
      desc: '',
      args: [],
    );
  }

  /// `Person`
  String get person {
    return Intl.message(
      'Person',
      name: 'person',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `episodes`
  String get episodes_v1 {
    return Intl.message(
      'episodes',
      name: 'episodes_v1',
      desc: '',
      args: [],
    );
  }

  /// `Episodes`
  String get episodes_v2 {
    return Intl.message(
      'Episodes',
      name: 'episodes_v2',
      desc: '',
      args: [],
    );
  }

  /// `Trailer`
  String get trailer {
    return Intl.message(
      'Trailer',
      name: 'trailer',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Favorite and not watched`
  String get favorite_and_not_watched {
    return Intl.message(
      'Favorite and not watched',
      name: 'favorite_and_not_watched',
      desc: '',
      args: [],
    );
  }

  /// `Watched`
  String get watched {
    return Intl.message(
      'Watched',
      name: 'watched',
      desc: '',
      args: [],
    );
  }

  /// `Not watched`
  String get not_watched {
    return Intl.message(
      'Not watched',
      name: 'not_watched',
      desc: '',
      args: [],
    );
  }

  /// `With genres`
  String get with_genres {
    return Intl.message(
      'With genres',
      name: 'with_genres',
      desc: '',
      args: [],
    );
  }

  /// `Without genres`
  String get without_genres {
    return Intl.message(
      'Without genres',
      name: 'without_genres',
      desc: '',
      args: [],
    );
  }

  /// `Genres`
  String get genres {
    return Intl.message(
      'Genres',
      name: 'genres',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `Before`
  String get before {
    return Intl.message(
      'Before',
      name: 'before',
      desc: '',
      args: [],
    );
  }

  /// `Sort by`
  String get sort_by {
    return Intl.message(
      'Sort by',
      name: 'sort_by',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Vote average`
  String get vote_average {
    return Intl.message(
      'Vote average',
      name: 'vote_average',
      desc: '',
      args: [],
    );
  }

  /// `Movies`
  String get movies {
    return Intl.message(
      'Movies',
      name: 'movies',
      desc: '',
      args: [],
    );
  }

  /// `TV Shows`
  String get tv_shows {
    return Intl.message(
      'TV Shows',
      name: 'tv_shows',
      desc: '',
      args: [],
    );
  }

  /// `TV Show`
  String get tv_show {
    return Intl.message(
      'TV Show',
      name: 'tv_show',
      desc: '',
      args: [],
    );
  }

  /// `People`
  String get people {
    return Intl.message(
      'People',
      name: 'people',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `more`
  String get more {
    return Intl.message(
      'more',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `less`
  String get less {
    return Intl.message(
      'less',
      name: 'less',
      desc: '',
      args: [],
    );
  }

  /// `Production companies`
  String get production_companies {
    return Intl.message(
      'Production companies',
      name: 'production_companies',
      desc: '',
      args: [],
    );
  }

  /// `Production countries`
  String get production_countries {
    return Intl.message(
      'Production countries',
      name: 'production_countries',
      desc: '',
      args: [],
    );
  }

  /// `External sources`
  String get external_sources {
    return Intl.message(
      'External sources',
      name: 'external_sources',
      desc: '',
      args: [],
    );
  }

  /// `Media`
  String get media {
    return Intl.message(
      'Media',
      name: 'media',
      desc: '',
      args: [],
    );
  }

  /// `Seasons`
  String get seasons {
    return Intl.message(
      'Seasons',
      name: 'seasons',
      desc: '',
      args: [],
    );
  }

  /// `Similar`
  String get similar {
    return Intl.message(
      'Similar',
      name: 'similar',
      desc: '',
      args: [],
    );
  }

  /// `Recommendation`
  String get recommendation {
    return Intl.message(
      'Recommendation',
      name: 'recommendation',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get popular {
    return Intl.message(
      'Popular',
      name: 'popular',
      desc: '',
      args: [],
    );
  }

  /// `Top rated`
  String get top_rated {
    return Intl.message(
      'Top rated',
      name: 'top_rated',
      desc: '',
      args: [],
    );
  }

  /// `Now playing`
  String get now_playing {
    return Intl.message(
      'Now playing',
      name: 'now_playing',
      desc: '',
      args: [],
    );
  }

  /// `Keywords`
  String get keywords {
    return Intl.message(
      'Keywords',
      name: 'keywords',
      desc: '',
      args: [],
    );
  }

  /// `Biography`
  String get biography {
    return Intl.message(
      'Biography',
      name: 'biography',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get view_all {
    return Intl.message(
      'View All',
      name: 'view_all',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Release Date`
  String get release_date {
    return Intl.message(
      'Release Date',
      name: 'release_date',
      desc: '',
      args: [],
    );
  }

  /// `Reset filters`
  String get reset_filters {
    return Intl.message(
      'Reset filters',
      name: 'reset_filters',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `not chosen`
  String get not_chosen {
    return Intl.message(
      'not chosen',
      name: 'not_chosen',
      desc: '',
      args: [],
    );
  }

  /// `About me`
  String get about_me {
    return Intl.message(
      'About me',
      name: 'about_me',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enter_your_name {
    return Intl.message(
      'Enter your name',
      name: 'enter_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter movie, TV show, person`
  String get enter_movie_tv_show_person {
    return Intl.message(
      'Enter movie, TV show, person',
      name: 'enter_movie_tv_show_person',
      desc: '',
      args: [],
    );
  }

  /// `Action`
  String get action {
    return Intl.message(
      'Action',
      name: 'action',
      desc: '',
      args: [],
    );
  }

  /// `Adventure`
  String get adventure {
    return Intl.message(
      'Adventure',
      name: 'adventure',
      desc: '',
      args: [],
    );
  }

  /// `Animation`
  String get animation {
    return Intl.message(
      'Animation',
      name: 'animation',
      desc: '',
      args: [],
    );
  }

  /// `Comedy`
  String get comedy {
    return Intl.message(
      'Comedy',
      name: 'comedy',
      desc: '',
      args: [],
    );
  }

  /// `Crime`
  String get crime {
    return Intl.message(
      'Crime',
      name: 'crime',
      desc: '',
      args: [],
    );
  }

  /// `Documentary`
  String get documentary {
    return Intl.message(
      'Documentary',
      name: 'documentary',
      desc: '',
      args: [],
    );
  }

  /// `Drama`
  String get drama {
    return Intl.message(
      'Drama',
      name: 'drama',
      desc: '',
      args: [],
    );
  }

  /// `Family`
  String get family {
    return Intl.message(
      'Family',
      name: 'family',
      desc: '',
      args: [],
    );
  }

  /// `Fantasy`
  String get fantasy {
    return Intl.message(
      'Fantasy',
      name: 'fantasy',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Horror`
  String get horror {
    return Intl.message(
      'Horror',
      name: 'horror',
      desc: '',
      args: [],
    );
  }

  /// `Music`
  String get music {
    return Intl.message(
      'Music',
      name: 'music',
      desc: '',
      args: [],
    );
  }

  /// `Mystery`
  String get mystery {
    return Intl.message(
      'Mystery',
      name: 'mystery',
      desc: '',
      args: [],
    );
  }

  /// `Romance`
  String get romance {
    return Intl.message(
      'Romance',
      name: 'romance',
      desc: '',
      args: [],
    );
  }

  /// `Science Fiction`
  String get science_fiction {
    return Intl.message(
      'Science Fiction',
      name: 'science_fiction',
      desc: '',
      args: [],
    );
  }

  /// `TV Movie`
  String get tv_movie {
    return Intl.message(
      'TV Movie',
      name: 'tv_movie',
      desc: '',
      args: [],
    );
  }

  /// `Thriller`
  String get thriller {
    return Intl.message(
      'Thriller',
      name: 'thriller',
      desc: '',
      args: [],
    );
  }

  /// `War`
  String get war {
    return Intl.message(
      'War',
      name: 'war',
      desc: '',
      args: [],
    );
  }

  /// `Western`
  String get western {
    return Intl.message(
      'Western',
      name: 'western',
      desc: '',
      args: [],
    );
  }

  /// `Action & Adventure`
  String get action_and_adventure {
    return Intl.message(
      'Action & Adventure',
      name: 'action_and_adventure',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get news {
    return Intl.message(
      'News',
      name: 'news',
      desc: '',
      args: [],
    );
  }

  /// `Kids`
  String get kids {
    return Intl.message(
      'Kids',
      name: 'kids',
      desc: '',
      args: [],
    );
  }

  /// `Reality`
  String get reality {
    return Intl.message(
      'Reality',
      name: 'reality',
      desc: '',
      args: [],
    );
  }

  /// `Sci-Fi & Fantasy`
  String get sciFiAndFantasy {
    return Intl.message(
      'Sci-Fi & Fantasy',
      name: 'sciFiAndFantasy',
      desc: '',
      args: [],
    );
  }

  /// `Soap`
  String get soap {
    return Intl.message(
      'Soap',
      name: 'soap',
      desc: '',
      args: [],
    );
  }

  /// `Talk`
  String get talk {
    return Intl.message(
      'Talk',
      name: 'talk',
      desc: '',
      args: [],
    );
  }

  /// `War & Politics`
  String get war_and_politics {
    return Intl.message(
      'War & Politics',
      name: 'war_and_politics',
      desc: '',
      args: [],
    );
  }

  /// `Premier`
  String get premier {
    return Intl.message(
      'Premier',
      name: 'premier',
      desc: '',
      args: [],
    );
  }

  /// `Theatrical (limited)`
  String get theatrical_limited {
    return Intl.message(
      'Theatrical (limited)',
      name: 'theatrical_limited',
      desc: '',
      args: [],
    );
  }

  /// `Theatrical`
  String get theatrical {
    return Intl.message(
      'Theatrical',
      name: 'theatrical',
      desc: '',
      args: [],
    );
  }

  /// `Digital`
  String get digital {
    return Intl.message(
      'Digital',
      name: 'digital',
      desc: '',
      args: [],
    );
  }

  /// `Physical`
  String get physical {
    return Intl.message(
      'Physical',
      name: 'physical',
      desc: '',
      args: [],
    );
  }

  /// `TV`
  String get tv {
    return Intl.message(
      'TV',
      name: 'tv',
      desc: '',
      args: [],
    );
  }

  /// `Popularity asc`
  String get popularity_asc {
    return Intl.message(
      'Popularity asc',
      name: 'popularity_asc',
      desc: '',
      args: [],
    );
  }

  /// `Popularity desc`
  String get popularity_desc {
    return Intl.message(
      'Popularity desc',
      name: 'popularity_desc',
      desc: '',
      args: [],
    );
  }

  /// `Release date asc`
  String get release_date_asc {
    return Intl.message(
      'Release date asc',
      name: 'release_date_asc',
      desc: '',
      args: [],
    );
  }

  /// `Release date desc`
  String get release_date_desc {
    return Intl.message(
      'Release date desc',
      name: 'release_date_desc',
      desc: '',
      args: [],
    );
  }

  /// `Revenue asc`
  String get revenue_asc {
    return Intl.message(
      'Revenue asc',
      name: 'revenue_asc',
      desc: '',
      args: [],
    );
  }

  /// `Revenue desc`
  String get revenue_desc {
    return Intl.message(
      'Revenue desc',
      name: 'revenue_desc',
      desc: '',
      args: [],
    );
  }

  /// `Primary release date asc`
  String get primary_release_date_asc {
    return Intl.message(
      'Primary release date asc',
      name: 'primary_release_date_asc',
      desc: '',
      args: [],
    );
  }

  /// `Primary release date desc`
  String get primary_release_date_desc {
    return Intl.message(
      'Primary release date desc',
      name: 'primary_release_date_desc',
      desc: '',
      args: [],
    );
  }

  /// `Original title asc`
  String get original_title_asc {
    return Intl.message(
      'Original title asc',
      name: 'original_title_asc',
      desc: '',
      args: [],
    );
  }

  /// `Original title desc`
  String get original_title_desc {
    return Intl.message(
      'Original title desc',
      name: 'original_title_desc',
      desc: '',
      args: [],
    );
  }

  /// `Vote average asc`
  String get vote_average_asc {
    return Intl.message(
      'Vote average asc',
      name: 'vote_average_asc',
      desc: '',
      args: [],
    );
  }

  /// `Vote average desc`
  String get vote_average_desc {
    return Intl.message(
      'Vote average desc',
      name: 'vote_average_desc',
      desc: '',
      args: [],
    );
  }

  /// `Vote count asc`
  String get vote_count_asc {
    return Intl.message(
      'Vote count asc',
      name: 'vote_count_asc',
      desc: '',
      args: [],
    );
  }

  /// `Vote count desc`
  String get vote_count_desc {
    return Intl.message(
      'Vote count desc',
      name: 'vote_count_desc',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Search result`
  String get search_result {
    return Intl.message(
      'Search result',
      name: 'search_result',
      desc: '',
      args: [],
    );
  }

  /// `Not found`
  String get not_found {
    return Intl.message(
      'Not found',
      name: 'not_found',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get sign_out {
    return Intl.message(
      'Sign Out',
      name: 'sign_out',
      desc: '',
      args: [],
    );
  }

  /// `Press again to exit app`
  String get press_again_to_exit_app {
    return Intl.message(
      'Press again to exit app',
      name: 'press_again_to_exit_app',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get no_data {
    return Intl.message(
      'No data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Complain`
  String get complain {
    return Intl.message(
      'Complain',
      name: 'complain',
      desc: '',
      args: [],
    );
  }

  /// `mins`
  String get mins {
    return Intl.message(
      'mins',
      name: 'mins',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Complaint text (optional)`
  String get text_of_complaint {
    return Intl.message(
      'Complaint text (optional)',
      name: 'text_of_complaint',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Sent successfully`
  String get sent_successfully {
    return Intl.message(
      'Sent successfully',
      name: 'sent_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Tagline`
  String get tagline {
    return Intl.message(
      'Tagline',
      name: 'tagline',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Send Request`
  String get send_request {
    return Intl.message(
      'Send Request',
      name: 'send_request',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Request has been sent`
  String get request_has_been_sent {
    return Intl.message(
      'Request has been sent',
      name: 'request_has_been_sent',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
