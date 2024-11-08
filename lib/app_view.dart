import 'package:api_car_repository/api_car_repository.dart';
import 'package:design_test/bloc/get_car_bloc/get_car_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'main_screen.dart';

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
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
          primaryContainer: Color(0xFFACC5EA),
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
      home: BlocProvider(
        create:  (context) => GetCarBloc(ApiCarRepo())..add(GetCar()),
        child: const MainScreen(),
      ),
    );
  }
}

