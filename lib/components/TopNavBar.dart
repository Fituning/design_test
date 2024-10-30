import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ElevatedButton.dart';

class TopNavBar extends StatelessWidget {
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularElevatedButton(icon: const FaIcon(FontAwesomeIcons.bars,),onPressed: (){},),
          const CircularElevatedButton(icon: FaIcon(FontAwesomeIcons.locationArrow), onPressed: openNavigationApp,),
        ],
      ),
    );
  }
}




Future<void> openNavigationApp() async {
  final Uri url = Uri.parse('geo:'); // Lien générique pour ouvrir l'app de navigation

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Impossible d\'ouvrir l\'application de navigation par défaut';
  }
}

