import 'package:flutter/cupertino.dart';
import 'package:movie_night/application/ui/widgets/vertical_widgets_with_header/vertical_view_all_widget.dart';

import '../../../../generated/l10n.dart';
import '../../../constants/app_dimensions.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';
import '../text_button_widget.dart';

class VerticalWidgetWithHeaderWidget<T> extends StatelessWidget {
  final String title;
  final int dataLength;
  final Widget Function(int index) itemBuilder;
  final void Function() onPressedViewAll;

  const VerticalWidgetWithHeaderWidget({
    Key? key,
    required this.title,
    required this.dataLength,
    required this.itemBuilder,
    required this.onPressedViewAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const maxLength = 10;
    final isLittleData = dataLength < maxLength;
    final length = isLittleData ? dataLength : maxLength;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.mediumPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: AppTextStyle.header3,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButtonWidget(
                child: Text(
                  S.of(context).view_all,
                  style: AppTextStyle.button.copyWith(
                    color: AppColors.colorSecondary,
                  ),
                ),
                onPressed: onPressedViewAll,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 210,
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.largePadding,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                Widget child = const SizedBox.shrink();
                if (isLittleData) {
                  child = itemBuilder(index);
                } else {
                  child = index != length - 1
                      ? itemBuilder(index)
                      : VerticalViewAllWidget(
                          width: 130,
                          height: 170,
                          onPressed: onPressedViewAll,
                        );
                }
                return Align(
                  alignment: Alignment.topCenter,
                  child: child,
                );
              }),
        ),
      ],
    );
  }
}
