import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/screens/home/home_screen.dart';
import 'package:movie_night/application/ui/screens/profile/profile_screen.dart';
import 'package:movie_night/application/ui/screens/search/search_screen.dart';
import 'package:movie_night/application/ui/widgets/bottom_navigation_bar/main_bottom_navigation_bar_widget.dart';
import 'package:provider/provider.dart';

import '../favorite/favotite_screen.dart';
import 'main_view_model.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MainViewModel>();
    return WillPopScope(
      onWillPop: () => vm.onBackPressed(context),
      child: const Scaffold(
        body: SafeArea(
          child: _BodyWidget(),
        ),
        bottomNavigationBar: MainBottomNavigationBarWidget(),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    Key? key,
  }) : super(key: key);

  static const _screens = [
    HomeScreen(),
    SearchScreen(),
    FavoriteScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MainViewModel>();
    return IndexedStack(
      children: _screens,
      index: vm.currentTabIndex,
    );
  }
}
