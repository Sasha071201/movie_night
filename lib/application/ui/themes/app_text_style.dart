import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

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
  static TextStyle get header3 => header3WithoutTheme.copyWith(
      color: AppTheme.dark.textTheme.bodyText2!.color);
  static TextStyle get subheader => subheaderWithoutTheme.copyWith(
      color: AppTheme.dark.textTheme.bodyText2!.color);
  static TextStyle get subheader2 => subheader2WithoutTheme.copyWith(
      color: AppTheme.dark.textTheme.bodyText2!.color);

  static final subheader2WithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 9.sp,
  );

  static final subheaderWithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 9.sp,
  );

  static final header3WithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 13.sp,//maybe 12.sp
  );

  static final smallWithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 11.sp,//maybe 10.sp
  );

  static final mediumWithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 13.sp,//maybe 12.sp
  );

  static final buttonWithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 11.sp,//maybe 10.sp
  );

  static final header2WithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 18.sp,
  );

  static final header1WithoutTheme = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 36.sp,
  );
}
