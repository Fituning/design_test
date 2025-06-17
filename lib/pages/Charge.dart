import 'package:api_car_repository/api_car_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../bloc/car_bloc/car_bloc.dart';
import '../components/circular_charge_gauge.dart';
import '../components/circular_info_tile.dart';
import '../components/notification_overlay_bar.dart';
import '../utils/date_time.dart';

class Charge extends StatelessWidget {
  const Charge({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 76, left: 16, right: 16,),
        child: ClipRRect(
          child: OverflowBox(
            fit: OverflowBoxFit.deferToChild,
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                BlocBuilder<CarBloc, CarState>(
                  builder: (context, state) {
                    if(state is GetCarSuccess){
                      final car = state.car;
                      return _Display(car: car,);
                    }else if(state is GetCarReLoadFailure){
                      final car = state.car;
                      return _Display(car: car,showConnectionError: true,);
                    }else {
                      return const Center(child: Text("An error has occurred while loading home page"));
                    }
                  },
                ),
                Expanded(child: Image.asset(
                  "assets/images/softcar_top.png",
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topCenter,
                ))
              ],

            ),
          ),
        )
    );
  }
}

class _Display extends StatelessWidget {
  final Car car;
  final bool showConnectionError;
  const _Display({
    required this.car,
    this.showConnectionError = false,
  });

  @override
  Widget build(BuildContext context) {
    double spacing = 24;

    if (showConnectionError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final overlay = Overlay.of(context);
        final overlayEntry = OverlayEntry(
            builder: (context) => NotificationOverlayBar(
              message: "Connexion impossible au serveur",
              icon: FaIcon(
                  FontAwesomeIcons.triangleExclamation,
                color: Theme.of(context).colorScheme.onError,
                size: 34,
              ),
            )
        );

        // Insérer l'overlay
        overlay.insert(overlayEntry);

        // Retirer l'overlay après 3 secondes
        Future.delayed(const Duration(seconds: 3), () {
          overlayEntry.remove();
        });
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: spacing/2,),
        CircularChargeGauge(car: car,),
        SizedBox(height: spacing,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Expanded(
                  child: CircularInfoTile(
                    icon: const FaIcon(FontAwesomeIcons.chargingStation),
                    label: "Temps de charge",
                    value:  formatHourMinute(car.battery.chargingTime),
                    // unit: "min",
                  )
              ),
              Expanded(
                  child: CircularInfoTile(
                    icon: const FaIcon(FontAwesomeIcons.route),
                    label: "Autonomie",
                    value: car.remainingRange.toString(),
                    unit: "km",
                  )
              ),
            ],
          ),
        ),
        SizedBox(height: spacing/2,),
        // OverflowBox(fit: OverflowBoxFit.deferToChild, alignment: Alignment.topCenter, maxHeight: 600 ,child: Container(color: Colors.cyan,width: 350,height: 600,)),
      ],
    );
  }
}








