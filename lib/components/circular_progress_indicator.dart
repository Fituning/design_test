import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'ElevatedButton.dart';

class CircularProgressSlider extends StatefulWidget {
  const CircularProgressSlider({super.key});

  @override
  State<CircularProgressSlider> createState() => _CircularProgressSliderState();
}

class _CircularProgressSliderState extends State<CircularProgressSlider> {
  var currentTemp = 24.5;
  var radialValue = 19.5; //bien déclarer la var avant le @override
  var power = false;
  var autoMode = false;
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
              CircularElevatedButton(
                icon: const FaIcon(FontAwesomeIcons.powerOff),
                onPressed:(){
                  setState(() {
                    power = !power;
                  });
                },
                iconSize: 44,value: power,),
              Positioned(
                  top: 24,
                  child: CircularElevatedButton(
                    icon: Text(
                        "AUTO",
                      style: TextStyle(
                        color: autoMode ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface
                      ),
                    ),
                    onPressed: (){
                      setState(() {
                        autoMode = !autoMode;
                        power = autoMode;
                      });
                    },
                    value: autoMode,
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    // enable: true,
                  )
              ),
            ])
    );
  }
}
