import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ElevatedButton.dart';

class CircularInfoTile extends StatelessWidget {
  const CircularInfoTile({
    super.key, required this.icon, required this.label, this.value = "", this.unit = "", this.iconSize = 24, this.bgColor, this.iconColor,
  });

  final Widget icon;
  final double iconSize;
  final String label;
  final String value;
  final String unit;
  final Color? bgColor;
  final Color? iconColor;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularElevatedButton(
          icon: icon,
          iconSize: iconSize,
          iconColor: iconColor,
          bgColor: bgColor,
          clickable: false, onPressed: null,
        ),
        const SizedBox(height: 12,),
        Text(
          label,
          style: GoogleFonts.roboto(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
        Text(
          "$value $unit",
          style: GoogleFonts.teko(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}