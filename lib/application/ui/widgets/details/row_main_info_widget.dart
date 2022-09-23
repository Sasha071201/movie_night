import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';

class RowMainInfoData {
  final IconData icon;
  final String title;
  RowMainInfoData({
    required this.icon,
    required this.title,
  });
}

class RowMainInfoWidget extends StatelessWidget {
  final List<RowMainInfoData> data;
  const RowMainInfoWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: data
            .map(
              (data) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    data.icon,
                    color: AppColors.colorSecondary,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: SelectableText(
                      data.title,
                      style: AppTextStyle.small,
                    ),
                  ),
                ],
              ),
            )
            .toList());
  }
}
