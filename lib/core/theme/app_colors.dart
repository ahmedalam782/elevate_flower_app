import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primerColor = Color(0xffD21E6A);

  // white
  static const Color whiteFE = Color(0xffFEFEFE);
  static const Color whiteFF = Color(0xffFFFFFF);
  static const Color whiteFD = Color(0xffFDFDFD);
  static const Color whiteFC = Color(0xffFCFCFC);
  static const Color whiteFB = Color(0xffFBFBFB);
  static const Color whiteFA = Color(0xffFAFAFA);
  static const Color whiteF9 = Color(0xffF9F9F9);

  // black
  static const Color black = Color(0xff000000);
  static const Color black32 = Color(0xff323232);
  static const Color blackCE = Color(0xffCECFD0);
  static const Color blackAE = Color(0xffAEAFB1);
  static const Color black85 = Color(0xff85878A);
  static const Color black5D = Color(0xff5D6063);
  static const Color black35 = Color(0xff35383C);
  static const Color black0C = Color(0xff0C1015); // base black
  static const Color black0A = Color(0xff0A0D12);
  static const Color black08 = Color(0xff080B0E);
  static const Color black06 = Color(0xff06080B);
  static const Color black04 = Color(0xff040507);
  static const Color black02 = Color(0xff020304);

  // grey
  static const Color gray53 = Color(0xff535353);
  static const Color grayCF = Color(0xffCFCFCF);
  static const Color grayA6 = Color(0xffA6A6A6);
  static const Color gray7D = Color(0xff7D7D7D);
  static const Color grayEA = Color(0xffEAEAEA);

  //transparent
  static const Color transparent = Color(0x00000000);

  // red
  static const Color redCC = Color(0xffCC1010);

  // green
  static const Color green0C = Color(0xff0CB359);

  // pink
  static const Color pinkF9 = Color(0xffF9ECF0);
  static const Color pinkF6 = Color(0xffF6D2E1);
  static const Color pinkF0 = Color(0xffF0B4CD);
  static const Color pinkE8 = Color(0xffE88EB4);
  static const Color pinkE1 = Color(0xffE1699C);
  static const Color pinkD9 = Color(0xffD94483);
  static const Color pinkAF = Color(0xffAF1958);
  static const Color pink8C = Color(0xff8C1447);
  static const Color pink7C = Color(0xffD7397C);
  static const Color pink69 = Color(0xff690F35);
  static const Color pink46 = Color(0xff460A23);
  static const Color pink2A = Color(0xff2A0615);

  static const LinearGradient primerGradient = LinearGradient(
    colors: [AppColors.primerColor, AppColors.primerColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient linearGradientBlack = LinearGradient(
    colors: [black, black],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 1.0],
  );
  static List<BoxShadow> shadowBox = [
    BoxShadow(
      color: black.withValues(alpha: 0.2),
      blurRadius: 4,
      spreadRadius: 0,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: black.withValues(alpha: 0.1),
      blurRadius: 1,
      spreadRadius: 0,
      offset: const Offset(0, 0),
    ),
  ];
}
