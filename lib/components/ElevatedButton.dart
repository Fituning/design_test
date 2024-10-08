import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersoElavatedButton extends StatelessWidget {
  PersoElavatedButton(
  {
    super.key, required this.icon,this.bgColor
  });

  final FaIcon icon;
  Color? bgColor ;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(70)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                offset: Offset(0,2),
                spreadRadius: 0,
                blurRadius: 4),

          ],
        ),
        child: IconButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>( bgColor ?? Theme.of(context).colorScheme.surfaceContainerLow),
                shape: WidgetStateProperty.all(CircleBorder())
            ),

            alignment: Alignment.center,
            padding: EdgeInsets.all(16),
            onPressed: (){},
            icon: icon)
    );
  }
}