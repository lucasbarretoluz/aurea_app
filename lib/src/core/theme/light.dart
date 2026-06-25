import 'package:flutter/material.dart';

ThemeData lightTheme() {
  const ColorScheme defaultColors = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xffBDD9E1),
    onPrimary: Color(0xff1E4554),
    primaryContainer: Color(0xffBDD9E1),
    onPrimaryContainer: Color(0xff1E4554),
    secondary: Color(0xffE8E8E8),
    onSecondary: Color(0xff1E2A30),
    secondaryContainer: Color(0xffD4EBF2),
    onSecondaryContainer: Color(0xff1E4554),
    tertiary: Color(0xff5A9AAD),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xffD4EBF2),
    onTertiaryContainer: Color(0xff1A3D48),
    error: Color(0xffBA1A1A),
    onError: Color(0xffffffff),
    errorContainer: Color(0xffFFDAD6),
    onErrorContainer: Color(0xff410002),
    outline: Color(0xffA8C8D4),
    surface: Color(0xffFBFDFE),
    onSurface: Color(0xff1E2A30),
    surfaceContainerHighest: Color(0xffE8F2F6),
    onSurfaceVariant: Color(0xff323131),
    inverseSurface: Color(0xff2A3D45),
    onInverseSurface: Color(0xffEDF5F8),
    inversePrimary: Color(0xff9CC5D4),
    shadow: Color(0xff000000),
  );

  TextTheme basicTextTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Montserrat',
        color: defaultColors.onSurface,
      ),
      headlineSmall: base.headlineMedium?.copyWith(
        fontSize: 18.0,
        fontFamily: 'Montserrat',
        color: defaultColors.onSurface,
      ),
      bodySmall: base.headlineSmall?.copyWith(
        fontSize: 12.0,
        fontFamily: 'Montserrat',
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontSize: 23.0,
        fontFamily: 'Montserrat',
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        color: defaultColors.onSurface,
        fontFamily: 'Montserrat',
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
    scaffoldBackgroundColor: const Color(0xffF5FAFC),
    inputDecorationTheme: inputDecorationTheme,
    fontFamily: 'Montserrat',
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: defaultColors.primary,
        foregroundColor: defaultColors.onPrimary,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return defaultColors.onPrimary;
        }
        return defaultColors.outline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return defaultColors.primary;
        }
        return defaultColors.surfaceContainerHighest;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return defaultColors.primary;
        }
        return defaultColors.outline;
      }),
    ),
  );
}
