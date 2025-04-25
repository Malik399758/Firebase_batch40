

import 'package:flutter/material.dart';

// Theme define for light theme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Colors.black87,
    secondary: Colors.grey
  )
);

// Theme define for dark theme
ThemeData darkTheme  =  ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.black87,
    primary: Colors.white,
    secondary: Colors.green
  )
);