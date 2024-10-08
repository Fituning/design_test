import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ElevatedButton.dart';

class TopNavBar extends StatelessWidget {
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PersoElavatedButton(icon: FaIcon(FontAwesomeIcons.bars,size: 28)),
          PersoElavatedButton(icon: FaIcon(FontAwesomeIcons.locationArrow,size: 28)),
        ],
      ),
    );
  }
}

