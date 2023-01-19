import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//constant color
const primaryColor = Color(0xFFE10C0E);
const secondaryColor = Color(0xFFE00D0D);
const mBackgroundColor = Color(0xFFFAFAFA);
const mGreyColor = Color(0xFFB4B0B0);
const mTitleColor = Color(0xFF333333);
const mSubtitleColor = Color(0xFF8E8E8E);
const mBorderColor = Color(0xFFE8E8F3);
const mFillColor = Color(0xFFFFFFFF);
const mCardTitleColor = Color(0xFFE00D0D);
const mCardSubtitleColor = mTitleColor;

const defaultPadding = 16.0;

//constant Style
var titleStyle = GoogleFonts.inter(fontWeight: FontWeight.w600);

var titleLongStyle =
    GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w900);

// Style for Home Profile Header
var mWelcomeTitleStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w500, fontSize: 10, color: mSubtitleColor);
var mUsernameTitleStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w700, fontSize: 12, color: mTitleColor);
var lawyerNameTextStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w700, fontSize: 12, color: mTitleColor);
var specialistTextStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w500, fontSize: 10, color: mSubtitleColor);
var appbarTextStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w500, fontSize: 15, color: mTitleColor);

// Text Style for Lawyer Category
var lawyerCategoryTextStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w500, fontSize: 15, color: Color(0xFF677294));

// Text Style for Lawyer Card
var lawyerNameStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w500, fontSize: 20, color: mTitleColor);
var priceTextStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w400, fontSize: 15, color: mSubtitleColor);
var priceNumberTextStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w500, fontSize: 15, color: Color(0xFF12908f));

//Text Style Detail Lawyer
var titleTextStyle = GoogleFonts.rubik(
    fontWeight: FontWeight.w500, fontSize: 16, color: mTitleColor);
var subTitleTextStyle = GoogleFonts.poppins(
    fontWeight: FontWeight.w400, fontSize: 10, color: mSubtitleColor);
var lawyerCategoryStyle = GoogleFonts.poppins(
    fontWeight: FontWeight.w400, fontSize: 10, color: mSubtitleColor);

//Text Style for Detail Order
var tableColumHeader = GoogleFonts.poppins(
    fontWeight: FontWeight.w600, fontSize: 15, color: mTitleColor);

var tableCellText = GoogleFonts.poppins(
    fontWeight: FontWeight.w500, fontSize: 12, color: mTitleColor);
