import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/main/main_view_model.dart';
import '../../themes/app_colors.dart';

class MainBottomNavigationBarWidget extends StatelessWidget {
  const MainBottomNavigationBarWidget({
    Key? key,
  }) : super(key: key);

  static final rawButtons = <_BottomBarItemFactory>[
    _BottomBarItemFactory(icon: Icons.home),
    _BottomBarItemFactory(icon: Icons.search),
    _BottomBarItemFactory(icon: Icons.favorite),
    _BottomBarItemFactory(icon: Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainViewModel>();
    final currentIndex = model.currentTabIndex;
    final buttons = rawButtons
        .asMap()
        .map(
          (index, value) => MapEntry(
            index,
            value.build(index, currentIndex,
                () => model.setCurrentTabIndex(index, context)),
          ),
        )
        .values
        .toList();
    return BottomAppBar(
      color: AppColors.colorPrimary,
      child: SizedBox(
        height: 56,
        width: rawButtons.length * 168,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 12),
            Flexible(flex: 168, child: buttons[0]),
            Flexible(flex: 168, child: buttons[1]),
            Flexible(flex: 168, child: buttons[2]),
            Flexible(flex: 168, child: buttons[3]),
            const Spacer(flex: 12),
          ],
        ),
      ),
    );
  }
}

class _BottomBarItemFactory {
  final IconData icon;

  _BottomBarItemFactory({
    required this.icon,
  });

  Widget build(int index, int currentIndex, void Function() onTap) {
    final bool isSelected = index == currentIndex;
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Icon(
          icon,
          color:
              isSelected ? AppColors.colorSecondary : AppColors.colorMainText,
        ),
      ),
    );
  }
}
