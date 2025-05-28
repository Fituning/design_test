import 'package:api_car_repository/api_car_repository.dart';
import 'package:design_test/bloc/car_bloc/car_bloc.dart';
import 'package:design_test/pages/select_car/car_picker.dart';
import 'package:design_test/pages/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
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
  void initState() {
    super.initState();
    // Déclencher l'événement GetUser au démarrage
    context.read<AuthBloc>().add(AuthStarted());
  }

  @override
  Widget build(BuildContext context) {

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
          onSecondary: Color(0xFFE9EFF8),
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

      home: BlocBuilder<AuthBloc, AuthState>(
          builder: ((context, state) {
            // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
            //     overlays: []);
            if (state.status == Authenticationstatus.authenticated) {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: [SystemUiOverlay.top]);
              return MultiBlocProvider(
                providers: [
                  // BlocProvider(
                  //   create: (context) => SignInBloc(
                  //       context.read<AuthenticationBloc>().userRepository),
                  // ),
                  BlocProvider(
                    create: (context) => CarBloc(ApiCarRepo(context.read<AuthBloc>().apiUserRepo))..add(GetCar()),
                  ),
                ],
                child: const MainScreen(),
              );
            }else if (state.status == Authenticationstatus.noCarSelected || state.status == Authenticationstatus.noCars){
              return const CarPicker();//todo refaire la page
            } else if (state.status == Authenticationstatus.unauthenticated){
              return const WelcomeScreen();
            }else{
              return const Center(child: CircularProgressIndicator());
            }
          })),
    );
  }
}

