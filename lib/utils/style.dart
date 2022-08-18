import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hermoso_store/utils/colors.dart';

const TextStyle kHermosoLogo =
    TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColor.kPrimaryColor);

TextStyle kMainText =
    GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold);

const TextStyle kDetailsTitleStyle = TextStyle(fontSize: 16, color:AppColor. kOffWhiteColor);

const TextStyle kDiscountStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color:  AppColor.kSecondaryColor,
    decoration: TextDecoration.lineThrough);

const TextStyle kDetailsDiscountStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColor.kSecondaryColor,
    decoration: TextDecoration.lineThrough);

const TextStyle kTitleCardStyle =
    TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold);
/*

RegExp kRegularExp = RegExp(
r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
.hasMatch(val);*/
