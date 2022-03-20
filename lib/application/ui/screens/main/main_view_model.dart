import 'package:flutter/cupertino.dart';
import 'package:movie_night/application/ui/screens/home/home_view_model.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/dialog_widget.dart';
import 'package:provider/provider.dart';

class MainViewModel extends ChangeNotifier {
  DateTime? _currentBackPressTime;
  var _currentTabIndex = 0;

  int get currentTabIndex => _currentTabIndex;

  void setCurrentTabIndex(int value, BuildContext context) {
    _currentTabIndex = value;
    switch (value) {
      case 0:
        final vmHome = context.read<HomeViewModel>();
        vmHome.prepareCategory(vmHome.currentCategoryIndex, context);
        break;
      case 1:
        final vmHome = context.read<HomeViewModel>();
        vmHome.stopWorkingScreen(context);
        break;
      case 2:
        final vmHome = context.read<HomeViewModel>();
        vmHome.stopWorkingScreen(context);
        break;
      case 3:
        final vmHome = context.read<HomeViewModel>();
        vmHome.stopWorkingScreen(context);
        break;
    }
    notifyListeners();
  }

  Future<bool> onBackPressed(BuildContext context) {
    DateTime now = DateTime.now();
    const duration = Duration(seconds: 2);
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > duration) {
      _currentBackPressTime = now;
      DialogWidget.showSnackBar(
        context: context,
        content: Text(
          'Press again to exit app',
          style: AppTextStyle.medium.copyWith(
            color: AppColors.colorMainText,
          ),
        ),
        duration: duration,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
