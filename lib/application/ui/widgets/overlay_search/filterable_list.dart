import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/api_client/media_type.dart';

import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/entities/search/multi_search.dart';

class FilterableList extends StatelessWidget {
  final List<MultiSearchResult> items;
  final Widget Function(
    List<MultiSearchResult> items,
    void Function(int id, MediaType) onItemTapped,
    void Function() onViewAllPressed,
  ) builderSuggestions;
  final void Function() onViewAllPressed;
  final void Function(int id, MediaType) onItemTapped;
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
    final height = MediaQuery.of(context).size.height;
    return Container(
      color: suggestionBackgroundColor,
      width: double.infinity,
      height: height * 0.4,//maxListHeight,
      child: loading
          ? const Center(
              child: RepaintBoundary(
                child: CircularProgressIndicator(
                color: AppColors.colorMainText,
                          ),
              ))
          : items.isEmpty
              ? Material(
                color: Colors.transparent,
                child: Center(
                    child: Text(
                      S.of(context).not_found,
                      style: AppTextStyle.header2,
                    ),
                  ),
              )
              : builderSuggestions(items, onItemTapped, onViewAllPressed),
    );
  }
}
