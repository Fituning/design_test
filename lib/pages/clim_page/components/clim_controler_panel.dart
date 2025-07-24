import 'package:api_car_repository/api_car_repository.dart';
import 'package:design_test/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bloc/car_bloc/car_bloc.dart';
import 'Vent.dart';
import '../../../components/chip_button.dart';
import '../../../components/circular_progress_indicator.dart';

class ClimControllerPanel extends StatefulWidget {
  const ClimControllerPanel({
    super.key,
    required this.expandedHeight,
    required this.car,
  });

  final double expandedHeight;
  final Car car;

  @override
  State<ClimControllerPanel> createState() => _ClimControllerPanelState();
}

class _ClimControllerPanelState extends State<ClimControllerPanel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 76,
      ),
      child: ClipRRect(
        child: OverflowBox(
          alignment: Alignment.topCenter,
          maxHeight: widget.expandedHeight + 76,
          fit: OverflowBoxFit.max,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VentController(car: widget.car),
              const SizedBox(
                height: 38,
              ),
              CircularProgressSlider(car: widget.car),
              const SizedBox(
                height: 38,
              ),
              _displayACControls(context, widget.car)
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayACControls(BuildContext context, Car car) {
    return Padding(
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
              value: car.airConditioning.acIsActive,
              onPressed: () {
                setState(() {
                  car.airConditioning.acIsActive =
                      !car.airConditioning.acIsActive;
                });
                context.read<CarBloc>().add(UpdateAirConditioning(
                    acIsActive: car.airConditioning.acIsActive));
              },
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
                Assets.iconsDegAvant,
                height: 28,
              ),
              value: car.airConditioning.frontDefogging,
              onPressed: () {
                setState(() {
                  car.airConditioning.frontDefogging =
                      !car.airConditioning.frontDefogging;
                });
                context.read<CarBloc>().add(UpdateAirConditioning(
                    frontDefogging: car.airConditioning.frontDefogging));
              },
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
                Assets.iconsDegArriere,
                height: 28,
              ),
              value: car.airConditioning.backDefogging,
              onPressed: () {
                setState(() {
                  car.airConditioning.backDefogging =
                      !car.airConditioning.backDefogging;
                });
                context.read<CarBloc>().add(UpdateAirConditioning(
                    backDefogging: car.airConditioning.backDefogging));
              },
            ),
          ),
        ],
      ),
    );
  }
}
