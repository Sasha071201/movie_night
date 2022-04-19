import 'package:flutter/material.dart';

class InsetsBottomWidget extends StatelessWidget {
  const InsetsBottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final insetsBottom = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(height: insetsBottom == 0 ? 32 : insetsBottom + 16);
  }
}