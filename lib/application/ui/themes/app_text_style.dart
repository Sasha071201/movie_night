import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle get header1 => header1WithoutTheme.copyWith(
      color: AppTheme.dark.textTheme.bodyText2!.color);
  static TextStyle get header2 => header2WithoutTheme.copyWith(
      color: AppTheme.dark.textTheme.bodyText2!.color);
  static TextStyle get button => buttonWithoutTheme.copyWith(
      color: AppTheme.dark.textTheme.bodyText2!.color);
  static TextStyle get medium => mediumWithoutTheme.copyWith(
      color: AppTheme.dark.textTheme.bodyText2!.color);
  static TextStyle get small => smallWithoutTheme.copyWith(
      color: AppTheme.dark.textTheme.bodyText2!.color);
  static TextStyle get verySmall => verySmallWithoutTheme.copyWith(
      color: AppTheme.dark.textTheme.bodyText2!.color);
  static TextStyle get header3 => header3WithoutTheme.copyWith(
      color: AppTheme.dark.textTheme.bodyText2!.color);
  static TextStyle get subheader => subheaderWithoutTheme.copyWith(
      color: AppTheme.dark.textTheme.bodyText2!.color);
  static TextStyle get subheader2 => subheader2WithoutTheme.copyWith(
      color: AppTheme.dark.textTheme.bodyText2!.color);

  static final subheader2WithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 12,
  );

  static final subheaderWithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 12,
  );

  static final header3WithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 16,
  );

  static final verySmallWithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 6,
  );

  static final smallWithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 14,
  );

  static final mediumWithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 16,
  );

  static final buttonWithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 14,
  );

  static final header2WithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 24,
  );

  static final header1WithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 46,
  );
}
