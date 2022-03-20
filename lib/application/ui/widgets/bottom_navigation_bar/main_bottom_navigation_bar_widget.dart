import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            buttons[0],
            const Spacer(flex: 2),
            buttons[1],
            const Spacer(flex: 2),
            buttons[2],
            const Spacer(flex: 2),
            buttons[3],
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _BottomBarItemFactory {
  final IconData icon;
  final double? countRightX;
  final double? countTopY;
  final int? count;

  _BottomBarItemFactory({
    required this.icon,
    this.countRightX,
    this.countTopY,
    this.count,
  });

  Widget build(int index, int currentIndex, void Function() onTap) {
    final bool isSelected = index == currentIndex;
    final hasPositionAndCount =
        countRightX != null && countTopY != null && count != null;
    return SizedBox(
      width: hasPositionAndCount ? 26 : 24,
      height: 24,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppColors.colorSecondary
                  : AppColors.colorMainText,
            ),
            if (hasPositionAndCount)
              Positioned(
                top: countTopY,
                right: countRightX,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: AppColors.colorPrimary,
                    border: Border.all(color: AppColors.colorFFFFFF),
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: Center(
                    child: Text(
                      count! < 100 ? '$count' : '99',
                      style: const TextStyle(
                        color: AppColors.colorFFFFFF,
                        fontSize: 5,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
