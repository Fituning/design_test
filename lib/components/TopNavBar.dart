import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:maps_launcher/maps_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'ElevatedButton.dart';
import 'dart:io';

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
          CircularElevatedButton(icon: const FaIcon(FontAwesomeIcons.locationArrow), onPressed: (){launchNavigationApp(context);},),
        ],
      ),
    );
  }
}

void launchMapOnAndroid(BuildContext context, double latitude, double longitude) async {
  try {
    const String markerLabel = 'Here';
    final url = Uri.parse(
        'geo:');
    await launchUrl(url);
  } catch (error) {
    if (context.mounted) {
      throw error.toString();
    }
  }
}

void lauchMapOnIOS(BuildContext context,double latitude,double longitude) async {
  try {
    final url = Uri.parse(
        'maps:');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  } catch (error) {
    if (context.mounted) {
      throw error.toString();
    }
  }
}



Future<void> launchNavigationApp(BuildContext context) async {
  try {
    Uri url;
    if (Platform.isAndroid) {
      url = Uri.parse('geo:');
      await launchUrl(url);
    } else if (Platform.isIOS) {
      url = Uri.parse('maps:');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      throw 'Platform not supported';
    }
  } catch (error) {
    if (context.mounted) {
      // Gestion de l'erreur, afficher un message ou autre action
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : ${error.toString()}')),
      );
    }
  }
}
