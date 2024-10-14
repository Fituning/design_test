import 'package:design_test/components/ElevatedButton.dart';
import 'package:design_test/pages/Clim.dart';
import 'package:design_test/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
      home: const Clim2(),
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

class CircularProgressSlider extends StatefulWidget {
  const CircularProgressSlider({super.key});

  @override
  State<CircularProgressSlider> createState() => _CircularProgressSliderState();
}

class _CircularProgressSliderState extends State<CircularProgressSlider> {
  var currentTemp = 24.5;
  var radialValue = 19.5; //bien déclarer la var avant le @override
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 270,
        height: 270,
        color: Theme.of(context).colorScheme.surface,
        child:
         Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 0,
                  child: Column(
                    children: [
                      Text(
                          "$radialValue°",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 32,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      Text(
                        "Température °C",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  )
              ),

              SizedBox(
                width: 270,
                height: 270,
                child: SfRadialGauge(
                            axes: <RadialAxis>[
                RadialAxis(
                  minimum: 15,
                  maximum: 30,
                  startAngle: 120,
                  endAngle: 60,
                  showLabels: false,
                  maximumLabels: 1,
                  showFirstLabel: false,
                  showLastLabel: false,
                  showTicks: false,
                  interval: 5,
                  radiusFactor: 1,
                  axisLineStyle:
                      const AxisLineStyle(cornerStyle: CornerStyle.bothCurve),
                  pointers: [
                    RangePointer(
                      value: radialValue,
                      cornerStyle: CornerStyle.bothCurve,
                      width: 8,
                      sizeUnit: GaugeSizeUnit.logicalPixel,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    MarkerPointer(
                      value: radialValue,
                      markerType: MarkerType.circle,
                      color: Theme.of(context).colorScheme.secondary,
                      borderColor: Theme.of(context).colorScheme.onPrimary,
                      borderWidth: 8,
                      markerHeight: 24,
                      markerWidth: 24,
                      enableDragging: true,
                      onValueChanged: (value) {
                        setState(() {
                          radialValue = (value * 2).round() / 2;
                        });
                      },
                    ),
                    // MarkerPointer(
                    //   value: currentTemp,
                    //   enableDragging: false,
                    //   markerType: MarkerType.rectangle,
                    //   color: Theme.of(context).colorScheme.primary,
                    //   markerWidth: 24,
                    //   markerHeight: 2,
                    //   markerOffset: -6,
                    //   text: "${currentTemp.toStringAsFixed(1)}°C",
                    // ),
                    // MarkerPointer(
                    //   value: currentTemp,
                    //   markerType: MarkerType.text,
                    //   text: "${currentTemp.toStringAsFixed(1)}°C",
                    //   markerOffset: -32,
                    //   textStyle: const GaugeTextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w600,
                    //       fontFamily: "Teko"),
                    // )
                  ],
                )
                            ],
                          ),
              ),
              CircularElevatedButton(icon: const FaIcon(FontAwesomeIcons.powerOff), onPressed:(){}, iconSize: 44,),
              Positioned(
                  top: 24,
                  child: CircularElevatedButton(
                    icon: Text("AUTO"),
                    onPressed: (){},
                    // enable: true,
                  )
              ),
        ])
    );
  }
}
