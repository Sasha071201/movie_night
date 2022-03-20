import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_dimensions.dart';
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
  final Color? cursorColor;
  final Color? textColor;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool expands;
  final double? width;
  final bool showSuffixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool showBorder;

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
    this.cursorColor,
    this.textColor,
    this.inputFormatters,
    this.maxLength,
    this.expands = false,
    this.width,
    this.showSuffixIcon = false,
    this.suffixIcon,
    this.focusNode,
    this.showBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final enableBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radius15),
      borderSide: showBorder
          ? const BorderSide(
              color: AppColors.colorFFFFFF,
            )
          : const BorderSide(),
    );
    return SizedBox(
      height: 50,
      width: width,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        enableSuggestions: enableSuggestions,
        maxLines: maxLines,
        maxLength: maxLength,
        expands: expands,
        cursorColor: cursorColor,
        obscureText: obscureText,
        // obscuringCharacter: '*',
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: AppTextStyle.medium.copyWith(color: textColor),
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          fillColor: fillColor ?? AppColors.colorPrimary,
          suffixIcon: showSuffixIcon ? suffixIcon : null,
          hintText: hintText,
          errorText: errorText,
          hintStyle: AppTextStyle.medium.copyWith(
            color: AppColors.colorSecondaryText,
          ),
          filled: true,
          enabledBorder: enableBorder,
          errorBorder: enableBorder.copyWith(
            borderSide: showBorder
                ? const BorderSide(
                    color: AppColors.colorError,
                  )
                : const BorderSide(),
          ),
          focusedBorder: enableBorder,
          focusedErrorBorder: enableBorder.copyWith(
            borderSide: showBorder
                ? const BorderSide(
                    color: AppColors.colorError,
                  )
                : const BorderSide(),
          ),
        ),
      ),
    );
  }
}
