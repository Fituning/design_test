import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/TopNavBar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          color: Theme.of(context).colorScheme.surface,
          child: Container(
            child: Column(
              children: [
                Container(
                    height: 550,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/images/map.png", fit: BoxFit.cover,)
                ),
                Text(
                    "Ma Softcar".toUpperCase(),
                    style:  GoogleFonts.teko(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                ),
                Row(
                  children: [

                  ],
                )
              ],
            ),
          ),
        ),
        const Positioned(
            top: 0,
            left: 0,
            child: TopNavBar()
        ),
      ],
    );
  }
}
