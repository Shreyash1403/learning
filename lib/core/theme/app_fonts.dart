import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  // Font Sizes
  static const double fontSizeSmall = 12.0;
  static const double fontSizeRegular = 14.0;
  static const double fontSizeMedium = 16.0;
  static const double fontSizeLarge = 18.0;
  static const double fontSizeXLarge = 20.0;
  static const double fontSizeXXLarge = 24.0;
  static const double fontSizeHeading = 28.0;

  // Font Weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // ============= Google Font Text Styles =============
  // Using Poppins (you can change to any Google Font)

  static TextStyle heading = GoogleFonts.poppins(
    fontSize: fontSizeHeading,
    fontWeight: bold,
  );

  static TextStyle title = GoogleFonts.poppins(
    fontSize: fontSizeXLarge,
    fontWeight: semiBold,
  );

  static TextStyle subtitle = GoogleFonts.poppins(
    fontSize: fontSizeMedium,
    fontWeight: medium,
  );

  static TextStyle body = GoogleFonts.poppins(
    fontSize: fontSizeRegular,
    fontWeight: regular,
  );

  static TextStyle caption = GoogleFonts.poppins(
    fontSize: fontSizeSmall,
    fontWeight: regular,
  );

  static TextStyle button = GoogleFonts.poppins(
    fontSize: fontSizeMedium,
    fontWeight: semiBold,
  );

  // ============= App-wide Theme Font =============
  // Use this in MaterialApp's theme
  static TextTheme get textTheme => GoogleFonts.poppinsTextTheme();
}
