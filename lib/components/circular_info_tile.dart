import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ElevatedButton.dart';


class CircularInfoTile extends StatelessWidget {
  const CircularInfoTile({
    super.key, required this.icon, required this.label, this.value = "", this.unit = "", this.iconSize = 24, this.bgColor, this.iconColor, this.axis = Axis.vertical,
  });

  final Widget icon;
  final double iconSize;
  final String label;
  final String value;
  final String unit;
  final Color? bgColor;
  final Color? iconColor;
  final Axis axis;


  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: axis,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircularElevatedButton(
          icon: icon,
          iconSize: iconSize,
          iconColor: iconColor,
          bgColor: bgColor,
          clickable: false,
          onPressed: null,
        ),
        SizedBox(width: axis == Axis.horizontal ? 12 : 0, height: axis == Axis.vertical ? 12 : 0),
        _TextSection(label: label, value: value, unit: unit, axis: axis,),
      ],
    );
  }
}

class _TextSection extends StatelessWidget {
  const _TextSection({required this.label, required this.value, required this.unit, required this.axis});

  final String label;
  final String value;
  final String unit;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: axis == Axis.horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface,
                fontSize: 15,
                fontWeight: FontWeight.w400),
          ),
          if (value.isNotEmpty) // Conditionally display value and unit
            Text(
              '$value $unit',
              style: GoogleFonts.teko(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              semanticsLabel: '$value $unit', // Add semantics label
            ),
        ],
      ),
    );
  }
}