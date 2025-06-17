import 'package:design_test/components/circular_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Maintenance extends StatelessWidget {
  const Maintenance({super.key});

  @override
  Widget build(BuildContext context) {
    double scale = 0.75;
    return Padding(
      padding: const EdgeInsets.only(top: 76, bottom: 12),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Ma Softcar'.toUpperCase(),
            style: GoogleFonts.teko(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    // Ajuster la position pour centrer l'image par rapport au bord gauche
                    left: -MediaQuery.of(context).size.width * scale / 2,
                    // Décalage de la moitié de la largeur de l'image
                    child: Container(
                      child: Image.asset(
                        "assets/images/softcar_top_interior.png",
                        width: MediaQuery.of(context).size.width * scale,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * scale * 10 / 24,
                      right: 6.0),
                  child: SizedBox(
                    height:
                        MediaQuery.of(context).size.height * scale * 15 / 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircularInfoTile(
                          icon: FaIcon(FontAwesomeIcons.road),
                          axis: Axis.horizontal,
                          label: "Kilomètres parcourus",
                          value: "12450",
                          unit: "km",
                        ),
                        const CircularInfoTile(
                          icon: FaIcon(FontAwesomeIcons.heartCircleBolt),
                          axis: Axis.horizontal,
                          label: "Etat de la batterie",
                          value: "92",
                          unit: "%",
                        ),
                        CircularInfoTile(
                          icon: const FaIcon(FontAwesomeIcons.wrench),
                          axis: Axis.horizontal,
                          label: "Prochain entretien",
                          value: "692",
                          unit: "km",
                          bgColor: Theme.of(context).colorScheme.error,
                          iconColor: Theme.of(context).colorScheme.onError,
                        ),
                        const CircularInfoTile(
                          icon: FaIcon(FontAwesomeIcons.chargingStation),
                          axis: Axis.horizontal,
                          label: "Consomation Moyenne",
                          value: "1.2",
                          unit: "Wh/km",
                        ),
                        const CircularInfoTile(
                          icon: FaIcon(FontAwesomeIcons.download),
                          axis: Axis.horizontal,
                          label: "Statut du Software",
                          value: "A jour",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 42,
          ),
          Text(
            'VIN : 12345'.toUpperCase(),
            style: GoogleFonts.roboto(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
