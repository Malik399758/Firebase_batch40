
import 'package:firebase_batch40/views/theme_module/theme_define.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{


  ThemeData _themeData = lightTheme;

  // get

 ThemeData get themeData => _themeData;


  // set

  set setTheme(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }


  // toggle


  void toggleTheme(){
    print('Function Called here');
    if(_themeData == lightTheme){
      _themeData = darkTheme;
      print('Theme set to dark -------->$_themeData');
    }else{
      _themeData = lightTheme;
    }
    notifyListeners();
  }








}