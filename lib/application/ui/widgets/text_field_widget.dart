import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../themes/app_colors.dart';
import '../themes/app_text_style.dart';

class TextFieldWidget extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final String? errorText;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool enableSuggestions;
  final int? maxLines;
  final bool obscureText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool expands;
  final double? width;
  final bool showSuffixIcon;
  final String? suffixIcon;

  const TextFieldWidget({
    Key? key,
    this.labelText,
    required this.hintText,
    this.errorText,
    required this.textInputAction,
    required this.keyboardType,
    required this.enableSuggestions,
    required this.maxLines,
    this.obscureText = false,
    this.prefixIcon,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.fillColor,
    this.inputFormatters,
    this.maxLength,
    this.expands = false,
    this.width,
    this.showSuffixIcon = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width,
      child: TextField(
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        enableSuggestions: enableSuggestions,
        maxLines: maxLines,
        maxLength: maxLength,
        expands: expands,
        obscureText: obscureText,
        // obscuringCharacter: '*',
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: AppTextStyle.medium,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          fillColor: fillColor ?? AppColors.colorBackground,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 50.01, minHeight: 41),
          suffixIcon: showSuffixIcon
              ? Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: SvgPicture.asset(
                    suffixIcon!,
                  ),
                )
              : null,
          suffixIconConstraints: showSuffixIcon
              ? const BoxConstraints(
                  maxHeight: 24,
                  maxWidth: 28,
                )
              : null,
          hintText: hintText,
          errorText: errorText,
          hintStyle: AppTextStyle.medium.copyWith(
            color: AppColors.colorSecondaryText,
          ),
        ),
      ),
    );
  }
}
