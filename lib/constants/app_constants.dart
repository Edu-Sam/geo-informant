import 'package:flutter/material.dart';
import 'package:geoapp/models/hex_color.dart';

class AppConstants{

 // static final Color primaryColor=HexColor.fromHex("#D2EAF5");
  static final Color primaryColor=HexColor.fromHex("#113B08");
  static final Color secondaryColor=HexColor.fromHex("#4D86A0");
  static final Color thirdColor=HexColor.fromHex("#275D75");
  static final Color backgroundColor=HexColor.fromHex("F6F5F5");
  static final Color cartColor=HexColor.fromHex("547F92");
  static final Color redColor=HexColor.fromHex("#E91A1A");
  static final Color greenColor=HexColor.fromHex("#25B919");
  static final Color greyColor=HexColor.fromHex("#DADADA");
  static final Color negativeColor=HexColor.fromHex("#828282");
  static final Color greyNegativeColor=HexColor.fromHex("#C4C4C4");
  static final Color navigationBarColor=HexColor.fromHex("#F8F8F8EB").withOpacity(0.92);
  static final Color negativeTextColor=HexColor.fromHex("#828282");
  static const double dialogBorderRadius=8.0;
  static const double widget_height1=48;
  static const width_offset=1;
  static const height_offset=1;

  static const double base_width=375.0;   ///Iphone 11 Pro
  static const double tablet_base_width=600.0; /// Tablets

  static const double horizontal_margin=16.0;
  static const double vertical_margin=20.0;

  final kTextStyleMedium = const TextStyle(
    color: Color(0xFF275D75),
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  final kTextStyleMediumLight = const TextStyle(
    color: Color(0xFF275D75),
    fontSize: 12.8,
    fontWeight: FontWeight.w400,
  );
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xFF000A68), Color(0xFF00C4EE)],
  ).createShader(Rect.fromLTRB(0.0, 0.0, 250.0, 70.0));

  static bool isBigger(double screenSize){
    if(screenSize > base_width){
      return true;
    }

    else{
      return false;
    }

  }

  static bool isBigger600(double screenSize){
    if(screenSize > base_width){
      return true;
    }

    else{
      return false;
    }
  }

  static bool isBigger375(double screenSize){
    if(screenSize > base_width-1){
      return true;
    }

    else{
      return false;
    }
  }


  static double getScaleFactor(double screenSize) {
    if (isBigger375(screenSize)) {
      return 1;
    }

    else {
      return (screenSize/base_width);
      //return 0.8;
    }
  }
}