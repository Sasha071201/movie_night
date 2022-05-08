import 'package:flutter/material.dart';

import '../../themes/app_text_style.dart';
import '../text_more_widget.dart';

class LargeTextWithHeaderWidget extends StatelessWidget {
  final String header;
  final String overview;
  const LargeTextWithHeaderWidget({
    Key? key,
    required this.header,
    required this.overview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return overview.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                header,
                style: AppTextStyle.header3,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextMoreWidget(overview),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
