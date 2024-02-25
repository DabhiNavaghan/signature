import 'package:flutter/material.dart';

import 'color_code.dart';

final ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: primary),
  useMaterial3: true,
  scaffoldBackgroundColor: bgColor,
  appBarTheme: appBarTheme,
);

const AppBarTheme appBarTheme = AppBarTheme(backgroundColor: bgColor,elevation: 2);
