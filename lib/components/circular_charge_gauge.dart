import 'package:api_car_repository/api_car_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'ElevatedButton.dart';

class CircularChargeGauge extends StatefulWidget {
  final Car car;
  const CircularChargeGauge( {
    super.key,
    required this.car,
  });

  @override
  State<CircularChargeGauge> createState() => _CircularChargeGaugeState();
}

class _CircularChargeGaugeState extends State<CircularChargeGauge> {
  // var currentTemp = 24.5;
  // var battery = 58.0; //bien déclarer la var avant le @override
  // var onCharge = false;
  // var hoodLock = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.car.chargingSocketIsConnected ? (widget.car.chargeIsActivated ? "Voiture en charge" : "Voiture branchée") : "Branchez la voiture",
          style: GoogleFonts.roboto(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12,),
        Container(
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
                            // textHeightBehavior: const TextHeightBehavior(leadingDistribution: TextLeadingDistribution.even),
                            widget.car.battery.chargeLevel.toString(),
                            // "58",
                            style: GoogleFonts.teko(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 100,
                                fontWeight: FontWeight.w600,
                                height: 0.65
                            ),
                          ),
                          Text(
                            "Batterie %",
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
                          minimum: 0,
                          maximum: 100,
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
                              value: widget.car.battery.chargeLevel.toDouble(),
                              cornerStyle: CornerStyle.bothCurve,
                              width: 8,
                              sizeUnit: GaugeSizeUnit.logicalPixel,
                              color: Theme.of(context).colorScheme.tertiary,
                              enableAnimation: true,
                              animationType: AnimationType.ease,
                              animationDuration: 3000,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      top: 12,
                      child: Column(
                        children: [
                          CircularElevatedButton(
                            icon: Text(
                              widget.car.hood == DoorStatusEnum.open ? 'capot ouvert' : 'capot fermé',
                              style: TextStyle(
                                  color: widget.car.hood == DoorStatusEnum.open ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface
                              ),
                            ),
                            onPressed: (){
                              // setState(() {
                              //   hoodLock = !hoodLock;
                              //   onCharge = hoodLock;
                              // });
                            },
                            value: widget.car.hood == DoorStatusEnum.open,
                            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                            // enable: true,
                          ),
                          const SizedBox(height: 6,),
                          CircularElevatedButton(
                            icon: const FaIcon(FontAwesomeIcons.plug),
                            iconClicked: const FaIcon(FontAwesomeIcons.bolt),
                            bgColor: Theme.of(context).colorScheme.surfaceContainerLow,
                            iconColor: Theme.of(context).colorScheme.tertiary,
                            padding: const EdgeInsets.all(24),
                            onPressed:(){
                              // setState(() {
                              //   onCharge = !onCharge;
                              // });
                            },
                            iconSize: 32,
                            value: widget.car.chargeIsActivated,
                          ),
                        ],
                      )
                  ),
                ])
        ),
      ],
    );
  }
}
