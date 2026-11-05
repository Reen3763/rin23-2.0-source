import 'package:alphtoolcoin/l10n/context_extensions.dart';
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:cupertino_ui/cupertino_ui.dart'
    show CupertinoPageTransitionsBuilder;

class AppTheme {
  // switch thumb icon
  static const WidgetStateProperty<Icon> switchThumbIcon =
      WidgetStateProperty<Icon>.fromMap(<WidgetStatesConstraint, Icon>{
        WidgetState.selected: Icon(Icons.check),
        WidgetState.any: Icon(Icons.close),
      });

  // Color schemes
  static const Map<String, Color> _seedColors = {
    'blue': Colors.blue,
    'green': Colors.green,
    'orange': Colors.orange,
    'red': Colors.red,
    'teal': Colors.teal,
    'pink': Colors.pinkAccent,
    'lime': Colors.limeAccent,
  };

  static SystemUiOverlayStyle getSystemOverlayStyle({required bool isDark}) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: isDark
          ? Brightness.light
          : Brightness.dark,
      systemNavigationBarContrastEnforced: false,
    );
  }

  static const PageTransitionsTheme pageTransitionsTheme = PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: PredictiveBackPageTransitionsBuilder(
        allowSnapshotting: false,
      ),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.windows: ZoomPageTransitionsBuilder(
        allowSnapshotting: false,
      ),
      TargetPlatform.linux: ZoomPageTransitionsBuilder(
        allowSnapshotting: false,
      ),
    },
  );

  static ThemeData getTheme({
    required bool isDark,
    required String colorScheme,
    Color? customColor,
  }) {
    final Color seedColor = (colorScheme == 'custom' && customColor != null)
        ? customColor
        : (_seedColors[colorScheme] ?? Colors.blue);

    final scheme = SeedColorScheme.fromSeeds(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryKey: seedColor,
      variant: colorScheme == 'custom'
          ? FlexSchemeVariant.fidelity
          : FlexSchemeVariant.tonalSpot,
      respectMonochromeSeed: true,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      switchTheme: const SwitchThemeData(thumbIcon: switchThumbIcon),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: getSystemOverlayStyle(isDark: isDark),
      ),
      pageTransitionsTheme: pageTransitionsTheme,
    );
  }

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    switchTheme: const SwitchThemeData(thumbIcon: switchThumbIcon),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: getSystemOverlayStyle(isDark: false),
    ),
    pageTransitionsTheme: pageTransitionsTheme,
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    switchTheme: const SwitchThemeData(thumbIcon: switchThumbIcon),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: getSystemOverlayStyle(isDark: true),
    ),
    pageTransitionsTheme: pageTransitionsTheme,
  );

  static List<String> get availableColorSchemes => _seedColors.keys.toList();

  static Map<String, String> getColorSchemeDisplayNames(BuildContext context) =>
      {
        'blue': context.l10n.colorSchemeBlue,
        'green': context.l10n.colorSchemeGreen,
        'orange': context.l10n.colorSchemeOrange,
        'red': context.l10n.colorSchemeRed,
        'teal': context.l10n.colorSchemeTeal,
        'pink': context.l10n.colorSchemePink,
        'lime': context.l10n.colorSchemeLime,
      };

  static Color getSeedColor(String colorScheme) {
    return _seedColors[colorScheme] ?? Colors.blue;
  }
}
