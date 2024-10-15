import 'package:design_test/pages/Charge.dart';
import 'package:design_test/pages/Clim.dart';
import 'package:design_test/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

    //initializeDateFormatting(findSystemLocale().toString());
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          brightness: Brightness.light,
          primary: Color(0xFF081C3D),
          onPrimary: Color(0xFFF4F7FC),
          secondary: Color(0xFF2F6ECB),
          onSecondary: Color(0xFFF4F7FC),
          error: Color(0xFFF55555),
          onError: Color(0xFFF4F7FC),
          errorContainer: Color(0xFFFFC400),
          onErrorContainer: Color(0xFF081C3D),
          surface: Color(0xFFFCFDFE),
          onSurface: Color(0xFF081C3D),
          surfaceContainerLowest: Color(0xFFFBFCFE),
          surfaceContainerLow: Color(0xFFF7F9FD),
          surfaceContainer: Color(0xFFF3F7FC),
          surfaceContainerHigh: Color(0xFFEFF4FB),
          surfaceContainerHighest: Color(0xFFEBF1FA),
          shadow: Color(0x66020919),
          tertiary: Color(0xFF45E3B4),
          onTertiary: Color(0xFFF4F7FC),
          tertiaryContainer: Color(0xFFDAF9F0),
          primaryContainer: Color(0xFFD5E2F5),
        ),
        useMaterial3: true,
      ),
      // locale : const Locale('fr'), // to delete for language system
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      themeMode: ThemeMode.light,
      home: const Charge(),
    );
  }
}

class MySoftcar extends StatelessWidget {
  const MySoftcar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

class CustomFabLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    // Taille du FAB
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;

    // Obtenir la taille de la barre inférieure
    final double bottomBarHeight = scaffoldGeometry.scaffoldSize.height;

    // Position personnalisée : ici, je le place en bas à gauche, avec un décalage de 20px du bas et de la gauche
    return Offset(
        scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width -
            16,
        550);
  }
}

