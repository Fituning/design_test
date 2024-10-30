import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Vent.dart';
import 'chip_button.dart';
import 'circular_progress_indicator.dart';

class ClimControllerPanel extends StatelessWidget {
  const ClimControllerPanel({
    super.key,
    required this.expandedHeight,
  });

  final double expandedHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 76,
      ),
      child: ClipRRect(
        child: OverflowBox(
          alignment: Alignment.topCenter,
          maxHeight: expandedHeight+76,
          fit: OverflowBoxFit.max,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const VentController(),
              const SizedBox(
                height: 38,
              ),
              const CircularProgressSlider(),
              const SizedBox(
                height: 38,
              ),
              // if (shrinkOffset < 90)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 44.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ChipButton(
                        icon: Text(
                          "AC",
                          style: GoogleFonts.roboto(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Container(
                      height: 28,
                      width: 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Expanded(
                      child: ChipButton(
                        icon: SvgPicture.asset(
                          "assets/images/deg_avant.svg",
                          height: 28,
                        ),
                      ),
                    ),
                    Container(
                      height: 28,
                      width: 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Expanded(
                      child: ChipButton(
                        icon: SvgPicture.asset(
                          "assets/images/deg_arriere.svg",
                          height: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}