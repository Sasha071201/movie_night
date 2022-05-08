import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../themes/app_colors.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color foregroundArcColor;
  final Color backgroundArcColor;
  final double percent;
  final double lineWidth;

  const CircularProgressIndicatorWidget({
    Key? key,
    required this.child,
    required this.width,
    required this.height,
    this.backgroundColor = AppColors.colorPrimary,
    this.foregroundArcColor = AppColors.colorSecondary, 
    this.backgroundArcColor = AppColors.colorSecondaryText,
    required this.percent,
    this.lineWidth = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          RepaintBoundary(
            child: CustomPaint(
              painter: _CircularProgressIndicatorPaint(
                backgroundColor: backgroundColor,
                backgroundArcColor: backgroundArcColor,
                foregroundArcColor: foregroundArcColor,
                percent: percent,
                lineWidth: lineWidth,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(lineWidth),
            child: Center(
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularProgressIndicatorPaint extends CustomPainter {
  final Color backgroundColor;
  final Color foregroundArcColor;
  final Color backgroundArcColor;
  final double lineWidth;
  final double percent;

  _CircularProgressIndicatorPaint({
    required this.backgroundColor,
    required this.foregroundArcColor,
    required this.backgroundArcColor,
    required this.lineWidth,
    required this.percent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawBackground(canvas, size);
    _drawBackgroundArc(canvas, size);
    _drawForegroundArc(canvas, size);
  }

  void _drawBackground(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, backgroundPaint);
  }

  void _drawForegroundArc(Canvas canvas, Size size) {
    final foregroundArcPaint = Paint()
      ..color = foregroundArcColor
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Offset(lineWidth / 2, lineWidth / 2) &
          Size(size.width - lineWidth, size.height - lineWidth),
      -pi / 2,
      pi * 2 * percent,
      false,
      foregroundArcPaint,
    );
  }

  void _drawBackgroundArc(Canvas canvas, Size size) {
    final backgroundArcPaint = Paint()
      ..color = backgroundArcColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Offset(lineWidth / 2, lineWidth / 2) &
          Size(size.width - lineWidth, size.height - lineWidth),
      pi * 2 * percent - (pi / 2),
      pi * 2 * (1.0 - percent),
      false,
      backgroundArcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
