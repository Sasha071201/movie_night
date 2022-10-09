import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';

import '../../../../generated/l10n.dart';
import 'settings_view_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void didChangeDependencies() {
    context.read<SettingsViewModel>().init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.colorPrimary,
          leading: const BackButton(color: AppColors.colorSecondary),
          title: Text(
            S.of(context).settings,
            style: AppTextStyle.header3,
          ),
        ),
        body: const _BodyWidget(),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SettingsViewModel>();
    final settings = [
      SettingsData(
        title: '${S.of(context).allow_show_all} ${S.of(context).favorite_movies}',
        value: vm.isAllowShowFavoriteMovies,
        onChanged: (value) => vm.allowShowFavoriteMovies(),
      ),
      SettingsData(
        title: '${S.of(context).allow_show_all} ${S.of(context).favorite_tv_shows}',
        value: vm.isAllowShowFavoriteTvShows,
        onChanged: (value) => vm.allowShowFavoriteTvShows(),
      ),
      SettingsData(
        title: '${S.of(context).allow_show_all} ${S.of(context).favorites_and_not_watched_movies}',
        value: vm.isAllowShowFavoriteAndNotWatchedMovies,
        onChanged: (value) => vm.allowShowFavoriteAndNotWatchedMovies(),
      ),
      SettingsData(
        title:
            '${S.of(context).allow_show_all} ${S.of(context).favorites_and_have_not_watched_tv_shows}',
        value: vm.isAllowShowFavoriteAndNotWatchedTvShows,
        onChanged: (value) => vm.allowShowFavoriteAndNotWatchedTvShows(),
      ),
      SettingsData(
        title: '${S.of(context).allow_show_all} ${S.of(context).movies_you_have_watched}',
        value: vm.isAllowShowWatchedMovies,
        onChanged: (value) => vm.allowShowWatchedMovies(),
      ),
      SettingsData(
        title: '${S.of(context).allow_show_all} ${S.of(context).tv_show_you_have_watched}',
        value: vm.isAllowShowWatchedTvShows,
        onChanged: (value) => vm.allowShowWatchedTvShows(),
      ),
      SettingsData(
        title: '${S.of(context).allow_show_all} ${S.of(context).favorite_people}',
        value: vm.isAllowShowFavoriteActors,
        onChanged: (value) => vm.allowShowFavoriteActors(),
      ),
    ];

    return CustomScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 1),
              SettingsWithHeader(settings: settings),
            ],
          ),
        ),
      ],
    );
  }
}

class SettingsData {
  final String title;
  final bool value;
  final void Function(bool value) onChanged;

  const SettingsData({
    required this.title,
    required this.value,
    required this.onChanged,
  });
}

class SettingsWithHeader extends StatelessWidget {
  final List<SettingsData> settings;

  const SettingsWithHeader({
    Key? key,
    required this.settings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColors.colorPrimary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  S.of(context).social,
                  style: AppTextStyle.header3,
                ),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: AppColors.colorFFFFFF,
              ),
            ],
          ),
        ),
        ...settings.map((e) => _SettingsItemWidget(settings: e)),
      ],
    );
  }
}

class _SettingsItemWidget extends StatelessWidget {
  final SettingsData settings;

  const _SettingsItemWidget({
    Key? key,
    required this.settings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        settings.title,
        style: AppTextStyle.small,
      ),
      value: settings.value,
      onChanged: settings.onChanged,
      tileColor: AppColors.colorPrimary,
    );
  }
}
