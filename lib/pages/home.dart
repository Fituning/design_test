import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
              height: MediaQuery.of(context).size.height*13/24,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/map2.jpg",
                fit: BoxFit.cover,
              )),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 24,bottom: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "My Softcar".toUpperCase(),
                      style: GoogleFonts.teko(
                        color:
                        Theme.of(context).colorScheme.onSurface,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0),
                      // Ajoute du padding horizontal
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: CircularInfoTile(
                              icon: FaIcon(FontAwesomeIcons.batteryHalf),
                              label: "Battery",
                              value: "58",
                              unit: "%",
                            ),
                          ),
                          const Expanded(
                            child: CircularInfoTile(
                              icon: FaIcon(FontAwesomeIcons.route),
                              label: "Range",
                              value: "116",
                              unit: "km",
                            ),
                          ),
                          Expanded(
                            child: CircularInfoTile(
                              icon: const FaIcon(FontAwesomeIcons.bolt),
                              label: "Status",
                              value: "Unplugged",
                              iconColor: Theme.of(context).colorScheme.onTertiary,
                              bgColor: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ],
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


