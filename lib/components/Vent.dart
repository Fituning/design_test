import 'dart:math';

import 'package:api_car_repository/api_car_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/get_car_bloc/get_car_bloc.dart';
import 'ElevatedButton.dart';
import 'NotifPastille.dart';

const int minVentLevel = 0;
const int maxVentLevel = 3;



class VentController2 extends StatefulWidget {
  const VentController2({
    super.key,
  });

  @override
  State<VentController2> createState() => _VentControllerState2();
}

class _VentControllerState2 extends State<VentController2> {
  var ventLevel = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularElevatedButton(icon: const FaIcon(FontAwesomeIcons.minus), onPressed: (){
          if(ventLevel >0){
            ventLevel -= 1;
          }
          print(ventLevel);
        }),
        const SizedBox(width: 32,),
        Column(
          children: [
            SvgPicture.asset(
              "assets/images/AirTurbine.svg",
              height: 33,
            ),
            const SizedBox(height: 6,),
            Row(
              children: [
                NotificationBadge(radius: 8,activeColor: (ventLevel >= 1) ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primaryContainer,),
                const SizedBox(width: 8,),
                NotificationBadge(radius: 8,activeColor: (ventLevel >= 2) ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primaryContainer,),
                const SizedBox(width: 8,),
                NotificationBadge(radius: 8,activeColor: (ventLevel >= 3) ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primaryContainer,),
              ],
            )
          ],
        ),
        const SizedBox(width: 32,),
        CircularElevatedButton(icon: const FaIcon(FontAwesomeIcons.plus), onPressed: (){
          if(ventLevel <3){
            ventLevel += 1;
          }
        }),
      ],
    );
  }
}


class VentController extends StatefulWidget {
  const VentController({
    super.key,
  });

  @override
  State<VentController> createState() => _VentControllerState();
}

class _VentControllerState extends State<VentController> {
  // int ventLevel = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCarBloc, GetCarState>(
      builder: (context, state) {
        // Vérifier si l'état est GetCarSuccess
        if (state is GetCarSuccess) {
          final car = state.car;
          return _display(context, car);
        } else if (state is GetCarReLoadFailure) {
          final car = state.car;
          return _display(context, car);
        } else {
          return const Center(
            child: Text("An error has occurred while loading the car data"),
          );
        }
      },
    );
  }

  Widget _display(BuildContext context, Car car){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularElevatedButton(
            icon: const FaIcon(FontAwesomeIcons.minus),
            onPressed: () {
              // setState(() {
              //   ventLevel = max(minVentLevel, ventLevel - 1);
              // });
              setState(() {
                car.airConditioning.ventilationLevel = VentilationLevelEnumExtension.fromInt(max(minVentLevel, car.airConditioning.ventilationLevel.index - 1));
              });
              context.read<GetCarBloc>().add(UpdateAirConditioning(ventilationLevel: car.airConditioning.ventilationLevel));
            }),
        const SizedBox(width: 32,),
        VentLevelIndicator(ventLevel: car.airConditioning.ventilationLevel.index),
        const SizedBox(width: 32,),
        CircularElevatedButton(
            icon: const FaIcon(FontAwesomeIcons.plus),
            onPressed: () {
              setState(() {
                car.airConditioning.ventilationLevel = VentilationLevelEnumExtension.fromInt(min(maxVentLevel, car.airConditioning.ventilationLevel.index + 1));
              });
              context.read<GetCarBloc>().add(UpdateAirConditioning(ventilationLevel: car.airConditioning.ventilationLevel));
            }
            ),
      ],
    );
  }
}



class VentLevelIndicator extends StatelessWidget {
  const VentLevelIndicator({super.key, required this.ventLevel});

  final int ventLevel;

  @override
  Widget build(BuildContext context) {
    print(ventLevel);
    return Column(
      children: [
        SvgPicture.asset(
          "assets/images/AirTurbine.svg",
          height: 33,
        ),
        const SizedBox(height: 6,),
        Row(
          children: [
            NotificationBadge(radius: 8, active: (ventLevel >= 1), activeColor:  Theme.of(context).colorScheme.secondary, inactiveColor:  Theme.of(context).colorScheme.primaryContainer,),
            const SizedBox(width: 8,),
            NotificationBadge(radius: 8, active: (ventLevel >= 2), activeColor:  Theme.of(context).colorScheme.secondary, inactiveColor:  Theme.of(context).colorScheme.primaryContainer,),
            const SizedBox(width: 8,),
            NotificationBadge(radius: 8, active: (ventLevel >= 3), activeColor:  Theme.of(context).colorScheme.secondary, inactiveColor:  Theme.of(context).colorScheme.primaryContainer,),
          ],
        )
      ],
    );
  }
}