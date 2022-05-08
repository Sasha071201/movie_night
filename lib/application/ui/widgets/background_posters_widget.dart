import 'package:flutter/material.dart';

import '../../resources/resources.dart';

class BackgroundPostersWidget extends StatelessWidget {
  final Widget child;
  const BackgroundPostersWidget({
    Key? key,
    this.child = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: const BoxDecoration(color: Color(0xF215171F)),
            child: Image.asset(
              AppImages.loader,
              fit: BoxFit.cover,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
