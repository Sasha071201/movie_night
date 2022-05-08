import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';

class CustomScrollbarWidget extends StatefulWidget {
  final BoxScrollView Function(ScrollController controller) builder;
  const CustomScrollbarWidget({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  State<CustomScrollbarWidget> createState() => _CustomScrollbarWidgetState();
}

class _CustomScrollbarWidgetState extends State<CustomScrollbarWidget> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: DraggableScrollbar(
          heightScrollThumb: 20,
          backgroundColor: AppColors.colorMainText,
          padding: const EdgeInsets.only(right: 4),
          scrollThumbBuilder: _scrollThumbBuilder,
          child: widget.builder(controller),
          controller: controller,
        ),
      );

  Widget _scrollThumbBuilder(
    Color backgroundColor,
    Animation<double> thumbAnimation,
    Animation<double> labelAnimation,
    double height, {
    BoxConstraints? labelConstraints,
    Text? labelText,
  }) =>
      Container(
        color: backgroundColor,
        height: height,
        width: 14,
      );
}
