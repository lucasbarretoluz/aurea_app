import 'package:flutter/material.dart';

ThemeData lightTheme() {
  const ColorScheme defaultColors = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xffD81B60),
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xffF8BBD0),
    onPrimaryContainer: Color(0xff3D0017),
    secondary: Color(0xffFF6F61),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xffFFDAD6),
    onSecondaryContainer: Color(0xff3E1414),
    tertiary: Color(0xffEC407A),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xffFFD9E3),
    onTertiaryContainer: Color(0xff3E0019),
    error: Color(0xffBA1A1A),
    onError: Color(0xffffffff),
    errorContainer: Color(0xffFFDAD6),
    onErrorContainer: Color(0xff410002),
    outline: Color(0xffD1A5AA),
    background: Color(0xffFFF8F7),
    onBackground: Color(0xff2D1619),
    surface: Color(0xffFFFBFF),
    onSurface: Color(0xff2D1619),
    surfaceContainerHighest: Color(0xffF5E3E6),
    onSurfaceVariant: Color(0xff524245),
    inverseSurface: Color(0xff472B2E),
    onInverseSurface: Color(0xffFFEDEE),
    inversePrimary: Color(0xffFFB0CB),
    shadow: Color(0xff000000),
  );

  TextTheme basicTextTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'DDin',
        color: defaultColors.onSurface,
      ),
      headlineSmall: base.headlineMedium?.copyWith(
        fontSize: 18.0,
        fontFamily: 'DDin',
        color: defaultColors.onSurface,
      ),
      bodySmall: base.headlineSmall?.copyWith(
        fontSize: 12.0,
        fontFamily: 'DDin',
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontSize: 23.0,
        fontFamily: 'DDin',
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        color: defaultColors.onSurface,
        fontFamily: 'DDin',
        fontSize: 14,
      ),
    );
  }

  InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    helperMaxLines: 1,
    focusColor: defaultColors.onSurface,
    errorMaxLines: 1,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    floatingLabelAlignment: FloatingLabelAlignment.start,
    isDense: false,
    contentPadding: const EdgeInsets.all(0),
    isCollapsed: false,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: defaultColors.onSurface, width: 0.5),
    ),
    filled: false,
    alignLabelWithHint: false,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: defaultColors,
    textTheme: basicTextTheme(const TextTheme()),
    scaffoldBackgroundColor: const Color(0xffFFF8F7),
    inputDecorationTheme: inputDecorationTheme,
    fontFamily: 'DDin',
  );
}
