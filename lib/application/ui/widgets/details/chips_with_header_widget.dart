import 'package:flutter/material.dart';
import 'package:movie_night/application/utils/string_extension.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';
import '../action_chip_widget.dart';

class ChipsWithHeaderWidget extends StatelessWidget {
  final String title;
  final List<String>? data;
  final void Function(int index) onPressed;
  const ChipsWithHeaderWidget({
    Key? key,
    required this.title,
    required this.data,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data != null && data!.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyle.header3,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: data!
                      .asMap()
                      .map(
                        (index, data) => MapEntry(
                            index,
                            ActionChipWidget(
                              onPressed: () => onPressed(index),
                              child: Text(
                                data.capitalize(),
                                style: AppTextStyle.small.copyWith(
                                    color: AppColors.colorSecondaryText),
                              ),
                            )),
                      )
                      .values
                      .toList(),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
