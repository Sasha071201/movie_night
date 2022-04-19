import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AppGridView extends StatelessWidget {
  final Widget Function(dynamic context, dynamic index) itemBuilder;
  final int itemCount;
  const AppGridView({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int crossAxisCount = (size.width / 138).round();
    return AlignedGridView.count(
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      crossAxisCount: crossAxisCount,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
