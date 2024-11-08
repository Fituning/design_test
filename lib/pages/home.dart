import 'package:api_car_repository/api_car_repository.dart';
import 'package:design_test/components/notification_overlay_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/get_car_bloc/get_car_bloc.dart';
import '../components/circular_info_tile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 13 / 24,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/map2.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "My Softcar".toUpperCase(),
                      style: GoogleFonts.teko(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: BlocBuilder<GetCarBloc, GetCarState>(
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Display extends StatelessWidget {
  final Car car;
  final bool showConnectionError; // Variable pour afficher ou non le message

  const _Display({
    super.key,
    required this.car,
    this.showConnectionError = false, // Valeur par défaut : false
  });

  @override
  Widget build(BuildContext context) {
    // Afficher le SnackBar si showConnectionError est true
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
        overlay?.insert(overlayEntry);

        // Retirer l'overlay après 3 secondes
        Future.delayed(const Duration(seconds: 3), () {
          overlayEntry.remove();
        });
      });
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CircularInfoTile(
            icon: const FaIcon(FontAwesomeIcons.batteryHalf),
            label: "Battery",
            value: car.battery.chargeLevel.toString(), // Utilisez la valeur de la batterie
            unit: "%",
            iconColor: car.battery.chargeLevel < 10
                ? Theme.of(context).colorScheme.onError
                : null,
            bgColor: car.battery.chargeLevel < 10
                ? Theme.of(context).colorScheme.error
                : null,
          ),
        ),
        Expanded(
          child: CircularInfoTile(
            icon: const FaIcon(FontAwesomeIcons.route),
            label: "Range",
            value: car.remainingRange.toString(), // Remplacez par car.range si vous avez cette propriété
            unit: "km",
            iconColor: car.remainingRange < 40
                ? Theme.of(context).colorScheme.onError
                : null,
            bgColor: car.remainingRange < 40
                ? Theme.of(context).colorScheme.error
                : null,
          ),
        ),
        Expanded(
          child: CircularInfoTile(
            icon: _getChargeIcon(
              car.chargingSocketIsConnected,
              car.chargeIsActivated,
            ),
            label: "Status",
            value: car.chargingSocketIsConnected
                ? (car.chargeIsActivated ? "Charging" : "Plugged")
                : "Unplugged", // Exemple de statut
            iconColor: !car.chargingSocketIsConnected
                ? Theme.of(context).colorScheme.onError
                : null,
            bgColor: !car.chargingSocketIsConnected
                ? Theme.of(context).colorScheme.error
                : null,
          ),
        ),
      ],
    );
  }

  Widget _getChargeIcon(bool chargingSocketIsConnected, bool chargeIsActivated) {
    if (chargingSocketIsConnected) {
      if (chargeIsActivated) {
        return const FaIcon(FontAwesomeIcons.bolt);
      } else {
        return const FaIcon(FontAwesomeIcons.plugCircleCheck);
      }
    } else {
      return const FaIcon(FontAwesomeIcons.plugCircleXmark);
    }
  }
}





