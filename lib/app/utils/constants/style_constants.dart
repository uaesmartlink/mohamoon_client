import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
//constant color
  static const primaryColor = Color(0xFF830404);
  static const secondaryColor = Color(0xFFD30C0C);
  static const thirdlyColor = Color(0xFFE00D0D);
  static const iconsColor = Color(0xFF740303);
  static const mBackgroundColor = Color(0xFFFAFAFA);
  static const mGreyColor = Color(0xFFB4B0B0);
  static const mTitleColor = Color(0xFF333333);
  static const mSubtitleColor = Color(0xFF8E8E8E);
  static const mBorderColor = Color(0xFFE8E8F3);
  static const mFillColor = Color(0xFFFFFFFF);
  static const mCardTitleColor = Color(0xFFE00D0D);
  static const mCardSubtitleColor = mTitleColor;
  static const defaultPadding = 16.0;

//constant Style
  static var titleStyle = GoogleFonts.inter(fontWeight: FontWeight.w600);

  static var titleLongStyle =
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w900);

// Style for Home Profile Header
  static var mWelcomeTitleStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 10, color: mSubtitleColor);
  static var mUsernameTitleStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w700, fontSize: 12, color: mTitleColor);
  static var lawyerNameTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w700, fontSize: 12, color: mTitleColor);
  static var specialistTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 10, color: mSubtitleColor);
  static var appbarTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 15, color: mTitleColor);
  static var primaryTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 15, color: Color(0xFF7D1313));

// Text Style for Lawyer Category
  static var lawyerCategoryTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 15, color: Color(0xFF677294));

// Text Style for Lawyer Card
  static var lawyerNameStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 20, color: mTitleColor);
  static var priceTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w400, fontSize: 15, color: mSubtitleColor);
  static var priceNumberTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 15, color: Color(0xFF12908f));

//Text Style Detail Lawyer
  static var titleTextStyle = GoogleFonts.rubik(
      fontWeight: FontWeight.w500, fontSize: 16, color: mTitleColor);
  static var subTitleTextStyle = GoogleFonts.poppins(
      fontWeight: FontWeight.w400, fontSize: 10, color: mSubtitleColor);
  static var lawyerCategoryStyle = GoogleFonts.poppins(
      fontWeight: FontWeight.w400, fontSize: 10, color: mSubtitleColor);

//Text Style for Detail Order
  static var tableColumHeader = GoogleFonts.poppins(
      fontWeight: FontWeight.w600, fontSize: 15, color: mTitleColor);

  static var tableCellText = GoogleFonts.poppins(
      fontWeight: FontWeight.w500, fontSize: 12, color: mTitleColor);
}
