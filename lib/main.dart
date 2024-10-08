import 'package:design_test/components/ElevatedButton.dart';
import 'package:design_test/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/BottomNavBar.dart';
import 'components/TopNavBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]
    );
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
          shadow: Color(0x33020919),
          tertiary: Color(0xFF45E3B4),
          onTertiary: Color(0xFFF4F7FC),
          tertiaryContainer: Color(0xFFDAF9F0),
          primaryContainer: Color(0xFFD5E2F5),
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      home: const MySoftcar(),
    );
  }
}

class MySoftcar extends StatelessWidget {
  const MySoftcar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: PersoElavatedButton(icon: const FaIcon(FontAwesomeIcons.plus,size: 44,),bgColor: Theme.of(context).colorScheme.surfaceContainerLow,),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              color: Theme.of(context).colorScheme.surface,
              child: Home(),
            ),
            const Positioned(
                top: 0,
                left: 0,
                child: TopNavBar()
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}







