import 'dart:io' show Platform;
import 'package:flutter/material.dart';

import 'icon_button_widget.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = Platform.isAndroid ? Icons.arrow_back_rounded : Icons.arrow_back_ios_new_rounded;
    return IconButtonWidget(
      icon: Icon(icon),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
