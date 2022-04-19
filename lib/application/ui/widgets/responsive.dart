import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  static double aspectRatio(BuildContext context, double aspectRatio) {
    final deviceAspectRatio = MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;
    final needAddAspectRatio = aspectRatio - deviceAspectRatio; 
    final result = needAddAspectRatio + deviceAspectRatio;
    return result;
  }

  // static bool isMobileSmall(BuildContext context) =>
  //     isMobile(context) && _aspectRatio ;

  // static bool isMobile(BuildContext context) =>
  //     isMobile(context) && MediaQuery.of(context).size.height <= 640;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop;
        } else if (constraints.maxWidth >= 650) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
