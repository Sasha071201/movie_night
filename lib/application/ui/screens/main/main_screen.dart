import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/screens/home/home_screen.dart';
import 'package:movie_night/application/ui/screens/profile/profile_screen.dart';
import 'package:movie_night/application/ui/screens/search/search_screen.dart';
import 'package:provider/provider.dart';

import '../../widgets/bottom_navigation_bar/main_bottom_navigation_bar_2_widget.dart';
import '../favorite/favotite_screen.dart';
import 'main_view_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<MainViewModel>().scaffoldKey = GlobalKey<ScaffoldState>();
    context.read<MainViewModel>().init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MainViewModel>();
    return WillPopScope(
      onWillPop: () => vm.onBackPressed(context),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child:  Scaffold(
          key: vm.scaffoldKey,
          body: const SafeArea(
            child: _BodyWidget(),
          ),
          bottomNavigationBar: const MainBottomNavigationBar2Widget(),
        ),
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
