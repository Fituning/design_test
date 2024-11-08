import 'dart:async';
import 'dart:math';

import 'package:api_car_repository/api_car_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/car_bloc/car_bloc.dart';
import 'ElevatedButton.dart';
import 'NotifPastille.dart';

const int minVentLevel = 0;
int maxVentLevel = VentilationLevelEnum.values.length - 1;

class VentController extends StatefulWidget {
  const VentController({
    super.key,
    required this.car
  });

  final Car car;

  @override
  State<VentController> createState() => _VentControllerState();
}

class _VentControllerState extends State<VentController> {
  // VentilationLevelEnum ventLevel = VentilationLevelEnum.level2;
  Timer? _debounce; // Déclaration du Timer pour la logique de délai

  @override
  Widget build(BuildContext context) {
    Car car = widget.car;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularElevatedButton(
          icon: const FaIcon(FontAwesomeIcons.minus),
          onPressed: () {
            setState(() {
              // Mettre à jour l'état local
              car.airConditioning.ventilationLevel = VentilationLevelEnumExtension.fromInt(
                max(minVentLevel, car.airConditioning.ventilationLevel.index - 1),
              );
            });
            // Déclencher la requête avec un délai
            _onVentilationLevelChange(car.airConditioning.ventilationLevel.index);
          },
        ),
        const SizedBox(width: 32),
        _ventLevelIndicator(context,car.airConditioning.ventilationLevel.index),
        const SizedBox(width: 32),
        CircularElevatedButton(
          icon: const FaIcon(FontAwesomeIcons.plus),
          onPressed: () {
            setState(() {
              // Mettre à jour l'état local
              car.airConditioning.ventilationLevel = VentilationLevelEnumExtension.fromInt(
                min(maxVentLevel, car.airConditioning.ventilationLevel.index + 1),
              );
            });
            // Déclencher la requête avec un délai
            _onVentilationLevelChange(car.airConditioning.ventilationLevel.index);
          },
        ),
      ],
    );
  }

  //Pour mettre un delais avant d'envoyer la requete
  void _onVentilationLevelChange(int newLevel) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      context.read<CarBloc>().add(UpdateAirConditioning(
        ventilationLevel: VentilationLevelEnumExtension.fromInt(newLevel),
      ));
    });
  }

  Widget _ventLevelIndicator(BuildContext context, int ventLevel){
    return Column(
      children: [
        SvgPicture.asset(
          "assets/images/AirTurbine.svg",
          height: 33,
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            NotificationBadge(
              radius: 8,
              active: (ventLevel >= 1),
              activeColor: Theme.of(context).colorScheme.secondary,
              inactiveColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            const SizedBox(width: 8),
            NotificationBadge(
              radius: 8,
              active: (ventLevel >= 2),
              activeColor: Theme.of(context).colorScheme.secondary,
              inactiveColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            const SizedBox(width: 8),
            NotificationBadge(
              radius: 8,
              active: (ventLevel >= 3),
              activeColor: Theme.of(context).colorScheme.secondary,
              inactiveColor: Theme.of(context).colorScheme.primaryContainer,
            ),
          ],
        ),
      ],
    );
  }
}
