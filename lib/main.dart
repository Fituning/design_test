import 'package:design_test/pages/Charge.dart';
import 'package:design_test/pages/Clim.dart';
import 'package:design_test/pages/home.dart';
import 'package:design_test/pages/maintenance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/BottomNavBar.dart';
import 'components/ElevatedButton.dart';
import 'components/TopNavBar.dart';
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
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 2;
  @override
  Widget build(BuildContext context) {
    Widget page = const Home();
    Widget? floatingActionButton;
    FloatingActionButtonLocation floatingActionLocation = CustomFabLocation();
    switch (pageIndex) {
      case 0:
        page = const Maintenance();
        floatingActionButton = null;
        floatingActionLocation = FloatingActionButtonLocation.centerFloat;
        break;
      case 1:
        page = const Clim();
        floatingActionButton = CircularElevatedButton(
          icon: const FaIcon(
            FontAwesomeIcons.clock,
            size: 42,
          ),
          padding: const EdgeInsets.all(16),
          bgColor: Theme.of(context).colorScheme.surfaceContainerLow, onPressed: () {  },
        );
        floatingActionLocation = FloatingActionButtonLocation.centerFloat;
        break;
      case 2 :
        page = const Home();
        floatingActionButton = CircularElevatedButton(
          icon: const FaIcon(
            FontAwesomeIcons.unlock,
            size: 42,
          ),
          padding: const EdgeInsets.all(24),
          bgColor: Theme.of(context).colorScheme.surfaceContainerLow, onPressed: () {  },
        );
        floatingActionLocation = CustomFabLocation();
      case 4 :
        page = const Charge();
        floatingActionButton = CircularElevatedButton(
          icon: const FaIcon(
            FontAwesomeIcons.clock,
            size: 42,
          ),
          padding: const EdgeInsets.all(16),
          bgColor: Theme.of(context).colorScheme.surfaceContainerLow, onPressed: () {  },
        );
        floatingActionLocation = FloatingActionButtonLocation.centerFloat;
    }

    return Scaffold(
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionLocation,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // Image.asset(
              //   "assets/images/Screenshot_20241017-161950.png",
              //   width: MediaQuery.of(context).size.width,
              //   fit: BoxFit.fitWidth,
              //   alignment: Alignment.centerRight,
              // ),
              page,
              const Positioned(top: 0, left: 0, child: TopNavBar()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(pageIndex: pageIndex,onPageChanged: (value){
        if(value != 3){
          setState(() {
            pageIndex = value;
          });
        }
      }),
    );
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
        scaffoldGeometry.scaffoldSize.height*13/24);
  }
}

