import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';



class CompanyColors {
  const CompanyColors._();

  const CompanyColors(); // this basically makes it so you can instantiate this class

  static const int _primaryPrimaryValue = 0xff535353;
  static const Map<int, Color> primaryColorList = const <int, Color>{
    0: const Color(0xffffffff),
    50: const Color(0xffE7E7E7),
    100: const Color(0xffC2C2C2),
    200: const Color(0xff9A9A9A),
    300: const Color(0xff727272),
    400: const Color(_primaryPrimaryValue),
    500: const Color(0xff353535),
    600: const Color(0xff303030),
    700: const Color(0xff282828),
    800: const Color(0xff222222),
    900: const Color(0xff161616)
  };

  static const int _accentPrimaryValue = 0xffFABE15;
  static const Map<int, Color> accentColorList = const <int, Color>{
    50: const Color(0xffFEF7E3),
    100: const Color(0xffFEECB9),
    200: const Color(0xffFDDF8A),
    300: const Color(0xffFCD25B),
    400: const Color(0xffFBC838),
    500: const Color(_accentPrimaryValue),
    600: const Color(0xffF9B812),
    700: const Color(0xffF9AF0F),
    800: const Color(0xffF8A70C),
    900: const Color(0xffF69906)
  };

  static const MaterialColor primary = MaterialColor(
    _primaryPrimaryValue,
    primaryColorList,
  );

  static const MaterialColor accent = MaterialColor(
    _accentPrimaryValue,
    accentColorList,
  );
}

//Colors
Color systemPrimaryColor = CompanyColors.primary[500];
Color systemAccentColor = CompanyColors.accent[500];

const Color systemDarkerRedColor = Color(0xffc00811);
const Color systemBlackTextColor = Color(0xff1f2020);
const Color systemGoldButtonColor = Color(0xfffcbf12);
const Color systemDarkerGreenColor = Color(0xff157f41);
const Color systemDividerColor = Color(0xffe1e1e1);
const Color black54 = Colors.black54;
const Color facebookColor = Color(0xff3b5998);
const Color gplusColor = Color(0xffd34836);
const Color systemRedColor = Color(0xffd81920);
const Color systemGreyColor = Color(0xffe7e7e7);
const Color systemDarkerGreyColor = Color(0xffcecece);
const Color systemDarkestGreyColor = Color(0xffa6a6a6);
const Color systemGreenColor = Color(0xff008643);
const Color systemLightBlueColor = Color(0xFF00B0FF);
const Color systemLightGreenColor = Color(0xff157F41);
const Color systemLighterGreyColor = Color(0xfff2f5f7);
const Color systemLightGoldColor = Color(0xfffae268);
const Color systemGoldColor = Color(0xffD5A00A);



