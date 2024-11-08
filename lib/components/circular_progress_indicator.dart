import 'package:api_car_repository/api_car_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../bloc/get_car_bloc/get_car_bloc.dart';
import 'ElevatedButton.dart';

class CircularProgressSlider extends StatefulWidget {
  const CircularProgressSlider({
    super.key,
  });

  @override
  State<CircularProgressSlider> createState() => _CircularProgressSliderState();
}

class _CircularProgressSliderState extends State<CircularProgressSlider> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCarBloc, GetCarState>(
      builder: (context, state) {
        // Vérifier si l'état est GetCarSuccess
        if (state is GetCarSuccess) {
          final car = state.car;
          return _buildContent(context, car);
        } else if (state is GetCarReLoadFailure) {
          final car = state.car;
          return _buildContent(context, car,);
        } else {
          return const Center(
            child: Text("An error has occurred while loading the car data"),
          );
        }
      },
    );
  }

  Widget _buildContent(BuildContext context, Car car) {
    return Container(
      width: 270,
      height: 270,
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                Text(
                  car.airConditioning.temperature.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Température °C",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
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
                  axisLineStyle: const AxisLineStyle(cornerStyle: CornerStyle.bothCurve),
                  pointers: [
                    RangePointer(
                      value: car.airConditioning.temperature.toDouble(),
                      cornerStyle: CornerStyle.bothCurve,
                      width: 8,
                      sizeUnit: GaugeSizeUnit.logicalPixel,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    MarkerPointer(
                      value: car.airConditioning.temperature.toDouble(),
                      markerType: MarkerType.circle,
                      color: Theme.of(context).colorScheme.secondary,
                      borderColor: Theme.of(context).colorScheme.onPrimary,
                      borderWidth: 8,
                      markerHeight: 24,
                      markerWidth: 24,
                      enableDragging: true,
                      onValueChangeEnd: (value) {
                        context.read<GetCarBloc>().add(
                            UpdateAirConditioning(temperature: car.airConditioning.temperature));
                      },
                      onValueChanged: (value) {
                        setState(() {
                          car.airConditioning.temperature = value.round();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          CircularElevatedButton(
            icon: const FaIcon(FontAwesomeIcons.powerOff),
            onPressed: () {
              setState(() {
                if (car.airConditioning.mode == AirConditioningModeEnum.off) {
                  car.airConditioning.mode = AirConditioningModeEnum.manuel;
                } else {
                  car.airConditioning.mode = AirConditioningModeEnum.off;
                }
              });

              context.read<GetCarBloc>().add(UpdateAirConditioning(mode: car.airConditioning.mode));
            },
            iconSize: 44,
            value: car.airConditioning.mode != AirConditioningModeEnum.off,
          ),
          Positioned(
            top: 24,
            child: CircularElevatedButton(
              icon: Text(
                "AUTO",
                style: TextStyle(
                  color: car.airConditioning.mode == AirConditioningModeEnum.auto
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (car.airConditioning.mode != AirConditioningModeEnum.auto) {
                    car.airConditioning.mode = AirConditioningModeEnum.auto;
                  } else {
                    car.airConditioning.mode = AirConditioningModeEnum.off;
                  }
                });
                context.read<GetCarBloc>().add(UpdateAirConditioning(mode: car.airConditioning.mode));
              },
              value: car.airConditioning.mode == AirConditioningModeEnum.auto,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }
}
