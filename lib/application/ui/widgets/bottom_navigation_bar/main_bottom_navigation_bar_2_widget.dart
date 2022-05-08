import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/main/main_view_model.dart';
import '../../themes/app_colors.dart';

class MainBottomNavigationBar2Widget extends StatelessWidget {
  const MainBottomNavigationBar2Widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainViewModel>();
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: model.currentTabIndex,
      selectedItemColor: AppColors.colorSecondary,
      unselectedItemColor: AppColors.colorMainText,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: AppColors.colorPrimary,
      onTap: (index) => model.setCurrentTabIndex(index, context),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Person',
        ),
      ],
    );
  }
}
