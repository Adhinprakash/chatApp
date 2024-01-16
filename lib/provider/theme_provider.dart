import 'package:firebase_demo/view/themes/darkmode.dart';
import 'package:firebase_demo/view/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeData _themeData=lightmode;

  ThemeData get themeData=>_themeData;

  bool get isDarkmode=>_themeData==darkMode;
   set themeData(ThemeData themeData){
    _themeData=themeData;
    notifyListeners();
   }

   void toggletheme(){
    if(_themeData==lightmode){
      themeData=darkMode;
    }else{
      themeData=lightmode;
    }
   }
}