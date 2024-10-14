import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  const VentController({super.key});

  @override
  State<VentController> createState() => _VentControllerState();
}

class _VentControllerState extends State<VentController> {
  int ventLevel = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularElevatedButton(
            icon: const FaIcon(FontAwesomeIcons.minus),
            onPressed: () {
              setState(() {
                ventLevel = max(minVentLevel, ventLevel - 1);
              });
            }),
        const SizedBox(width: 32,),
        VentLevelIndicator(ventLevel: ventLevel),
        const SizedBox(width: 32,),
        CircularElevatedButton(
            icon: const FaIcon(FontAwesomeIcons.plus),
            onPressed: () {
              setState(() {
                ventLevel = min(maxVentLevel, ventLevel + 1);
              });
            }),
      ],
    );
  }
}



class VentLevelIndicator extends StatefulWidget {
  const VentLevelIndicator({Key? key, required this.ventLevel}) : super(key: key);

  final int ventLevel;

  @override
  State<VentLevelIndicator> createState() => _VentLevelIndicatorState();
}

class _VentLevelIndicatorState extends State<VentLevelIndicator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/images/AirTurbine.svg",
          height: 33,
        ),
        const SizedBox(height: 6,),
        Row(
          children: [
            NotificationBadge(radius: 8, active: (widget.ventLevel >= 1), activeColor:  Theme.of(context).colorScheme.secondary, inactiveColor:  Theme.of(context).colorScheme.primaryContainer,),
            const SizedBox(width: 8,),
            NotificationBadge(radius: 8, active: (widget.ventLevel >= 2), activeColor:  Theme.of(context).colorScheme.secondary, inactiveColor:  Theme.of(context).colorScheme.primaryContainer,),
            const SizedBox(width: 8,),
            NotificationBadge(radius: 8, active: (widget.ventLevel >= 3), activeColor:  Theme.of(context).colorScheme.secondary, inactiveColor:  Theme.of(context).colorScheme.primaryContainer,),
          ],
        )
      ],
    );
  }
}