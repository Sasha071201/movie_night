import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_night/application/constants/app_dimensions.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';

import '../../../resources/resources.dart';
import '../../themes/app_text_style.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: const BoxDecoration(
               color: Color(0xF215171F) 
              ),
              child: Image.asset(
                AppImages.loader,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.mediumPadding),
                child: Text(
                  'Movie Night',
                  style: AppTextStyle.header1.copyWith(
                    color: AppColors.colorMainText,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.largePadding),
              const _LoadingWidget(),
            ],
          ),
        ],
      ),
    );
  }
}

class _LoadingWidget extends StatefulWidget {
  const _LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<_LoadingWidget> {
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
    startTimer();
    super.didChangeDependencies();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 325), () {
      _currentIndex != 2 ? _currentIndex++ : _currentIndex = 0;
      setState(() {});
      startTimer();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final container = Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: AppColors.colorSecondary,
        borderRadius: BorderRadius.circular(
          AppDimensions.radius15,
        ),
      ),
    );
    return SizedBox(
      height: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedAlign(
            alignment: Alignment(0, _currentIndex == 0 ? -1 : 0),
            duration: const Duration(milliseconds: 300),
            child: container,
          ),
          const SizedBox(width: AppDimensions.smallPadding),
          AnimatedAlign(
            alignment: Alignment(0, _currentIndex == 1 ? -1 : 0),
            duration: const Duration(milliseconds: 300),
            child: container,
          ),
          const SizedBox(width: AppDimensions.smallPadding),
          AnimatedAlign(
            alignment: Alignment(0, _currentIndex == 2 ? -1 : 0),
            duration: const Duration(milliseconds: 300),
            child: container,
          ),
        ],
      ),
    );
  }
}
