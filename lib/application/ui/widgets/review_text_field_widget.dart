import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../themes/app_colors.dart';
import 'text_field_widget.dart';

class ReviewTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function() sendReview;
  final bool isProgressSending;
  const ReviewTextFieldWidget({
    Key? key,
    required this.controller,
    required this.sendReview,
    required this.isProgressSending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 312,
          child: TextFieldWidget(
            controller: controller,
            hintText: S.of(context).write_your_review,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            enableSuggestions: true,
            maxLines: null,
            height: null,
          ),
        ),
        const Spacer(flex: 16),
        !isProgressSending
            ? IconButton(
                onPressed: sendReview,
                icon: const Icon(
                  Icons.send,
                  color: AppColors.colorSecondary,
                  size: 32,
                ),
              )
            : const RepaintBoundary(
                child: CircularProgressIndicator(
                  color: AppColors.colorSecondary,
                ),
              ),
      ],
    );
  }
}
