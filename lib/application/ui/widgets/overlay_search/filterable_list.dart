import 'package:flutter/material.dart';

import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';

class FilterableList extends StatelessWidget {
  final List<dynamic> items;
  final Widget Function(
    List<dynamic> items,
    void Function(String) onItemTapped,
    void Function() onViewAllPressed,
  ) builderSuggestions;
  final void Function() onViewAllPressed;
  final void Function(dynamic) onItemTapped;
  final double maxListHeight;
  final Color? suggestionBackgroundColor;
  final bool loading;

  const FilterableList({
    Key? key,
    required this.items,
    required this.builderSuggestions,
    required this.onViewAllPressed,
    required this.onItemTapped,
    this.maxListHeight = 200,
    this.suggestionBackgroundColor,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: suggestionBackgroundColor,
      width: double.infinity,
      height: maxListHeight,
      child: loading
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.colorMainText,
            ))
          : items.isEmpty
              ? Material(
                color: Colors.transparent,
                child: Center(
                    child: Text(
                      'Not found',
                      style: AppTextStyle.header2,
                    ),
                  ),
              )
              : builderSuggestions(items, onItemTapped, onViewAllPressed),
    );
  }
}
