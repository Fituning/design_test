import 'package:design_test/components/ElevatedButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/BottomNavBar.dart';
import '../components/TopNavBar.dart';
import '../components/circular_info_tile.dart';
import '../main.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircularElevatedButton(
        icon: const FaIcon(
          FontAwesomeIcons.unlock,
          size: 42,
        ),
        padding: EdgeInsets.all(24),
        bgColor: Theme.of(context).colorScheme.surfaceContainerLow, onPressed: () {  },
      ),
      floatingActionButtonLocation: CustomFabLocation(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  children: [
                    SizedBox(
                        height: 550,
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
                                        icon: FaIcon(FontAwesomeIcons.bolt),
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
              ),
              const Positioned(top: 0, left: 0, child: TopNavBar()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}


