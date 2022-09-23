import 'package:flutter/material.dart';
import 'package:movie_night/generated/l10n.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';

class TaglineWidget extends StatelessWidget {
  final String tagline;
  const TaglineWidget({
    Key? key,
    required this.tagline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tagline.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).tagline,
                style: AppTextStyle.header3,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SelectableText(
                  tagline,
                  style: AppTextStyle.small.copyWith(color: AppColors.colorSecondaryText),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
