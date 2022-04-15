import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_style.dart';
import 'elevated_button_widget.dart';

class AdultOnboardingWidget extends StatelessWidget {
  final Widget child;
  final bool show;
  final void Function() onPressed;

  const AdultOnboardingWidget({
    Key? key,
    required this.child,
    required this.show,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if(show)
        Container(
          width: double.infinity,
          color: AppColors.colorPrimary.withOpacity(0.9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '18+',
                style: AppTextStyle.header1.copyWith(
                  color: AppColors.colorError,
                ),
              ),
              ElevatedButtonWidget(
                child: Text(
                  S.of(context).next,
                  style: AppTextStyle.button.copyWith(
                    color: AppColors.colorError,
                  ),
                ),
                width: 100,
                enableBorder: true,
                onPressed: onPressed,
              ),
              const SizedBox(height: 8),
              ElevatedButtonWidget(
                child: Text(
                  S.of(context).back,
                  style: AppTextStyle.button.copyWith(
                    color: AppColors.colorMainText,
                  ),
                ),
                width: 100,
                enableBorder: true,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}