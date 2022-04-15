import 'package:flutter/material.dart';

import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/application/ui/screens/filter/filter_view_model.dart';
import 'package:movie_night/application/ui/widgets/text_button_widget.dart';

import '../../../generated/l10n.dart';
import '../navigation/app_navigation.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_style.dart';

class FilterButtonWidget extends StatelessWidget {
  final FilterData data;
  final MediaType mediaType;
  final bool openFromMain;
  final Future<void> Function(Future<Object?> pushNamed) pushNamed;
  const FilterButtonWidget({
    Key? key,
    required this.data,
    required this.mediaType,
    required this.pushNamed,
    required this.openFromMain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButtonWidget(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.filter_alt,
            color: AppColors.colorSecondary,
          ),
          Text(
            S.of(context).filter,
            style: AppTextStyle.button.copyWith(
              color: AppColors.colorSecondary,
            ),
          ),
        ],
      ),
      onPressed: () =>
          pushNamed(Navigator.of(context).pushNamed(Screens.filter, arguments: [
        data,
        mediaType,
        openFromMain,
      ])),
    );
  }
}
