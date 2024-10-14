import 'package:design_test/components/ElevatedButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/BottomNavBar.dart';
import '../components/TopNavBar.dart';
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
        padding: 24,
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
                                    Expanded(
                                      child: Column(
                                        children: [
                                          const CircularElevatedButton(
                                            icon: FaIcon(
                                                FontAwesomeIcons.batteryHalf,
                                                size: 24),
                                            clickable: false, onPressed: null,
                                          ),
                                          const SizedBox(height: 12,),
                                          Text(
                                            "Batterie",
                                            style: GoogleFonts.roboto(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            "58%",
                                            style: GoogleFonts.teko(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          const CircularElevatedButton(
                                            icon: FaIcon(
                                                FontAwesomeIcons.route,
                                                size: 24),
                                            clickable: false, onPressed: null,
                                          ),
                                          const SizedBox(height: 12,),
                                          Text(
                                            "Autonomie",
                                            style: GoogleFonts.roboto(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            "285 km",
                                            style: GoogleFonts.teko(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          CircularElevatedButton(
                                            icon: FaIcon(
                                              FontAwesomeIcons.bolt,
                                              size: 24,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onTertiary,
                                            ),
                                            bgColor: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            clickable: false, onPressed: null,
                                          ),
                                          const SizedBox(height: 12,),
                                          Text(
                                            "Statut",
                                            style: GoogleFonts.roboto(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            "En charge",
                                            style: GoogleFonts.teko(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
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
